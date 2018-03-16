//
//  UIViewController+MMScrollViewCtronller.m
//  NewProject
//
//  Created by admin on 2018/3/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UIViewController+MMScrollViewCtronller.h"
#import <objc/runtime.h>

@implementation UIViewController (MMScrollViewCtronller)
@dynamic MMScrollView;
- (UITableView *)MMScrollView {
    UITableView *tableView = objc_getAssociatedObject(self, @selector(MMScrollView));
    if (tableView) {
        return tableView;
    }
    if ([self.view isMemberOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.view;
        objc_setAssociatedObject(self, @selector(MMScrollView), tableView, OBJC_ASSOCIATION_ASSIGN);
    } else {
        for (UIView *view in self.view.subviews) {
            if ([view isMemberOfClass:[UITableView class]] && CGSizeEqualToSize(view.frame.size, self.view.frame.size)) {
                objc_setAssociatedObject(self, @selector(MMScrollView), tableView, OBJC_ASSOCIATION_ASSIGN);
                break;
            }
        }
    }
    return objc_getAssociatedObject(self, @selector(MMScrollView));
}

@end
