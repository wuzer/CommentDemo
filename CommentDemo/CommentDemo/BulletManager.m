//
//  BulletManager.m
//  CommentDemo
//
//  Created by Jefferson on 16/8/27.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"

@interface BulletManager ()

// 弹幕数据来源
@property (nonatomic, strong) NSMutableArray *dataSource;
// 弹幕使用中的数组
@property (nonatomic, strong) NSMutableArray *bulletComments;
// 存储弹幕view的数组
@property (nonatomic, strong) NSMutableArray *bulletViews;

@property BOOL bStopAnimation;

@end

@implementation BulletManager

- (instancetype)init {
    
    if (self = [super init]) {
        self.bStopAnimation = YES;
    }
    return self;
}


- (void)start {
    
    if (!self.bStopAnimation) {
        return;
    }
    self.bStopAnimation = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSource];

    [self initBulletComment];
    
}

- (void)stop {
    
    if (self.bStopAnimation) {
        return;
    }
    
    self.bStopAnimation = YES;
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopAniamtion];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}

- (void)initBulletComment {

    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0), @(1), @(2)]];
    
    for (int i=0; i < 3; i++) {
        
        if (self.bulletComments.count > 0) {
            
            NSInteger index = arc4random()%trajectorys.count;
            int trajactory = [[trajectorys objectAtIndex:index] intValue];
            [trajectorys removeObjectAtIndex:index];
            
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            
            // 创建弹幕
            [self creatBulletView:comment trajectory:trajactory];

        }
    }
}


- (void)creatBulletView:(NSString *)comment trajectory:(int)trajectory {
    
    if (self.bStopAnimation) {
        return;
    }
    
    BulletView *view = [[BulletView alloc] initWithComment:comment];
    view.trajectory = trajectory;
    [self.bulletViews addObject:view];
    
    __weak typeof(view) weakView = view;
    __weak typeof(self) weakSelf = self;
    weakView.moveStatusBlock = ^(moveStatus status){
        
        if (self.bStopAnimation) {
            return;
        }

        switch (status) {
            case start:
                [weakSelf.bulletViews addObject:weakView];
                break;
            case enter:{
                NSString *comment = [weakSelf nextComment];
                if (comment) {
                    [weakSelf creatBulletView:comment trajectory:trajectory];
                }
                break;
            }
            case end:{
                // 释放资源
                if ([weakSelf.bulletViews containsObject:weakView]) {
                    [weakView stopAniamtion];
                    [weakSelf.bulletViews removeObject:weakView];
                }
                
                // 弹幕循环
                if (weakSelf.bulletViews.count == 0) {
                    // 屏幕上已经没有弹幕
                    self.bStopAnimation = YES;
                    [weakSelf start];
                }
                
                break;
            }
            default:
                break;
        }
        
    };
    
    if (self.generrateViewBlock) {
        self.generrateViewBlock(view);
    }
    
}

- (NSString *)nextComment {
    
    if (self.bulletComments.count == 0) {
        return nil;
    }
    
    NSString *comment = [self.bulletComments firstObject];
    
    if (comment) {
        [self.bulletComments removeObjectAtIndex:0];
    }
    
    return comment;
}



#pragma mark - lazyload

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"弹幕了",
                                                        @"幕弹幕我又来了",
                                                        @"弹---------",
                                                       @"弹幕我来了",
                                                       @"弹幕弹又来了-----",
                                                       @"弹幕弹幕我走了--------",
                                                       @"弹幕弹来了",
                                                       @"弹幕弹幕我又来了-----",
                                                       @"弹幕幕我走-----"
                                                        ]];
    }
    return _dataSource;
}

- (NSMutableArray *)bulletComments {
    
    if (!_bulletComments) {
        _bulletComments = [[NSMutableArray alloc] init];
    }
    return _bulletComments;
    
}

- (NSMutableArray *)bulletViews {

    if (!_bulletViews) {
        _bulletViews = [[NSMutableArray alloc] init];
    }
    return _bulletViews;
    
}

@end
