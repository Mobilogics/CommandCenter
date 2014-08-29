//
//  WebViewController.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/12.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - public

- (void)requestWithBarcode:(NSString *)barcode {
  NSString *urlString = [[NSUserDefaults standardUserDefaults] objectForKey:@"WEBLINK"];

  if (!urlString || [urlString isEqualToString:@""]) {
    return;
  }

  [self.webview stopLoading];

  NSString *url = [urlString stringByReplacingOccurrencesOfString:@"@@" withString:barcode];
  [self requestWithURL:[NSURL URLWithString:url]];
}

#pragma mark - private

- (void)requestWithURL:(NSURL *)url {
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  [self.webview loadRequest:request];
}

@end
