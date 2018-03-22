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
//子Vc个数
- (NSUInteger)numberOfMMTableViewControllers;
//根据下标获取子VC
- (MMTableViewController *)MMTableViewControllerWithIndex:(NSUInteger)index;

//设置headerView，如果有的话
- (UIView *)MMTableHeaderView;

////////////////////////////////////////////////
///////////////////////////////////////////////
//横行滚动的items，设置数量
- (NSInteger)numbersOfTabBar;

//横行滚动的items，设置名字，数组形式
- (NSArray *)titlesForTabBar;

//横行滚动的items，每个item的大小size
- (CGSize)sizeOfTabBarToBound;

//横行滚动的items，根据scrollview滚动设置item滚动
- (void)scrollToNotifyTabBar:(float)offset;

@end

@interface MMViewController : UIViewController

////////获取Item尺寸
- (CGSize)getCollectionViewItemSize;

//重新加载
- (void)reloadTabBarVC;

- (void)scrollToIndex:(NSInteger)index;

//delegate

@property (nonatomic, weak) id<MMTableViewDelegate> delegate;






@end
