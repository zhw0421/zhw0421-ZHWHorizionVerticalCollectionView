//
//  ZHWHorizionCellProtocol.h
//  ZHWHorizionVerticalCollectionView
//
//  Created by Zhang,Hongwei(RM) on 2020/3/5.
//  Copyright © 2020 Zhang,Hongwei(RM). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHWHorizionCellProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ZHWHorizionCellProtocol <NSObject>
// cell已经出现
- (void)cellDidAppear;
// cell已经消失
- (void)cellDidDisappear;

@end

NS_ASSUME_NONNULL_END
