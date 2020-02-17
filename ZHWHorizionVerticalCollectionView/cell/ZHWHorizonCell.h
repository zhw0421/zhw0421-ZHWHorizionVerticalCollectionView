//
//  ZHWHorizonCell.h
//  ZHWHorizionVerticalCollectionView
//
//  Created by Zhang,Hongwei(RM) on 2020/2/17.
//  Copyright © 2020 Zhang,Hongwei(RM). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHWBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZHWHorizonCell : UICollectionViewCell

@property (nonatomic, strong) NSMutableArray *horizionDataArr;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) ZHWBaseModel *baseModel;

- (void)fillBaseModel:(ZHWBaseModel *)baseModel;

@end

NS_ASSUME_NONNULL_END
