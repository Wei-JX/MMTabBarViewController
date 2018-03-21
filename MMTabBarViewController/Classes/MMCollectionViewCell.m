//
//  MMCollectionViewCell.m
//  NewProject
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MMCollectionViewCell.h"
#import <Masonry.h>

@interface MMCollectionViewCell()
@property (nonatomic ,strong)UIColor *color;
@end
@implementation MMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      //  [self setUI];
        self.color = [UIColor colorWithRed:29.0f / 255.0f
                                         green:154.0f / 255.0f
                                          blue:255.0f / 255.0f
                                         alpha:1];
        self.nameTitle = [[UILabel alloc] init];
        self.nameTitle.textColor = self.color;
        self.nameTitle.font = [UIFont systemFontOfSize:14];
        self.nameTitle.textAlignment = NSTextAlignmentCenter;
        self.nameTitle.text =  @"123";
        [self.contentView addSubview:self.nameTitle];

            [self.nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.contentView);
            }];
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = self.color;
        self.lineView.hidden = YES;
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).with.offset(-1);
            make.left.equalTo(self.contentView).with.offset(8);
            make.right.equalTo(self.contentView).with.offset(-8);
            make.height.equalTo(@3);
        }];
        
    }
    return self;
}

- (void)setItemSelected:(BOOL)isSelected {
    if (isSelected) {
        self.nameTitle.font = [UIFont systemFontOfSize:18];
        self.nameTitle.textColor = self.color;
    } else {
        self.nameTitle.font = [UIFont systemFontOfSize:14];
        self.nameTitle.textColor = [UIColor blackColor];
    }
    self.lineView.hidden = !isSelected;
}

@end
