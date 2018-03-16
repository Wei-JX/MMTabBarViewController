//
//  MMViewController.h
//  NewProject
//
//  Created by admin on 2018/3/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTableViewController.h"

@protocol MMTableViewDelegate <NSObject>
@optional
- (NSUInteger)numberOfMMTableViewControllers;
- (MMTableViewController *)MMTableViewControllerWithIndex:(NSUInteger)index;
- (UIView *)MMTableHeaderView;
@end
@interface MMViewController : UIViewController

@property (nonatomic, weak) id<MMTableViewDelegate> delegate;






@end
