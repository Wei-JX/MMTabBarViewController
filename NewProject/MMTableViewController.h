//
//  MMTableViewController.h
//  NewProject
//
//  Created by admin on 2018/3/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, readonly) UITableView *tableView;

@property (nonatomic, assign) UITableViewStyle style;
@end
