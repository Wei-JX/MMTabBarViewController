//
//  MMTabBarViewController.m
//  NewProject
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MMTabBarViewController.h"
#import "MMCollectionViewCell.h"
#import "MMViewController.h"

@interface MMTabBarViewController () <UICollectionViewDelegate, UICollectionViewDataSource,MMTableViewDelegate>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,weak) MMViewController *viewController;
@property (nonatomic ,strong) UIView * plugin;
@end

@implementation MMTabBarViewController {
    NSInteger _chooseIndex;
    CGFloat _itemWidth;
}

- (instancetype)initWithFrame:(CGRect)frame ViewController:(UIViewController *)viewController
{
    
    if (self = [super initWithFrame:frame]) {
        _viewController = (MMViewController *)viewController;
        _chooseIndex = 0;
        //_viewController.delegate  = self;
        [self setUI];
        
    }
    return self;
}

- (void)setUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(50, 40);
    _itemWidth = 50;
    self.collectionView =
    [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40) collectionViewLayout:layout];
    [self.collectionView registerClass:[MMCollectionViewCell class]
                   forCellWithReuseIdentifier:@"MMCollectionViewCellIdenter"];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    [self.collectionView addSubview:self.plugin];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.delegate MMTabBarTitleArrays].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MMCollectionViewCellIdenter" forIndexPath:indexPath];
    cell.nameTitle.text = [self.delegate MMTabBarTitleArrays][indexPath.row];
    if (indexPath.row == _chooseIndex) {
        [cell setItemSelected:YES];
    } else {
        [cell setItemSelected:NO];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate tabBarScrollToIndex:indexPath.row];
    
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    CGRect rectInScrollView = [self.collectionView convertRect:cell.frame toView:self.collectionView];
//    CGFloat inScrollX = rectInScrollView.origin.x;
//    CGFloat itemX = [self.collectionView convertRect:rectInScrollView toView:[self.collectionView superview]].origin.x;
//
//    CGPoint offset = collectionView.contentOffset;
//    CGFloat chaX = collectionView.bounds.size.width/2 ;
//
//    CGFloat itemCentX = (_itemWidth*indexPath.row + _itemWidth/2);
//    CGFloat chaItemX = itemCentX - chaX;
//
//    if (chaItemX <0) {
//        offset.x = 0;
//    } else {
//        offset.x = chaItemX;
//    }
//
//
////    CGFloat offX = itemX - chaX;
////    offset.x += offX;
////    if (offset.x <0) {
////        offset.x = 0;
////    }
//    if (offset.x > (collectionView.contentSize.width-collectionView.bounds.size.width)) {
//        offset.x = (collectionView.contentSize.width-collectionView.bounds.size.width);
//    }
//    [collectionView setContentOffset:offset animated:YES];
//    self.collectionView.scrollsToTop = YES;
    
   // [self setCollectViewItemWithIndex:indexPath.row];
}

- (void)scrollToNotifyTabBar:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    CGRect rectInScrollView = [self.collectionView convertRect:cell.frame toView:self.collectionView];
    CGFloat itemX = [self.collectionView convertRect:rectInScrollView toView:[self.collectionView superview]].origin.x;
    
    CGPoint offset = self.collectionView.contentOffset;
    CGFloat chaX = self.collectionView.bounds.size.width/2;
    ///
    CGFloat itemCentX = (_itemWidth*index + _itemWidth/2);
    CGFloat chaItemX = itemCentX - chaX;
    
    if (chaItemX <0) {
        offset.x = 0;
    } else {
        offset.x = chaItemX;
    }
    
    ////
//    CGFloat offX = itemX - chaX;
//    offset.x += offX;
//    if (offset.x < 0) {
//        offset.x = 0;
//    }
    if (offset.x > (self.collectionView.contentSize.width-self.collectionView.bounds.size.width)) {
        offset.x = (self.collectionView.contentSize.width-self.collectionView.bounds.size.width);
    }
    [self.collectionView setContentOffset:offset animated:YES];
    self.collectionView.scrollsToTop = YES;
    [self setCollectViewItemWithIndex:index];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)setCollectViewItemWithIndex:(NSInteger)index {
    _chooseIndex = index;
    [self.collectionView reloadData];
//    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
//    MMCollectionViewCell *newCell = (MMCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:newIndexPath];
//    [newCell setItemSelected:YES];
//    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForItem:_chooseIndex inSection:0];
//    MMCollectionViewCell *oldCell = (MMCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:oldIndexPath];
//    [oldCell setItemSelected:NO];
//    _chooseIndex = index;
}

- (UIView *)plugin {
    if (!_plugin) {
        _plugin = [[UIView alloc] initWithFrame:CGRectMake(5, 30, 0, 0)];
        _plugin.backgroundColor = [UIColor blueColor];
    }
    return _plugin;
}

@end
