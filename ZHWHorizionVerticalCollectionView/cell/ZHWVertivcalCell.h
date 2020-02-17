//
//  ZHWVertivcalCell.h
//  ZHWHorizionVerticalCollectionView
//
//  Created by Zhang,Hongwei(RM) on 2020/2/17.
//  Copyright © 2020 Zhang,Hongwei(RM). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZHWHorizionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZHWVertivcalCell : UICollectionViewCell

@property (nonatomic, strong) UICollectionView *horizontalCollectionView;

@property (nonatomic, strong) ZHWHorizionModel *hModel;

- (void)fillZHWVertivcalCell:(ZHWHorizionModel *)hModel;

@end

NS_ASSUME_NONNULL_END
