//
//  PopView.m
//  SizeDemo
//
//  Created by 肖吉 on 2018/1/11.
//  Copyright © 2018年 jamace. All rights reserved.
//

#import "PopView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface PopView()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation PopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
-(void)initUI
{
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor lightGrayColor];
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 2;
    [self addSubview:_bgView];
    
    _praiseBtn = [[UIButton alloc] init];
    _praiseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_praiseBtn setTitle:@"赞" forState:UIControlStateNormal];
    [_praiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_praiseBtn addTarget:self action:@selector(priseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_praiseBtn];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_lineView];

    _commentBtn = [[UIButton alloc] init];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_commentBtn];
    
}

-(void)priseBtnClick:(UIButton *)priseBtn
{
    if ([self.delegate respondsToSelector:@selector(praise)]) {
        [self.delegate praise];
        [self hidden];
    }
}
-(void)commentBtnClick:(UIButton *)commentBtn
{
    if ([self.delegate respondsToSelector:@selector(comment)]) {
        [self.delegate comment];
        [self hidden];
    }
}
-(void)setTouchRect:(CGRect)touchRect
{
    _touchRect = touchRect;
}
-(void)setHasPraise:(BOOL)hasPraise
{
    _hasPraise = hasPraise;
    [_praiseBtn setTitle:hasPraise?@"已赞":@"赞" forState:UIControlStateNormal];
}
-(void)setHasComment:(BOOL)hasComment
{
    _hasComment = hasComment;
    [_commentBtn setTitle:hasComment?@"已评":@"评论" forState:UIControlStateNormal];
}
-(void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    _bgView.frame = CGRectMake(_touchRect.origin.x, _touchRect.origin.y, 0, 30);
    _praiseBtn.frame = CGRectMake(0, 0, 50, 30);
    _commentBtn.frame = CGRectMake(50, 0, 50, 30);
    _lineView.frame = CGRectMake(50, 5, 1, 20);
    
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame = CGRectMake(_touchRect.origin.x-101, _touchRect.origin.y, 100, 30);
    }];
}
-(void)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame = CGRectMake(_touchRect.origin.x, _touchRect.origin.y, 0, 30);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_bgView removeFromSuperview];
        [_praiseBtn removeFromSuperview];
        [_commentBtn removeFromSuperview];
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hidden];
}
@end
