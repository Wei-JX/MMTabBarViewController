//
//  MMTabBarViewController.h
//  NewProject
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MMTabBarViewControllerDelegate <NSObject>
@optional
- (void)tabBarScrollToIndex:(NSInteger)index;
- (NSInteger)numberOfItems;
- (NSArray *)MMTabBarTitleArrays;
@end

@interface MMTabBarViewController : UIView

@property (nonatomic ,weak) id<MMTabBarViewControllerDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame ViewController:(UIViewController *)viewController;
- (void)scrollToNotifyTabBar:(NSInteger)index;
@end
