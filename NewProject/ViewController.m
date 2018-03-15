//
//  ViewController.m
//  NewProject
//
//  Created by admin on 2018/3/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic ,strong)UIButton *blueBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.blueBtn.backgroundColor = [UIColor blueColor];
    [self.blueBtn addTarget:self action:@selector(abccc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.blueBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

//- (void)abccc {
//    NSArray *aaa = @[@"1",@"2",@"3"];
//    NSString *bb = [aaa objectAtIndex:5];
//    NSLog(@"");
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
