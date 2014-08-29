//
//  AppDelegate.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/11.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "AppDelegate.h"
#import "ScanViewController.h"
#import "WebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [[MLScanner sharedInstance] setup];
  [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_background"]];
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selectTabbar"]];
  } else {
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"command_center_ui_ipad_tabselect"]];
  }
  

  UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
    [tabBarController.tabBar setTranslucent:NO];
  }

  ScanViewController  *scanViewController = (ScanViewController *)tabBarController.viewControllers[0];
  WebViewController   *webviewController = (WebViewController *)tabBarController.viewControllers[2];
  [scanViewController setBlock:^(NSString *barcode) {
    NSString *autoSwitch = [[NSUserDefaults standardUserDefaults] objectForKey:@"Setting_AUTOSWITCH"];

    if (autoSwitch && [autoSwitch isEqualToString:@"YES"]) {
      [webviewController requestWithBarcode:barcode];
      [tabBarController setSelectedIndex:2];
    }
  }];

  [tabBarController setSelectedIndex:0];
  [tabBarController setSelectedIndex:2];
  [tabBarController setSelectedIndex:0];

  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
