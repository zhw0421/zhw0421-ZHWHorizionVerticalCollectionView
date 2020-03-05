//
//  ZHWHorizonCell.m
//  ZHWHorizionVerticalCollectionView
//
//  Created by Zhang,Hongwei(RM) on 2020/2/17.
//  Copyright © 2020 Zhang,Hongwei(RM). All rights reserved.
//

#import "ZHWHorizonCell.h"

@implementation ZHWHorizonCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.descLabel];
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)fillBaseModel:(ZHWBaseModel *)baseModel{
    self.baseModel = baseModel;
    self.descLabel.text = [NSString stringWithFormat:@"横坐标 == %li 纵坐标 == %li",self.baseModel.coordinatesX,self.baseModel.coordinatesY];
}


-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        _descLabel.textColor = [UIColor whiteColor];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    }
    return _descLabel;
}



- (NSMutableArray *)horizionDataArr{
    if (!_horizionDataArr) {
        _horizionDataArr = [NSMutableArray array];
    }
    return _horizionDataArr;
}

- (void)cellDidAppear{
    //当前显示Cell应该执行的操作
    NSLog(@"zhw cellDidAppear");
}

- (void)cellDidDisappear{
    //刚刚消失的Cell应该执行的操作
    NSLog(@"zhw cellDidDisappear");
}

@end
