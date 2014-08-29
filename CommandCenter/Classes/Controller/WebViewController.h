//
//  WebViewController.h
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/12.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webview;

- (void)requestWithBarcode:(NSString *)barcode;

@end
