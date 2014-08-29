//
//  InfoScoreViewController.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/16.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "InfoScrollViewController.h"

@interface InfoScrollViewController ()

@end

@implementation InfoScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  CGFloat scrollViewWidth = self.scrollView.frame.size.width;
  CGFloat scrollViewHeight = self.scrollView.frame.size.height;
  CGSize contentSize = CGSizeMake(scrollViewWidth * 3, scrollViewHeight - 64);
  [self.scrollView setContentSize:contentSize];
  
  NSArray *images;
  if ([self.contentType isEqualToString:@"H2S"]) {
    images = @[[UIImage imageNamed:@"H2S0"], [UIImage imageNamed:@"H2S1"], [UIImage imageNamed:@"H2S2"]];
  } else if ([self.contentType isEqualToString:@"products"]) {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
      images = @[[UIImage imageNamed:@"product0"], [UIImage imageNamed:@"product1"], [UIImage imageNamed:@"product2"]];
    } else {
      images = @[[UIImage imageNamed:@"product0_ipad"], [UIImage imageNamed:@"product1_ipad"], [UIImage imageNamed:@"product2_ipad"]];
    }
  }
  
  for (int i = 0; i < images.count; i++) {
    UIImageView *iv = [[UIImageView alloc] initWithImage:(UIImage *)images[i]];
    [iv setFrame:CGRectMake(scrollViewWidth * i, -64, scrollViewWidth, scrollViewHeight)];
    [self.scrollView addSubview:iv];
  }
  
  if ([self.contentType isEqualToString:@"products"]) {
    UIButton *linkButton;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
      linkButton = [[UIButton alloc] initWithFrame:CGRectMake(scrollViewWidth * 2 + 20, 223, 280, 35)];
    } else {
      linkButton = [[UIButton alloc] initWithFrame:CGRectMake(scrollViewWidth * 2 + 90, 516, 570, 40)];
    }
    
    [linkButton addTarget:self action:@selector(linkbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:linkButton];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  CGFloat pageWidth = scrollView.frame.size.width;
  uint page = scrollView.contentOffset.x / pageWidth;
  [self.pageControl setCurrentPage:page];
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

#pragma mark - private

- (void)linkbuttonClick:(id)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mobilogics.com.tw"]];
}

@end
