//
//  MMViewController.m
//  NewProject
//
//  Created by admin on 2018/3/15.
//  Copyright © 2018年 牛逼人. All rights reserved.
//

////////
//主tabBar控制器
///////

#define MINOFFSET 10

#import "MMViewController.h"
#import "MMTableViewController.h"
#import "UIViewController+MMScrollViewCtronller.h"
#import "SMMTableViewController.h"
#import "MMTabBarViewController.h"

@interface MMViewController () <UIScrollViewDelegate,MMTabBarViewControllerDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) NSMutableArray *vieControllers;
@property (nonatomic ,strong) NSMapTable *mapTable;
@property (nonatomic ,strong) NSMapTable *kvoTable;
@property (nonatomic ,strong) UIView *headerView;
@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) MMTabBarViewController*tabBar;
@end

@implementation MMViewController {
    CGFloat _horizonOffset;
    CGFloat _headerHeight;
    NSUInteger _curIndx;
    CGFloat _curOffsetX;
    CGFloat _tabBarHeight;
    CGFloat _lastOffY;
}

- (instancetype)init {
    if (self = [super init]) {
        _horizonOffset = 0.0f;
        _curIndx = 0;
        self.vieControllers = [NSMutableArray array];
        self.mapTable =
        [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableWeakMemory];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeBottom;
    self.title = @"Bar控制器";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.backView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backView.backgroundColor = [UIColor clearColor];
    self.backView.clipsToBounds = YES;
    self.backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.backView];
    [self.scrollView setBackgroundColor:[UIColor whiteColor]];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.backView.bounds];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delaysContentTouches = NO;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    NSUInteger vcNumbers = [self.delegate numberOfMMTableViewControllers];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width *vcNumbers , self.scrollView.bounds.size.height);
    [self.backView addSubview:self.scrollView];

    [self loadTabItems];
    [ self loadHeaderView ];
    [self loadViews];
}

- (void)dealloc {
    [self removeKVO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)removeKVO {
    [_vieControllers enumerateObjectsUsingBlock:^(MMTableViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITableView *tableView = obj.tableView;
        [tableView removeObserver:self forKeyPath:@"contentOffset"];
    }];
}

#pragma delegete--

- (void)scrollToIndex:(NSInteger)index {
    if (index == _curIndx) {
        return;
    }
    [self tabBarScrollToIndex:index];
}

- (CGSize)getCollectionViewItemSize {
    return [self.delegate sizeOfTabBarToBound];
}
- (NSArray *)MMTabBarTitleArrays {
    return [self.delegate titlesForTabBar];
}

- (NSInteger)numberOfItems {
    return [self.delegate numbersOfTabBar];
}

- (void)viewDidAppear:(BOOL)animated {
    NSUInteger vcNumbers = [self.delegate numberOfMMTableViewControllers];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width *vcNumbers , self.scrollView.bounds.size.height);
    // [self loadViews];
}

- (void)tabBarScrollToIndex:(NSInteger)index {
    if (index == _curIndx || index < 0 ||index >= _vieControllers.count) {
        return;
    }
    NSInteger value = _curIndx - index;
    int absValue = abs(value);
    //[self layoutScrollViewWithIndex:index];
    BOOL animated =  absValue == 1;
    if (![self.mapTable objectForKey:@(index).stringValue]) {
        MMTableViewController *vc = _vieControllers[index];
        [vc willMoveToParentViewController:self];
        [self addChildViewController:vc];
        [vc beginAppearanceTransition:YES animated:YES];
        [self.scrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        [self.mapTable setObject:vc forKey:@(index).stringValue];
        UITableView *tableView = vc.tableView;
        
        [tableView setContentOffset:CGPointMake(tableView.contentOffset.x,0) animated:NO];
        
        [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
        UIEdgeInsets inset = tableView.contentInset;
        inset.top += _headerHeight;
        tableView.contentInset = inset;
        tableView.scrollIndicatorInsets = inset;
        tableView.scrollsToTop = NO;
    }
    
    [self.scrollView setContentOffset:CGPointMake(index*self.scrollView.bounds.size.width,self.scrollView.contentOffset.y) animated:animated];
    [self layoutScrollViewWithIndex:index];
    if (!animated) {
        [self scrollViewDidEndDecelerating:self.scrollView];
    }
}

#pragma load--

- (void)reloadTabBarVC {
    if (self.tabBar) {
        [self.tabBar removeFromSuperview];
        self.tabBar = nil;
    }
    [self.headerView removeFromSuperview];
    self.headerView = nil;
    _tabBarHeight = 0;
    _headerHeight = 0;
    [self.mapTable removeAllObjects];
    [_vieControllers enumerateObjectsUsingBlock:^(MMTableViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [vc.tableView removeObserver:self forKeyPath:@"contentOffset"];
        [vc.tableView removeFromSuperview];
        [vc.view removeFromSuperview];
    }];
    
    [_vieControllers removeAllObjects];
    
    [self loadTabItems];
    [self loadHeaderView];
    [self loadViews];
}

- (void)loadTabItems {
    if ([self.delegate respondsToSelector:@selector(sizeOfTabBarToBound)]) {
        CGSize size = [self.delegate sizeOfTabBarToBound];
        self.tabBar = [[MMTabBarViewController alloc] initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, size.height) ViewController:self];
        self.tabBar.delegate = self;
    }
}

- (void)loadHeaderView {
    if ([self.delegate respondsToSelector:@selector(MMTableHeaderView)]) {
        self.headerView = [self.delegate MMTableHeaderView];
        self.headerView.clipsToBounds = YES;
        [self.backView addSubview:self.headerView];
    }
    
    if (self.headerView) {
        if (self.tabBar) {
            CGRect frame = self.headerView.frame;
            frame.size.height += CGRectGetHeight(self.tabBar.frame);
            self.headerView.frame = frame;
            self.tabBar.frame = CGRectMake(0, CGRectGetHeight(self.headerView.frame) - CGRectGetHeight(self.tabBar.frame), CGRectGetWidth(self.tabBar.frame), CGRectGetHeight(self.tabBar.frame));
            [self.headerView addSubview:self.tabBar];
        }
    } else {
        if (self.tabBar) {
            self.headerView = self.tabBar;
            [self.backView addSubview:self.headerView];
        }
    }
    _tabBarHeight = CGRectGetHeight(self.tabBar.frame);
    _headerHeight = CGRectGetHeight(self.headerView.frame);
}

- (void)loadViews {
    NSUInteger vcNumbers = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfMMTableViewControllers)]) {
        vcNumbers = [self.delegate numberOfMMTableViewControllers];
    }
    if (vcNumbers >0) {
        for (int i =0 ;i<vcNumbers;i++) {
            MMTableViewController *vc = [self.delegate MMTableViewControllerWithIndex:i];
            vc.automaticallyAdjustsScrollViewInsets = NO;
            vc.view.frame = CGRectMake(self.scrollView.bounds.size.width*i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
            if (i ==0) {
                vc.view.frame = CGRectMake(self.scrollView.bounds.size.width*i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height+64);
                [self.mapTable setObject:vc forKey:@(i).stringValue];
                [vc willMoveToParentViewController:self];
                [self addChildViewController:vc];
                [vc beginAppearanceTransition:YES animated:YES];
                [self.scrollView addSubview:vc.view];
                [vc didMoveToParentViewController:self];
                
                UITableView *tableView = vc.tableView;
                [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
                [self.view addGestureRecognizer:tableView.panGestureRecognizer];
                UIEdgeInsets inset = tableView.contentInset;
                inset.top += _headerHeight;
                tableView.contentInset = inset;
                tableView.scrollIndicatorInsets = inset;
                tableView.contentOffset = CGPointMake(0, -inset.top);
                tableView.scrollsToTop = NO;
                if (@available(iOS 11.0, *)) {
                    tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                }
            }
            [_vieControllers addObject:vc];
        }
    }
}

#pragma layOut---

- (void)layoutHeaderWithViewController:(MMTableViewController *)vc {
    UITableView *tableView = vc.tableView;
    CGFloat offsetY = tableView.contentOffset.y;
    CGRect frame = self.headerView.frame;
    if (offsetY <= _headerHeight) {
        frame.origin.y = 0;
    } else {
        CGFloat offY = tableView.contentOffset.y+ _headerHeight;
        frame.origin.y = -offY;
    }
    self.headerView.frame = frame;
}

- (void)layoutScrollViewWithIndex:(NSInteger)index {
    if (index<0 || index>_vieControllers.count - 1 || ![self.mapTable objectForKey:@(index).stringValue]) {
        return;
    }
    MMTableViewController *vc = _vieControllers[index];
    UITableView *tableView = vc.tableView;
    if (CGRectGetMaxY(self.headerView.frame) > _tabBarHeight) {
        tableView.contentOffset = CGPointMake(tableView.contentOffset.x, -CGRectGetMaxY(self.headerView.frame));
    } else  {
        if (tableView.contentOffset.y > -_tabBarHeight) {
            MMTableViewController *vc = _vieControllers[index];
            vc.tableView.scrollsToTop = YES;
            UITableView *curScrollView = vc.tableView;
            UIEdgeInsets insets = curScrollView.contentInset;
            CGFloat maxY = insets.bottom + curScrollView.contentSize.height - curScrollView.bounds.size.height;
            if (curScrollView.contentOffset.y > maxY) {
                curScrollView.contentOffset =CGPointMake(0, -insets.top);
            }
        } else {
            tableView.contentOffset = CGPointMake(tableView.contentOffset.x, -_tabBarHeight);
        }
    }
}

#pragma scrollViewDelegate---

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:self.scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y != _lastOffY || [scrollView isMemberOfClass:[UITableView class]]) {
        return;
    }
    
    float x = scrollView.contentOffset.x /self.scrollView.bounds.size.width;
    CGFloat ftx = scrollView.contentOffset.x -self.scrollView.bounds.size.width*floor(x);
    int dbx = ceil(x);
    int flux = floor(x);
    _curIndx = dbx;
    
    if (scrollView.contentOffset.x > (_curOffsetX + CGRectGetWidth(scrollView.frame)/2)) {
        _curOffsetX+=CGRectGetWidth(scrollView.frame);
        [self.tabBar scrollToNotifyTabBar:_curIndx];
    } else if (scrollView.contentOffset.x < (_curOffsetX - CGRectGetWidth(scrollView.frame)/2)) {
        if (flux  < 0) {
            return;
        }
        _curOffsetX-=CGRectGetWidth(scrollView.frame);
        [self.tabBar scrollToNotifyTabBar:(flux)];
    }
    
    int scrollToIndex = dbx;
    if (scrollView.contentOffset.x >(_curOffsetX+5)) {
        scrollToIndex = dbx;
        
    } else if (scrollView.contentOffset.x <(_curOffsetX-5)) {
        scrollToIndex = flux;
    }
    if (![self.mapTable objectForKey:@(scrollToIndex).stringValue]) {
        MMTableViewController *vc = _vieControllers[scrollToIndex];
        [vc willMoveToParentViewController:self];
        [self addChildViewController:vc];
        [vc beginAppearanceTransition:YES animated:YES];
        [self.scrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        [self.mapTable setObject:vc forKey:@(scrollToIndex).stringValue];
        UITableView *tableView = vc.tableView;
        UIEdgeInsets inset = tableView.contentInset;
        inset.top += _headerHeight;
        tableView.contentInset = inset;
        tableView.scrollIndicatorInsets = inset;
        [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
        tableView.contentOffset = CGPointMake(tableView.contentOffset.x, -CGRectGetMaxY(self.headerView.frame));
        tableView.scrollsToTop = YES;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _lastOffY = scrollView.contentOffset.y;
    if ([scrollView isMemberOfClass:[UICollectionView class]]) {
        return;
    }
    
    MMTableViewController *vc = _vieControllers[_curIndx];
    UITableView *tableView = vc.tableView;
    tableView.scrollsToTop = NO;
    [self layoutScrollViewWithIndex:(_curIndx +1)];
    [self layoutScrollViewWithIndex:(_curIndx -1)];
    NSLog(@"1");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"1");
    _curOffsetX = scrollView.contentOffset.x;
    MMTableViewController *vc = _vieControllers[_curIndx];
    vc.tableView.scrollsToTop = YES;
    UITableView *tableView = vc.tableView;
    UIEdgeInsets insets = tableView.contentInset;
    CGFloat maxY = insets.bottom + tableView.contentSize.height - tableView.bounds.size.height;
    if (tableView.contentOffset.y > maxY) {
        [tableView setContentOffset:CGPointMake(0, -insets.top) animated:YES];
    }
    
    if ( -(tableView.contentOffset.y) > CGRectGetMaxY(self.headerView.frame)) {
        [self observeValueForKeyPath:@"contentOffset" ofObject:tableView change:nil context:nil];
    }
}

#pragma KVO---

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (_vieControllers.count == 0) {
        return;
    }
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    MMTableViewController *tabVC = _vieControllers[_curIndx];
    UITableView *tabView = tabVC.tableView;
    CGFloat offY = tabView.contentOffset.y+ _headerHeight;
    CGRect frame = self.headerView.frame;
    if (offY >0 && offY < _headerHeight-_tabBarHeight) {
        frame.origin.y = 0 - offY;
    } else if (offY >_headerHeight-_tabBarHeight) {
        frame.origin.y = -_headerHeight+_tabBarHeight;
    } else {
        frame.origin.y = -offY;
    }
    self.headerView.frame = frame;
}

@end
