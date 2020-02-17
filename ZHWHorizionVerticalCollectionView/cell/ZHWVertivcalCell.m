//
//  ZHWVertivcalCell.m
//  ZHWHorizionVerticalCollectionView
//
//  Created by Zhang,Hongwei(RM) on 2020/2/17.
//  Copyright © 2020 Zhang,Hongwei(RM). All rights reserved.
//

#import "ZHWVertivcalCell.h"
#import "ZHWHorizonCell.h"
#define FMT_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define FMT_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ZHWVertivcalCell ()<UICollectionViewDelegate,
UICollectionViewDataSource>

@end

@implementation ZHWVertivcalCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.horizontalCollectionView];
        self.horizontalCollectionView.frame = CGRectMake(0, 0, FMT_SCREEN_WIDTH, FMT_SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [self scrollViewDidEndScroll];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [self scrollViewDidEndScroll];
    }
}


#pragma mark -- scrollViewDidEndScroll 获取当前选中的item
-(void)scrollViewDidEndScroll{
    NSIndexPath *indexPath = [self.horizontalCollectionView indexPathForCell:[self currentHorizontalCell]];
    self.hModel.currentIndex = indexPath.row;
}

//获取当前选中的Cell
- (ZHWHorizionModel *)currentHorizontalCell {
    CGPoint centerPoint = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    NSArray * cells = [self.horizontalCollectionView visibleCells];
    ZHWHorizionModel *horizontalCell;
    for (ZHWHorizonCell *cell  in cells) {
        CGRect frame = [self.horizontalCollectionView convertRect:cell.frame toView:[self.horizontalCollectionView superview]];
        if (CGRectContainsPoint(frame, centerPoint)) {
            horizontalCell = cell;
            break;
        }
    }
    if (!horizontalCell) {
        horizontalCell = (ZHWHorizionModel *)[self.horizontalCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.hModel.currentIndex inSection:0]];
    }
    return horizontalCell;
}



- (void)fillZHWVertivcalCell:(ZHWHorizionModel *)hModel{
    self.hModel = hModel;
    [self.horizontalCollectionView reloadData];
    [self.horizontalCollectionView layoutIfNeeded];
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:self.hModel.currentIndex inSection:0];
    NSInteger lastRowIndex = [self.horizontalCollectionView numberOfItemsInSection:0] - 1;
    if (scrollIndexPath.row <= lastRowIndex) {
        [self.horizontalCollectionView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hModel.horiziontalDataArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHWHorizonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZHWHorizonCell" forIndexPath:indexPath];
    ZHWBaseModel *baseModel = (ZHWBaseModel *)[self.hModel.horiziontalDataArr objectAtIndex:indexPath.row];
    baseModel.coordinatesX = indexPath.row;
    baseModel.coordinatesY = self.hModel.verticalIndex;
    [cell fillBaseModel:baseModel];
    return cell;
}

- (UICollectionView *)horizontalCollectionView {
    if (!_horizontalCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(FMT_SCREEN_WIDTH, FMT_SCREEN_HEIGHT);
        _horizontalCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, FMT_SCREEN_WIDTH, FMT_SCREEN_HEIGHT) collectionViewLayout:layout];
        _horizontalCollectionView.contentSize = CGSizeZero;
        _horizontalCollectionView.contentOffset = CGPointZero;
        _horizontalCollectionView.delegate = self;
        _horizontalCollectionView.dataSource = self;
        _horizontalCollectionView.pagingEnabled = YES;
        _horizontalCollectionView.showsHorizontalScrollIndicator = NO;
        _horizontalCollectionView.scrollsToTop = NO;
        _horizontalCollectionView.delaysContentTouches = NO;
        [_horizontalCollectionView registerClass:ZHWHorizonCell.class forCellWithReuseIdentifier:@"ZHWHorizonCell"];
        _horizontalCollectionView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            _horizontalCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _horizontalCollectionView;
}
@end
