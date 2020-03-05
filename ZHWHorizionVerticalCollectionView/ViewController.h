//
//  ViewController.h
//  ZHWHorizionVerticalCollectionView
//
//  Created by Zhang,Hongwei(RM) on 2020/2/17.
//  Copyright © 2020 Zhang,Hongwei(RM). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHWBaseModel.h"
#import "ZHWHorizionCellProtocol.h"
@interface ViewController : UIViewController

@property (strong, nonatomic) UICollectionView *verticalCollectionView;

@property (nonatomic, strong) NSMutableArray *vertivalDataArr;

@property (nonatomic, strong) ZHWBaseModel *showDetailModel;

@property (nonatomic, strong) ZHWBaseModel *beforeScrollerModel;

@property (nonatomic, strong) UICollectionViewCell<ZHWHorizionCellProtocol> *currentShowCell;

@property (nonatomic, strong) UICollectionViewCell<ZHWHorizionCellProtocol> *beforeShowCell;


@end

