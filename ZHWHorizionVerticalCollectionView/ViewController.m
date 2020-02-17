//
//  ViewController.m
//  ZHWHorizionVerticalCollectionView
//
//  Created by Zhang,Hongwei(RM) on 2020/2/17.
//  Copyright © 2020 Zhang,Hongwei(RM). All rights reserved.
//

#import "ViewController.h"
#import "ZHWVertivcalCell.h"
#import "ZHWBaseModel.h"
@interface ViewController ()<UICollectionViewDelegate,
UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.verticalCollectionView];
    [self initData];
}

- (void)initData{
    for (int i = 0; i < 10; i++) {
        ZHWHorizionModel *hModel = [ZHWHorizionModel new];
        for (int j = 0; j < 10; j++) {
            ZHWBaseModel *baseModel = [ZHWBaseModel new];
            [hModel.horiziontalDataArr addObject:baseModel];
        }
        [self.vertivalDataArr addObject:hModel];
    }
    [self.verticalCollectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.vertivalDataArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSMutableArray *)vertivalDataArr{
    if (!_vertivalDataArr) {
        _vertivalDataArr = [NSMutableArray array];
    }
    return _vertivalDataArr;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHWVertivcalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZHWVertivcalCell" forIndexPath:indexPath];
    ZHWHorizionModel *hModel = [self.vertivalDataArr objectAtIndex:indexPath.row];
    hModel.verticalIndex = indexPath.row;
    [cell fillZHWVertivcalCell:hModel];
    return cell;
}


-(UICollectionView *)verticalCollectionView{
    if (!_verticalCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake( [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _verticalCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        if (@available(iOS 11.0, *)) {
            _verticalCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _verticalCollectionView.delegate = self;
        _verticalCollectionView.dataSource = self;
        _verticalCollectionView.pagingEnabled = YES;
        _verticalCollectionView.showsVerticalScrollIndicator = NO;
        _verticalCollectionView.scrollsToTop = NO;
        _verticalCollectionView.backgroundColor = [UIColor clearColor];
        _verticalCollectionView.scrollEnabled = YES;
        _verticalCollectionView.delaysContentTouches = NO;
        _verticalCollectionView.panGestureRecognizer.enabled = NO;
        [_verticalCollectionView registerClass:[ZHWVertivcalCell class] forCellWithReuseIdentifier:@"ZHWVertivcalCell"];
    }
    return _verticalCollectionView;
}



@end
