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

@interface ViewController ()<MMTableViewDelegate,UINavigationControllerDelegate>
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
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mmViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
  // [self presentViewController:mmViewController animated:YES completion:^{
        
//}];
}

- (NSUInteger)numberOfMMTableViewControllers {
    return 60;
}

- (UIViewController *)MMTableViewControllerWithIndex:(NSUInteger)index {
    if (index ==0) {
        SMMTableViewController * aaa = [SMMTableViewController new];
        aaa.index = 2;
        aaa.view.backgroundColor = [UIColor grayColor];
        return aaa;
    }
    else if (index ==1){
        SMMTableViewController * aaa = [SMMTableViewController new];
        aaa.index = 30;
        aaa.view.backgroundColor = [UIColor grayColor];
        return aaa;
    } else if (index ==2) {
        SMMTableViewController * aaa = [SMMTableViewController new];
        aaa.index = 2;
        aaa.view.backgroundColor = [UIColor grayColor];
        return aaa;
    }else {
        SMMTableViewController * aaa = [SMMTableViewController new];
        aaa.index = 20;
        aaa.view.backgroundColor = [UIColor grayColor];
        return aaa;
    }
}

- (CGSize)sizeOfTabBarToBound {
    return CGSizeMake(50, 40);
}

- (NSArray *)titlesForTabBar {
    return @[@"gew",@"wf",@"个个",@"各位",@"广告",@"广告",@"个人过",@"酷云",@"鸡同",@"一天",@"犹太",@"今天",@"就突然",@"姜",@"不热",@"个人",@"和融",@"过热",@"王强",@"广告人",@"过热",@"好热好",@"问我",@"好热",@"绯闻",@"呵人",@"黄日",@"热狗",@"热河",@"好热",@"请问",@"企鹅",@"好热",@"研究",@"可以",];
}

- (UIView *)MMTableHeaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*920/1520)];
    view.backgroundColor = [UIColor orangeColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
    [imageView setImage:[UIImage imageNamed:@"saber.jpg"]];
    [view addSubview:imageView];
    return view;
    
}
- (void)qqBtnClicked {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
