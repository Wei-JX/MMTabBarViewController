//
//  ViewController.m
//  NewProject
//
//  Created by admin on 2018/3/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic ,strong)UIButton *wxBtn;
@property (nonatomic ,strong)UIButton *qqBtn;
@property (nonatomic ,strong)UIButton *wbBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wxBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.wxBtn.backgroundColor = [UIColor blueColor];
    [self.wxBtn addTarget:self action:@selector(xwBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wxBtn];
    
    self.qqBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    self.qqBtn.backgroundColor = [UIColor blueColor];
    [self.qqBtn addTarget:self action:@selector(qqBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qqBtn];
}

- (void)xwBtnClicked {
    
}

- (void)qqBtnClicked {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
