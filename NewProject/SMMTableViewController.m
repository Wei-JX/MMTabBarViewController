//
//  SMMTableViewController.m
//  NewProject
//
//  Created by admin on 2018/3/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SMMTableViewController.h"
#import <Masonry.h>
#import "MMTableViewCell.h"

@interface SMMTableViewController ()

@end

@implementation SMMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    CGRect frame = self.tableView.frame;
    frame.size.height -=64;
    self.tableView.frame = frame;
    [self.tableView registerClass:[MMTableViewCell class] forCellReuseIdentifier:@"MMTableViewCell"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.index;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MMTableViewCell" forIndexPath:indexPath];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
