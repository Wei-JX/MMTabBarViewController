//
//  ViewController.m
//  NewProject
//
//  Created by admin on 2018/3/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "MMViewController.h"
#import "SMMTableViewController.h"

@interface ViewController ()<MMTableViewDelegate>
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
    MMViewController * mmViewController = [[MMViewController alloc] init];
    mmViewController.delegate = self;
    [self presentViewController:mmViewController animated:YES completion:^{
        
    }];
}

- (NSUInteger)numberOfMMTableViewControllers {
    return 4;
}

- (UIViewController *)MMTableViewControllerWithIndex:(NSUInteger)index {
    if (index ==0) {
        SMMTableViewController * aaa = [SMMTableViewController new];
        aaa.view.backgroundColor = [UIColor grayColor];
        return aaa;
    }
    else if (index ==1){
        SMMTableViewController * aaa = [SMMTableViewController new];
        aaa.index = 1;
        aaa.view.backgroundColor = [UIColor grayColor];
        return aaa;
    } else if (index ==2) {
        UIViewController * aaa = [UIViewController new];
        aaa.view.backgroundColor = [UIColor blueColor];
        return aaa;
    }else {
        UIViewController * aaa = [UIViewController new];
        aaa.view.backgroundColor = [UIColor orangeColor];
        return aaa;
    }
}


- (UIView *)MMTableHeaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
    view.backgroundColor = [UIColor orangeColor];
    return view;
    
}
- (void)qqBtnClicked {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
