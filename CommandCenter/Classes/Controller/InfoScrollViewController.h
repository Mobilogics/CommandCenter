//
//  InfoScoreViewController.h
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/16.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet  UIScrollView    *scrollView;
@property (nonatomic, strong) IBOutlet  UIPageControl   *pageControl;
@property (nonatomic, copy)             NSString        *contentType;

@end
