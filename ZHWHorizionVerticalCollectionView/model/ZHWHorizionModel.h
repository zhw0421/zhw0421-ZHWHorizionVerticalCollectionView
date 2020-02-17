//
//  ZHWHorizionModel.h
//  ZHWHorizionVerticalCollectionView
//
//  Created by Zhang,Hongwei(RM) on 2020/2/17.
//  Copyright © 2020 Zhang,Hongwei(RM). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHWHorizionModel : NSObject

@property (nonatomic, strong) NSMutableArray *horiziontalDataArr;

@property (nonatomic, assign) NSInteger verticalIndex;

@property (nonatomic, assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
