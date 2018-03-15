//
//  UIActionSheet+Block.h
//  DondibuyShopping
//
//  Created by howard on 14/11/11.
//  Copyright (c) 2014年 howard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionSheetButtonActionBlock)(NSInteger buttonIndex);

@interface UIActionSheet (Block)
- (void)showInView:(UIView *)view
   withActionBlock:(ActionSheetButtonActionBlock)actionSheetButtonActionBlock;

@end
