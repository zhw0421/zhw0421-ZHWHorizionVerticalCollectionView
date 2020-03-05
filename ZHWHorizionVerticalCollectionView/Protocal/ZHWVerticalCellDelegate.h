//
//  ZHWVerticalCellDelegate.h
//  ZHWHorizionVerticalCollectionView
//
//  Created by Zhang,Hongwei(RM) on 2020/3/5.
//  Copyright © 2020 Zhang,Hongwei(RM). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHWHorizionCellProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ZHWVerticalCellDelegate <NSObject>

//水平的collectionView 滑动结束跳转至下一个cell
- (void)verticalCellScrollViewDidEndScroll:(NSIndexPath *)horizionPath horizontalCollectionView:(UICollectionViewCell<ZHWHorizionCellProtocol> *)horizontalCollectionViewCell;
//水平的collectionView 开始滑动拖拽操作
-(void)verticalCellscrollViewWillBeginDragging:(UIScrollView *)scrollView;
//水平的collectionView 滑动结束
- (void)verticalCellScrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
