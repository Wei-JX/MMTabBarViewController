//
//  MMViewController.m
//  NewProject
//
//  Created by admin on 2018/3/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#define MINOFFSET 10

#import "MMViewController.h"
#import "MMTableViewController.h"
#import "UIViewController+MMScrollViewCtronller.h"
#import "SMMTableViewController.h"

@interface MMViewController () <UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) NSMutableArray *vieControllers;
@property (nonatomic ,strong) NSMapTable *mapTable;
@property (nonatomic ,strong) UIView *headerView;
@end

@implementation MMViewController {
  CGFloat _horizonOffset;
    CGFloat _headerHeight;
    NSUInteger _curIndx;
    CGFloat _curOffsetX;
}


- (instancetype)init {
    if (self = [super init]) {
        _horizonOffset = 0.0f;
        _curIndx = 0;
        self.vieControllers = [NSMutableArray array];
        self.mapTable = [[NSMapTable alloc] init];
        self.mapTable =
        [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableWeakMemory];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    NSUInteger vcNumbers = [self.delegate numberOfMMTableViewControllers];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width *vcNumbers , self.view.frame.size.height);
    [self.view addSubview:self.scrollView];
    
    UIView *aaa = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    aaa.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:aaa];
    
  //  [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
    
    
[ self loadHeaderView ];
    [self loadViews];
    
}

- (void)loadHeaderView {
    if ([self.delegate respondsToSelector:@selector(MMTableHeaderView)]) {
        self.headerView = [self.delegate MMTableHeaderView];
        _headerHeight = CGRectGetHeight(self.headerView.frame);
        [self.view addSubview:self.headerView];
        
//        MMTableViewController *tabVc = _vieControllers[_curIndx];
//        tabVc.MMScrollView.tableHeaderView = self.headerView;
//        MMTableViewController *tabVc = _vieControllers[_curIndx];
//        tabVc.tableView.tableHeaderView = self.headerView;
    }

    if (self.headerView) {
        //self.scrollView.contentInset = UIEdgeInsetsMake(_headerHeight, 0, 0, 0);
    }
}

- (void)loadViews {
    NSUInteger vcNumbers = [self.delegate numberOfMMTableViewControllers];
    if (vcNumbers >0) {
        for (int i =0 ;i<vcNumbers;i++) {
            MMTableViewController *vc = [self.delegate MMTableViewControllerWithIndex:i];
            vc.automaticallyAdjustsScrollViewInsets = NO;
            vc.view.frame = CGRectMake(self.scrollView.bounds.size.width*i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
            if (i ==0) {
                [self addChildViewController:vc];
                [self.scrollView addSubview:vc.view];
                UITableView *tableView = vc.tableView;
                [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
                [self.view addGestureRecognizer:tableView.panGestureRecognizer];
                UIEdgeInsets inset = tableView.contentInset;
                inset.top += _headerHeight;
                tableView.contentInset = inset;
                tableView.scrollIndicatorInsets = inset;
                tableView.contentOffset = CGPointMake(0, -inset.top);
                tableView.scrollsToTop = NO;
            }
            [_vieControllers addObject:vc];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float x = scrollView.contentOffset.x /self.scrollView.bounds.size.width;
    CGFloat ftx = scrollView.contentOffset.x -self.scrollView.bounds.size.width*floor(x);
    int dbx = ceil(x);
    _curIndx = dbx;
    _curOffsetX = scrollView.contentOffset.x;
    if (ftx >10) {
        if (![self.mapTable objectForKey:@(dbx).stringValue]) {
        MMTableViewController *vc = _vieControllers[dbx];
        [vc willMoveToParentViewController:self];
        [self addChildViewController:vc];
        [vc beginAppearanceTransition:YES animated:YES];
        [self.scrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        [self.mapTable setObject:vc forKey:@(dbx).stringValue];
        UITableView *tableView = vc.tableView;
        [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
        UIEdgeInsets inset = tableView.contentInset;
        inset.top += _headerHeight;
        tableView.contentInset = inset;
        tableView.scrollIndicatorInsets = inset;
        tableView.contentOffset = CGPointMake(0, -inset.top);
        tableView.scrollsToTop = NO;
      //  [self layoutHeaderWithViewController:vc];
        } else {
           // MMTableViewController *vc = _vieControllers[dbx];
            //[self layoutHeaderWithViewController:vc];
            
        }
    }
}

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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
 {
     MMTableViewController *vc = _vieControllers[_curIndx];
     UITableView *tableView = vc.tableView;
     tableView.scrollsToTop = NO;
    if (scrollView.contentOffset.x > _curOffsetX) {
        
        [self layoutScrollViewWithIndex:(_curIndx +1)];
    } else {
        [self layoutScrollViewWithIndex:(_curIndx -1)];
    }
    
    
    NSLog(@"1");
}

- (void)layoutScrollViewWithIndex:(NSInteger)index {
    if (index<0 || index>_vieControllers.count - 1) {
        return;
    }
    if (CGRectGetMaxY(self.headerView.frame) > 0) {
        MMTableViewController *vc = _vieControllers[index];
        UITableView *tableView = vc.tableView;
        tableView.contentOffset = CGPointMake(tableView.contentOffset.x, -CGRectGetMaxY(self.headerView.frame));
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"1");

    MMTableViewController *vc = _vieControllers[_curIndx];
    vc.tableView.scrollsToTop = YES;

    UITableView *curScrollView = vc.tableView;
    UIEdgeInsets insets = curScrollView.contentInset;
    CGFloat maxY = insets.bottom + curScrollView.contentSize.height - curScrollView.bounds.size.height;
    if (curScrollView.contentOffset.y > maxY) {
        [curScrollView setContentOffset:CGPointMake(0, -insets.top) animated:YES];
    }
    //[self layoutHeaderWithViewController:vc];
}



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
    if (offY >0 && offY < _headerHeight) {
        frame.origin.y = 0 - offY;
    } else if (offY >_headerHeight) {
        frame.origin.y = -_headerHeight;
    } else {
        frame.origin.y = -offY;
    }
    self.headerView.frame = frame;
}


@end
