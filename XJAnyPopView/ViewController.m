//
//  ViewController.m
//  SizeDemo
//
//  Created by 肖吉 on 2018/1/9.
//  Copyright © 2018年 jamace. All rights reserved.
//

#import "ViewController.h"
#import "SizeView.h"
#import "SizeModel.h"
#import "SizeCell.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SizeCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    for (int i = 0; i<20; i++) {
        SizeModel *model = [[SizeModel alloc] init];
        model.title = [NSString stringWithFormat:@"我是第%d",i];
        model.desc = @"你是最棒的";
        model.hasPraise = NO;
        model.hasComment = NO;
        [_dataArray addObject:model];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
    //    SizeModel *model = [[SizeModel alloc] init];
    //    model.title = @"你很";
    //    model.desc = @"你真的还有眼光你真的还有眼光你真的还有眼光你真的还有眼光你真的还有眼光你真的还有眼光";
    //
    //    SizeView *sizeView = [[SizeView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 0)];
    //    sizeView.model = model;
    //    [self.view addSubview:sizeView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SizeCell cellHeightWithModel:_dataArray[indexPath.row]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SizeCell *cell = [SizeCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.model = _dataArray[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}
-(void)praiseIndex:(NSInteger)index
{
    SizeModel *model = _dataArray[index];
    model.hasPraise = !model.hasPraise;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *indexPaths = @[indexPath];
    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}
-(void)commentIndex:(NSInteger)index
{
    SizeModel *model = _dataArray[index];
    model.hasComment = !model.hasComment;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *indexPaths = @[indexPath];
    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}
@end
