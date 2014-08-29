//
//  FirstViewController.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/11.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "ScanViewController.h"
#import "Barcodes.h"

@interface ScanViewController () {
  id _block;
}

@end

@implementation ScanViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [[MLScanner sharedInstance] addAccessoryDidConnectNotification:self];
  [[MLScanner sharedInstance] addAccessoryDidDisconnectNotification:self];
  [[MLScanner sharedInstance] addReceiveCommandHandler:self];

  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
    [self setNeedsStatusBarAppearanceUpdate];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [self checkConnected];
  if ([[UIScreen mainScreen] bounds].size.height == 480) {
    [self.transparentImageView setCenter:CGPointMake(self.transparentImageView.center.x, self.transparentImageView.center.y - 48)];
    [self.barcodeView setCenter:CGPointMake(self.barcodeView.center.x, self.barcodeView.center.y - 48)];
    [self.scanButton setCenter:CGPointMake(self.scanButton.center.x, self.scanButton.center.y - 68)];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  [[MLScanner sharedInstance] removeReceiveCommandHandler:self];
  [[MLScanner sharedInstance] removeAccessoryDidConnectNotification:self];
  [[MLScanner sharedInstance] removeAccessoryDidDisconnectNotification:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleDefault;
}

#pragma mark - NotificationHandler

- (void)connectNotify {
  [self checkConnected];
}

- (void)disconnectNotify {
  [self checkConnected];
}

#pragma mark - ReceiveCommandHandler

- (BOOL)isHandler:(NSObject <ReceiveCommandProtocol> *)command {
  if ([command isKindOfClass:[ReceiveCommand class]]) {
    return TRUE;
  }

  return FALSE;
}

- (void)handleRequest:(NSObject <ReceiveCommandProtocol> *)command {
  if ([[command receiveString] isEqualToString:@""]) {
    return;
  }

  NSString *barcode = [[command receiveString] stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
  [self.barcodeView setBarcode:barcode];

  ((void (^)(NSString *barcode))_block)(barcode);

  [[Barcodes sharedInstance] addItem:[barcode copy]];
}

- (void)handleInformationUpdate {
  [self.batteryLabel setText:[NSString stringWithFormat:@"%d%%", [[MLScanner sharedInstance] powerRemainPercent]]];

  [self checkBatteryPercentageImage];
  [self checkVibrateImage];
}

- (void)handleLowPower {}

#pragma mark - action

- (IBAction)toggleButton:(id)sender {  
  if ([[MLScanner sharedInstance] isConnected]) {
    [[MLScanner sharedInstance] scan];
  }
}

- (IBAction)vibrateChange:(id)sender {
  [self.view bringSubviewToFront:self.vibrateView];
}

- (IBAction)vibrate0Clcik:(id)sender {
  [[MLScanner sharedInstance] vibraMotorStrength:0];
  [self.view sendSubviewToBack:self.vibrateView];
  [self.vibrateButton setImage:[UIImage imageNamed:@"vibrate0"] forState:UIControlStateNormal];
}

- (IBAction)vibrate1Clcik:(id)sender {
  [[MLScanner sharedInstance] vibraMotorStrength:1];
  [self.view sendSubviewToBack:self.vibrateView];
  [self.vibrateButton setImage:[UIImage imageNamed:@"vibrate1"] forState:UIControlStateNormal];
}

- (IBAction)vibrate2Clcik:(id)sender {
  [[MLScanner sharedInstance] vibraMotorStrength:2];
  [self.view sendSubviewToBack:self.vibrateView];
  [self.vibrateButton setImage:[UIImage imageNamed:@"vibrate2"] forState:UIControlStateNormal];
}

- (IBAction)vibrate3Clcik:(id)sender {
  [[MLScanner sharedInstance] vibraMotorStrength:3];
  [self.view sendSubviewToBack:self.vibrateView];
  [self.vibrateButton setImage:[UIImage imageNamed:@"vibrate3"] forState:UIControlStateNormal];
}

#pragma mark - public

- (void)setBlock:(void (^)(NSString *barcode))block {
  _block = block ? [block copy] : [NSNull null];
}

#pragma mark - private

- (void)checkConnected {
  if ([[MLScanner sharedInstance] isConnected]) {
    [self performSelector:@selector(connectInfo) withObject:nil afterDelay:1.0f];
  } else {
    [self.connectLight setImage:[UIImage imageNamed:@"disconnect"]];
    [self.batteryLabel setHidden:YES];
    [self.batteryImageView setHidden:YES];
    [self.vibrateButton setHidden:YES];
  }
}

- (void)connectInfo {
  [[MLScanner sharedInstance] updateAccessoryInfo];
  [self.connectLight setImage:[UIImage imageNamed:@"connect"]];
  [self.batteryLabel setHidden:NO];
  [self.batteryImageView setHidden:NO];
  [self.vibrateButton setHidden:NO];
}

- (void)checkBatteryPercentageImage {
  int batteryPercentage = [[MLScanner sharedInstance] powerRemainPercent];

  if (batteryPercentage > 89) {
    [self.batteryImageView setImage:[UIImage imageNamed:@"battery100"]];
  } else if (batteryPercentage > 79) {
    [self.batteryImageView setImage:[UIImage imageNamed:@"battery80"]];
  } else if (batteryPercentage > 59) {
    [self.batteryImageView setImage:[UIImage imageNamed:@"battery60"]];
  } else if (batteryPercentage > 39) {
    [self.batteryImageView setImage:[UIImage imageNamed:@"battery40"]];
  } else if (batteryPercentage > 19) {
    [self.batteryImageView setImage:[UIImage imageNamed:@"battery20"]];
  } else {
    [self.batteryImageView setImage:[UIImage imageNamed:@"battery0"]];
  }
}

- (void)checkVibrateImage {
  switch ([[MLScanner sharedInstance] vibraMotorStrength]) {
    case 0:
      [self.vibrateButton setImage:[UIImage imageNamed:@"vibrate0"] forState:UIControlStateNormal];
      break;

    case 1:
      [self.vibrateButton setImage:[UIImage imageNamed:@"vibrate1"] forState:UIControlStateNormal];
      break;

    case 2:
      [self.vibrateButton setImage:[UIImage imageNamed:@"vibrate2"] forState:UIControlStateNormal];
      break;

    case 3:
      [self.vibrateButton setImage:[UIImage imageNamed:@"vibrate3"] forState:UIControlStateNormal];
      break;

    default:
      break;
  }
}

@end
