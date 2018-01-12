//
//  SizeCell.h
//  SizeDemo
//
//  Created by 肖吉 on 2018/1/11.
//  Copyright © 2018年 jamace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizeModel.h"

@protocol  SizeCellDelegate <NSObject>
- (void)praiseIndex:(NSInteger)index;
- (void)commentIndex:(NSInteger)index;
@end

@interface SizeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(SizeModel *)model;
@property (nonatomic, strong) SizeModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) id<SizeCellDelegate>delegate;
@end
