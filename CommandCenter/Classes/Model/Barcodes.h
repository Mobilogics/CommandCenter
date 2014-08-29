//
//  Barcodes.h
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/12.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Barcodes : NSObject {
  NSMutableArray *items;
}

- (NSMutableArray *)items;
- (void)addItem:(NSString *)barcode;
- (void)removeItems:(NSUInteger)index;
- (void)removeAllItems;

+ (id)sharedInstance;

@end
