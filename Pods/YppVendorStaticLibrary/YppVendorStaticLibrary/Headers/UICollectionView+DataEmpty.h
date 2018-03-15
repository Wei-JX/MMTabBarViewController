//
//  UICollectionView+DataEmpty.h
//  YppLife
//
//  Created by ypp on 16/3/21.
//  Copyright © 2016年 WYWK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (DataEmpty)
- (void)collectionViewDisplayPlaceholderImageViewWithImageName:(NSString *)imageName ifNecessaryForRowCount:(NSUInteger) rowCount;
@end
