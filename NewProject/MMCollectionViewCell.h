//
//  MMCollectionViewCell.h
//  NewProject
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameTitle;
@property (nonatomic, strong) UIView *lineView;
- (void)setItemSelected:(BOOL)isSelected;

@end
