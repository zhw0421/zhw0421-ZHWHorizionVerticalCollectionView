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
#import "ZHWVerticalCellDelegate.h"
#import "ZHWHorizonCell.h"
@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,ZHWVerticalCellDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.verticalCollectionView];
    [self initData];
    [self.currentSelectedCell cellDidAppear];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.currentSelectedCell && [self.currentSelectedCell respondsToSelector:@selector(cellDidDisappear)]) {
        [self.currentSelectedCell cellDidDisappear];
    }
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
    cell.delegate = self;
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

#pragma mark -- ZHWVerticalCellDelegate 获取当前选中的item

- (void)verticalCellScrollViewDidEndScroll:(NSIndexPath *)horizionPath horizontalCollectionView:(UICollectionViewCell<ZHWHorizionCellProtocol> *)horizontalCollectionViewCell{
    //横向滑动结束，获取到当前展示cell需要做的
    [self dealScrollEndPlay:NO];
}

-(void)verticalCellScrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentViewX = self.showDetailModel.coordinatesX * [UIScreen mainScreen].bounds.size.width;
    if ((currentViewX - scrollView.contentOffset.x - [UIScreen mainScreen].bounds.size.width) >= 0) {
        //暂停正在播放的视频
    } else if((scrollView.contentOffset.x - currentViewX - [UIScreen mainScreen].bounds.size.width) >= 0){
        //暂停正在播放的视频
    }
}


-(void)verticalCellscrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //开始横向t滑动，需要做的标记
    self.beforeScrollerModel = self.showDetailModel;
    self.beforeShowCell = self.currentShowCell;
    
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentViewY = self.showDetailModel.coordinatesY * [UIScreen mainScreen].bounds.size.height;
    if ((currentViewY - scrollView.contentOffset.y - [UIScreen mainScreen].bounds.size.height) >= 0) {
        //暂停正在播放的视频
    } else if((scrollView.contentOffset.y - currentViewY - [UIScreen mainScreen].bounds.size.height) >= 0){
        //暂停正在播放的视频
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 停止类型3
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
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.beforeScrollerModel = self.showDetailModel;
    self.beforeShowCell = self.currentShowCell;
    
}

#pragma mark -- scrollViewDidEndScroll 获取当前选中的item
-(void)scrollViewDidEndScroll{
    [self dealScrollEndPlay:YES];
    if (self.beforeScrollerModel != self.showDetailModel) {
    }
}
-(void)dealScrollEndPlay:(BOOL)isVerticalScroll{
    self.showDetailModel = [self currentSelectedCell].baseModel;
    self.currentShowCell = [self currentSelectedCell];
    if (self.showDetailModel != self.beforeScrollerModel) {
        NSLog(@"zhw 上下左右滑动完成");
        [self.beforeShowCell cellDidDisappear];
        [self.currentShowCell cellDidAppear];
    }
}

-(ZHWBaseModel *)currentHModel{
    ZHWVertivcalCell *verticalCell = [self currentVerticalCell];
    return verticalCell.hModel.horiziontalDataArr[verticalCell.hModel.currentIndex];
}

- (ZHWVertivcalCell *)currentVerticalCell {
    CGPoint centerPoint = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    NSArray * verticalVisibleCells = [self.verticalCollectionView visibleCells];
    ZHWVertivcalCell *verticalCell;
    for (ZHWVertivcalCell *cell  in verticalVisibleCells) {
        CGRect verticalCellFrame = [self.verticalCollectionView convertRect:cell.frame toView:[self.verticalCollectionView superview]];
        if (CGRectContainsPoint(verticalCellFrame, centerPoint)) {
            verticalCell = cell;
            break;
        }
    }
    if (!verticalCell) {
        verticalCell = (ZHWVertivcalCell *)[self.verticalCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.showDetailModel.coordinatesY inSection:0]];
    }
    return verticalCell;
}


- (ZHWHorizonCell *)currentSelectedCell {
    ZHWVertivcalCell * verticalCell = [self currentVerticalCell];
    return [verticalCell currentHorizontalCell];
}



@end
