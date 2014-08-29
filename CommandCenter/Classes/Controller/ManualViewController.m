//
//  ManualViewController.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/18.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "ManualViewController.h"

@interface ManualViewController ()

@end

@implementation ManualViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSString *path;
  if ([self.contentType isEqualToString:@"aScan"]) {
    path = [[NSBundle mainBundle] pathForResource:@"ascan_manual" ofType:@"pdf"];
  } else if ([self.contentType isEqualToString:@"iPDT5"]) {
    path = [[NSBundle mainBundle] pathForResource:@"ipdt5_manual" ofType:@"pdf"];
  }
  NSURL *targetURL = [NSURL fileURLWithPath:path];
  NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
  [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
