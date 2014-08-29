//
//  Barcodes.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/12.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "Barcodes.h"

@interface Barcodes ()

- (NSString *)getDateString;
- (void)getItems;
- (NSString *)getStoreFilePathWithFileName:(NSString *)fileName;
- (BOOL)save;

@end

@implementation Barcodes

+ (id)sharedInstance {
  DEFINE_SHARED_INSTANCE_USING_BLOCK (^{
    return [[self alloc] init];
  })
}

- (id)init {
  self = [super init];

  if (self) {
    [self items];
  }

  return self;
}

#pragma mark - public

- (NSMutableArray *)items {
  if (!items) {
    [self getItems];
  }

  return items;
}

- (void)addItem:(NSString *)barcode {
  NSArray *array = [[NSArray alloc] initWithObjects:barcode, [self getDateString], nil];

  [items insertObject:array atIndex:0];

  if ([items count] > 100) {
    [items removeLastObject];
  }

  [self save];
}

- (void)removeItems:(NSUInteger)index {
  [items removeObjectAtIndex:index];
  [self save];
}

- (void)removeAllItems {
  [items removeAllObjects];
  [self save];
}

#pragma mark - private

- (BOOL)save {
  NSString  *storePath = [self getStoreFilePathWithFileName:BARCODE_STORE_NAME];
  BOOL      isStoreSuccess = [items writeToFile:storePath atomically:YES];

  if (!isStoreSuccess) {
    // NSLog(@"file create error");
  }

  return isStoreSuccess;
}

- (NSString *)getDateString {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

  [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
  return [formatter stringFromDate:[NSDate date]];
}

- (NSString *)getStoreFilePathWithFileName:(NSString *)fileName {
  NSArray   *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString  *retString = nil;

  if ([paths count] > 0) {
    NSString *userDocumentsPath = [paths objectAtIndex:0];
    retString = [userDocumentsPath stringByAppendingPathComponent:fileName];
  }

  return retString;
}

- (void)getItems {
  NSString *storePath = [self getStoreFilePathWithFileName:BARCODE_STORE_NAME];

  items = [NSMutableArray arrayWithContentsOfFile:storePath];

  if (!items) {
    items = [[NSMutableArray alloc] initWithCapacity:30];
  }
}

@end
