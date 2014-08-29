//
//  ManualViewController.h
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/18.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManualViewController : UIViewController

@property (nonatomic, strong) IBOutlet  UIWebView *webView;
@property (nonatomic, copy)             NSString  *contentType;

@end
