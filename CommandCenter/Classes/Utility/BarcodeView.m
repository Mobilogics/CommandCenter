//
//  BarcodeView.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/17.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "BarcodeView.h"

@interface BarcodeView() {
  CGFloat centerX;
  CGFloat centerY;
  CGFloat beganX;
  __block BOOL isPlayAnimation;
}

@property (nonatomic, strong) UILabel *label;

@end

@implementation BarcodeView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    self.label.text = @"";
    self.label.textColor = [UIColor greenColor];
    self.label.backgroundColor = [UIColor clearColor];
    [self addSubview:self.label];

    [self.label setFont:[UIFont boldSystemFontOfSize:26.0]];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setNumberOfLines:5];
    
    centerX = self.label.center.x;
    centerY = self.label.center.y;
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  
  self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  self.label.text = @"";
  self.label.textColor = [UIColor greenColor];
  self.label.backgroundColor = [UIColor clearColor];
  [self addSubview:self.label];
  
  [self.label setFont:[UIFont boldSystemFontOfSize:26.0]];
  [self.label setTextAlignment:NSTextAlignmentCenter];
  [self.label setNumberOfLines:5];
  
  centerX = self.label.center.x;
  centerY = self.label.center.y;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setBarcode:(NSString *)barcode {
  self.label.text = barcode;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if (!isPlayAnimation) {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    beganX = touchPoint.x;
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  if (!isPlayAnimation) {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    if (location.x > centerX) {
      return;
    }
    
    CGPoint point = CGPointMake(location.x, centerY);
    self.label.center = point;
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  if (isPlayAnimation) {
    return;
  }
  
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  
  CGFloat x = location.x;
  
  if (x < beganX - 50) {
    [UILabel animateWithDuration:0.7f animations:^{
      isPlayAnimation = YES;
      [self.label setCenter:CGPointMake(-self.frame.size.width, centerY)];
      [UILabel commitAnimations];
    } completion:^(BOOL finished) {
      isPlayAnimation = NO;
      CGPoint point = CGPointMake(centerX, centerY);
      self.label.center = point;
      self.label.text = @"";
    }];
  } else {
    CGPoint point = CGPointMake(centerX, centerY);
    self.label.center = point;
  }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint point = CGPointMake(centerX, centerY);
  self.label.center = point;
}

@end
