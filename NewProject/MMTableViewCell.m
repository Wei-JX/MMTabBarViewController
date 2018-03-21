//
//  MMTableViewCell.m
//  NewProject
//
//  Created by admin on 2018/3/20.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MMTableViewCell.h"
#import <Masonry.h>

@interface MMTableViewCell()
@property (nonatomic ,strong) UIImageView *avatarView;
@property (nonatomic ,strong) UILabel *nameTitle;
@property (nonatomic ,strong) UILabel *content;
@property (nonatomic ,strong) UILabel *backContent;
@property (nonatomic ,strong) UILabel *timerHitTitle;;
@property (nonatomic ,strong) UIView *replayBackView;
@property (nonatomic ,strong) UIButton *avatarBtn;
@property (nonatomic ,strong) UIColor *blueColor;
@end

@implementation MMTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];

    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.nameTitle];
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.content];
    [self.contentView addSubview:self.timerHitTitle];
    [self.contentView addSubview:self.avatarBtn];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@15);
        make.width.height.equalTo(@50);
    }];
    [self.avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.avatarView);
    }];
    
    [self.nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(21);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(75);
        make.right.equalTo(self.contentView).with.offset(-15);
        make.top.equalTo(self.contentView).with.offset(45);
    }];
    
    [self.timerHitTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(24);
        make.right.equalTo(self.contentView).with.offset(-15);
        make.height.equalTo(@12);
    }];
    [self configDynamicCommentWithModel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)configDynamicCommentWithModel {
    self.nameTitle.text = @"haha";
    self.content.text = @"我勒哥擦";
}

#pragma action


- (UILabel *)nameTitle {
    if (!_nameTitle) {
        _nameTitle = [[UILabel alloc] init];
        _nameTitle.textColor = [UIColor blackColor];
        _nameTitle.font = [UIFont systemFontOfSize:14];
    }
    return _nameTitle;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        _avatarView.backgroundColor = [UIColor redColor];
        _avatarView.layer.cornerRadius = 4.0f;
        _avatarView.layer.masksToBounds = YES;
    }
    
    return _avatarView;
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.textColor = [UIColor blackColor];
        _content.font = [UIFont systemFontOfSize:14];
    }
    return _content;
}

- (UILabel *)backContent {
    if (!_backContent) {
        _backContent = [[UILabel alloc] init];
        _backContent.numberOfLines = 0;
        _backContent.textColor = [UIColor blackColor];
        _backContent.font = [UIFont systemFontOfSize:12];
    }
    return _backContent;
}

- (UIButton *)avatarBtn {
    if (!_avatarBtn) {
        _avatarBtn = [[UIButton alloc] init];
        _avatarBtn.backgroundColor = [UIColor clearColor];
    }
    return _avatarBtn;
}

- (UIView *)replayBackView {
    if (!_replayBackView) {
        _replayBackView = [[UIView alloc] init];
        _replayBackView.backgroundColor = [UIColor yellowColor];
        _replayBackView.layer.cornerRadius = 4.0f;
        _replayBackView.layer.masksToBounds = YES;
    }
    return _replayBackView;
}

- (UILabel *)timerHitTitle {
    if (!_timerHitTitle) {
        _timerHitTitle = [[UILabel alloc] init];
        _timerHitTitle.textColor = [UIColor redColor];
        _timerHitTitle.font = [UIFont systemFontOfSize:10];
    }
    return _timerHitTitle;
}

@end
