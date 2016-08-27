//
//  BulletView.h
//  CommentDemo
//
//  Created by Jefferson on 16/8/27.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, moveStatus) {
    start,
    enter,
    end
};

@interface BulletView : UIView

@property (nonatomic, assign) int trajectory; // 弹道
@property (nonatomic, copy) void(^moveStatusBlock)(moveStatus status); // 弹幕


// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment;

// 开始动画
- (void)startAnimation;


// 结束动画
- (void)stopAniamtion;

@end
