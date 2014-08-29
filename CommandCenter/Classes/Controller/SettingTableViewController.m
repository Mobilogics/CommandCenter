//
//  SettingTableViewController.m
//  CommandCenter
//
//  Created by Evan Wu on 2014/6/12.
//  Copyright (c) 2014年 Evan Wu. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];

  if (self) {
    // Custom initialization
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 1;
  }

  return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"Auto Switch URL Link";

    case 1:
      return @"URL Link";

    default:
      break;
  }
  return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;

  switch (indexPath.section) {
    case 0: {
      cell = [tableView dequeueReusableCellWithIdentifier:@"autoswitch" forIndexPath:indexPath];
      
      NSString *autoSwitchString = [[NSUserDefaults standardUserDefaults] objectForKey:@"Setting_AUTOSWITCH"];
      if (autoSwitchString && [autoSwitchString isEqualToString:@"YES"]) {
        [(UISwitch *)[cell viewWithTag:100] setOn:YES];
      } else {
        [(UISwitch *)[cell viewWithTag:100] setOn:NO];
      }
    }
      break;
    case 1: {
      cell = [tableView dequeueReusableCellWithIdentifier:@"url" forIndexPath:indexPath];
      
      NSString *labeltext;
      switch (indexPath.row) {
        case 0:
          labeltext = @"Google";
          break;
        case 1:
          labeltext = @"Amazon";
          break;
        case 2:
          labeltext = @"Walmart";
        default:
          break;
      }
      UILabel *label = (UILabel *)[cell viewWithTag:100];
      label.text = labeltext;
      
      NSString *row = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectLink"];
      if (row && [row isEqualToString:[NSString stringWithFormat:@"%d", (int)[indexPath row]]]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
      } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
      }
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

  switch ([indexPath section]) {
    case 1: {
      NSString *url = @"";
      switch ([indexPath row]) {
        case 0:
          url = @"http://www.google.com/m/search?q=@@";
          break;
        case 1:
          url = @"http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=@@";
          break;
        case 2:
          url = @"http://www.walmart.com/search/search-ng.do?search_query=@@&ic=48_0&Find=Find&search_constraint=0";
          break;
        default:
          break;
      }
      
      [[NSUserDefaults standardUserDefaults] setValue:url forKey:@"WEBLINK"];
      
      NSString *row = [NSString stringWithFormat:@"%d", (int)[indexPath row]];
      [[NSUserDefaults standardUserDefaults] setValue:row forKey:@"SelectLink"];
      [[NSUserDefaults standardUserDefaults] synchronize];
      [tableView reloadData];
    }
      break;

    default:
      break;
  }
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
}

#pragma mark - private

- (IBAction)saveAutoswitchSetting:(id)sender {
  UISwitch *autoSwitch = (UISwitch *)sender;
  if ([autoSwitch isOn]) {
    [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"Setting_AUTOSWITCH"];
  } else {
    [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"Setting_AUTOSWITCH"];
  }

  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
