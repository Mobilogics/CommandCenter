//
//  FirstViewController.h
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/11.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarcodeView.h"

@interface ScanViewController : UIViewController <ReceiveCommandHandler, NotificationHandler>

@property (nonatomic, assign) IBOutlet UILabel      *batteryLabel;
@property (nonatomic, assign) IBOutlet UIImageView  *connectLight;
@property (nonatomic, assign) IBOutlet UIImageView  *batteryImageView;
@property (nonatomic, assign) IBOutlet UIImageView  *transparentImageView;
@property (nonatomic, assign) IBOutlet UIView       *vibrateView;
@property (nonatomic, assign) IBOutlet UIButton     *vibrateButton;
@property (nonatomic, assign) IBOutlet UIButton     *scanButton;
@property (nonatomic, strong) IBOutlet BarcodeView  *barcodeView;

- (IBAction)toggleButton:(id)sender;
- (IBAction)vibrateChange:(id)sender;
- (IBAction)vibrate0Clcik:(id)sender;
- (IBAction)vibrate1Clcik:(id)sender;
- (IBAction)vibrate2Clcik:(id)sender;
- (IBAction)vibrate3Clcik:(id)sender;

- (void)setBlock:(void(^) (NSString * barcode))block;

@end
