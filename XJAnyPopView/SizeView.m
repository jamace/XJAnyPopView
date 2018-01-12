//
//  SizeView.m
//  SizeDemo
//
//  Created by 肖吉 on 2018/1/9.
//  Copyright © 2018年 jamace. All rights reserved.
//

#import "SizeView.h"

@interface SizeView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation SizeView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
-(void)initUI
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.layer.cornerRadius = 3;
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.borderColor = [UIColor redColor].CGColor;
    [self addSubview:self.titleLabel];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.font = [UIFont systemFontOfSize:15];
    self.descLabel.textColor = [UIColor lightGrayColor];
    self.descLabel.layer.cornerRadius = 3;
    self.descLabel.layer.borderWidth = 1;
    self.descLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.descLabel.numberOfLines = 0;
    [self addSubview:self.descLabel];
}
-(void)setModel:(SizeModel *)model
{
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    [self layoutIfNeeded];
}
-(void)layoutSubviews
{
    [self.titleLabel sizeToFit];
    NSLog(@"%@",NSStringFromCGRect(self.titleLabel.frame));
    self.titleLabel.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width+10, self.titleLabel.frame.size.height+3);
    NSLog(@"%@",NSStringFromCGRect(self.titleLabel.frame));
    
    // 设置富文本：首行缩进
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.firstLineHeadIndent = self.titleLabel.frame.size.width + 4;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.descLabel.text];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.titleLabel.text.length)];
    
    self.descLabel.attributedText = attrString;
    
    self.descLabel.frame = CGRectMake(0, 0, self.frame.size.width, 0);
    [self.descLabel sizeToFit];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(self.descLabel.frame));
    NSLog(@"---%@",NSStringFromCGRect(self.descLabel.frame));
//    self.descLabel.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width+10, self.titleLabel.frame.size.height+3);
}
@end

