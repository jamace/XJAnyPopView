//
//  SizeCell.m
//  SizeDemo
//
//  Created by 肖吉 on 2018/1/11.
//  Copyright © 2018年 jamace. All rights reserved.
//

#import "SizeCell.h"
#import "PopView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface SizeCell()<PopViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *sizeBtn;
@property (nonatomic, strong) PopView *popView;
@property (nonatomic, assign) CGRect touchRect;
@end

@implementation SizeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"sizeCell";
    SizeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SizeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_descLabel];
    
    _sizeBtn = [[UIButton alloc] init];
    _sizeBtn.layer.masksToBounds = YES;
    [_sizeBtn setTitle:@"sizeBtn" forState:UIControlStateNormal];
    _sizeBtn.layer.cornerRadius = 6;
    _sizeBtn.backgroundColor = [UIColor redColor];
    [_sizeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sizeBtn addTarget:self action:@selector(sizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_sizeBtn];
    
}
-(void)setModel:(SizeModel *)model
{
    _model = model;
    _titleLabel.text = model.title;
    _descLabel.text = model.desc;
    
    [self configFrame];
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    _sizeBtn.tag = 100+indexPath.row;
}
-(void)configFrame
{
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(12, 12, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
    _sizeBtn.frame = CGRectMake(SCREEN_WIDTH - 100, 60, 80, 30);
}
-(void)sizeBtnClick:(UIButton *)btn
{
    CGRect rect =  [self convertRect:btn.frame toView:[UIApplication sharedApplication].keyWindow];
    _touchRect = rect;
    
    self.popView = [[PopView alloc] init];
    self.popView.delegate = self;
    self.popView.touchRect = _touchRect;
    self.popView.hasPraise = _model.hasPraise;
    self.popView.hasComment = _model.hasComment;
    [self.popView show];
}
-(void)praise
{
    if ([self.delegate respondsToSelector:@selector(praiseIndex:)]) {
        [self.delegate praiseIndex:_indexPath.row];
    }
}
-(void)comment
{
    if ([self.delegate respondsToSelector:@selector(commentIndex:)]) {
        [self.delegate commentIndex:_indexPath.row];
    }
}
+(CGFloat)cellHeightWithModel:(SizeModel *)model
{
    return 100;
}
@end
