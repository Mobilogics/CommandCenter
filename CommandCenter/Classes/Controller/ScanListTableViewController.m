//
//  ScanHistoryTableViewController.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/16.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "ScanListTableViewController.h"
#import "Barcodes.h"

@interface ScanListTableViewController ()

@end

@implementation ScanListTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];

  if (self) {
    // Custom initialization
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIBarButtonItem *cleanButton = [[UIBarButtonItem alloc] initWithTitle:@"Clean" style:UIBarButtonItemStyleBordered target:self action:@selector(clean)];
  self.navigationItem.leftBarButtonItem = cleanButton;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[Barcodes sharedInstance] items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier" forIndexPath:indexPath];
  
  NSMutableArray *array = [[[Barcodes sharedInstance] items] objectAtIndex:[indexPath row]];
  
  if (array) {
    cell.textLabel.text = array[0];
    cell.detailTextLabel.text = array[1];
  }
  
  return cell;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  switch (buttonIndex) {
    case 0:
      [alertView dismissWithClickedButtonIndex:0 animated:YES];
      break;
      
    case 1:
      [alertView dismissWithClickedButtonIndex:1 animated:YES];
      [[Barcodes sharedInstance] removeAllItems];
      [[self tableView] reloadData];
      break;
      
    default:
      break;
  }
}

#pragma mark - private

- (void)clean {
  if ([[[Barcodes sharedInstance] items] count] < 1) {
    return;
  }
  
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete all?"
                                           message           :@""
                                           delegate          :self
                                           cancelButtonTitle :@"Cancel"
                                           otherButtonTitles :@"OK", nil];
  [alertView show];
}

@end
