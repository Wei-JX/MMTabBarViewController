//
//  UIAlertView+Block.h
//  DondibuyShopping
//
//  Created by gsw on 14-10-21.
//  Copyright (c) 2014年 gsw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AlertViewButtonActionBlock)(NSInteger);
@interface UIAlertView (Block)
-(void)showAlertViewWithBlock:(AlertViewButtonActionBlock)alertViewButtonActionBlock;
@end
