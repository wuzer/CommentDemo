//
//  BulletView.h
//  CommentDemo
//
//  Created by Jefferson on 16/8/27.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BulletView : UIView

@property (nonatomic, assign) int trajectory; // 弹道
@property (nonatomic, copy) void(^moveStatusBlock)();

// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment;

// 开始动画
- (void)startAnimation;


// 结束动画
- (void)stopAniamtion;

@end
