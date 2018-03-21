//
//  MMCollectionViewCell.m
//  NewProject
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MMCollectionViewCell.h"
#import <Masonry.h>

@implementation MMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      //  [self setUI];
        self.nameTitle = [[UILabel alloc] init];
        self.nameTitle.textColor = [UIColor blackColor];
        self.nameTitle.font = [UIFont systemFontOfSize:14];
        self.nameTitle.textAlignment = NSTextAlignmentCenter;
        self.nameTitle.text =  @"123";
        [self.contentView addSubview:self.nameTitle];

            [self.nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.contentView);
            }];
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = [UIColor blueColor];
        self.lineView.hidden = YES;
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).with.offset(5);
            make.right.equalTo(self.contentView).with.offset(-5);
            make.height.equalTo(@4);
        }];
        
    }
    return self;
}

- (void)setItemSelected:(BOOL)isSelected {
    if (isSelected) {
        self.nameTitle.font = [UIFont systemFontOfSize:18];
        self.nameTitle.textColor = [UIColor blueColor];
    } else {
        self.nameTitle.font = [UIFont systemFontOfSize:14];
        self.nameTitle.textColor = [UIColor blackColor];
    }
    self.lineView.hidden = !isSelected;
}

- (void)setUI {

    
//    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//    }];
    
}
@end
