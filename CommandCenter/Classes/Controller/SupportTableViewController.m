//
//  TableViewController.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/17.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "SupportTableViewController.h"
#import "InfoScrollViewController.h"
#import "ManualViewController.h"

@interface SupportTableViewController ()

@end

@implementation SupportTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 1;
    case 1:
      return 3;
    case 2:
      return 1;
    default:
      break;
  }
  
  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"Version";
      
    case 1:
      return @"Help";
      
    case 2:
      return @"About Us";
      
    default:
      break;
  }
  return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  
  switch (indexPath.section) {
    case 0: {
      cell = [tableView dequeueReusableCellWithIdentifier:@"version" forIndexPath:indexPath];
      UILabel *label = (UILabel *)[cell viewWithTag:100];
      label.text = [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    }
      break;
    case 1:{
      NSString *labeltext;
      switch (indexPath.row) {
        case 0:
          cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier" forIndexPath:indexPath];
          labeltext = @"How to scan?";
          break;
        case 1:
          cell = [tableView dequeueReusableCellWithIdentifier:@"Manual_Cell" forIndexPath:indexPath];
          labeltext = @"aScan user's manual";
          break;
        case 2:
          cell = [tableView dequeueReusableCellWithIdentifier:@"Manual_Cell" forIndexPath:indexPath];
          labeltext = @"iPDT5 user's manual";
        default:
          break;
      }
      UILabel *label = (UILabel *)[cell viewWithTag:100];
      label.text = labeltext;
    }
      break;
    case 2: {
      cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier" forIndexPath:indexPath];
      UILabel *label = (UILabel *)[cell viewWithTag:100];
      label.text = @"Products";
    }
      break;
    default:
      break;
  }
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"showInfo"]) {
    InfoScrollViewController *detailViewController = (InfoScrollViewController *)segue.destinationViewController;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    switch (indexPath.section) {
      case 1:
        detailViewController.contentType = @"H2S";
        break;
      case 2:
        detailViewController.contentType = @"products";
        break;
      default:
        break;
    }
  } else if ([segue.identifier isEqualToString:@"showPDF"]) {
    ManualViewController *detailViewController = (ManualViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    switch (indexPath.row) {
      case 1:
        detailViewController.contentType = @"aScan";
        break;
      case 2:
        detailViewController.contentType = @"iPDT5";
        break;
      default:
        break;
    }
  }
}

@end
