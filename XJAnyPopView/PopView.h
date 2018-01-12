//
//  PopView.h
//  SizeDemo
//
//  Created by 肖吉 on 2018/1/11.
//  Copyright © 2018年 jamace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopViewDelegate <NSObject>
-(void)praise;
-(void)comment;
@end
@interface PopView : UIView
@property (nonatomic, assign)id<PopViewDelegate>delegate;
@property (nonatomic, assign) CGRect touchRect;
@property (nonatomic, assign) BOOL hasPraise;
@property (nonatomic, assign) BOOL hasComment;
-(void)show;
-(void)hidden;
@end
