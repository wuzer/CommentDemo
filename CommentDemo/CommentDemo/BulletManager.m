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

@end

@implementation BulletManager


- (void)start {
    
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSource];

    [self initBulletComment];
    
}

- (void)stop {
    
    
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
    
    BulletView *view = [[BulletView alloc] initWithComment:comment];
    view.trajectory = trajectory;
    [self.bulletViews addObject:view];
    
    __weak typeof(view) weakView = view;
    __weak typeof(self) weakSelf = self;
    weakView.moveStatusBlock = ^{
        
        [weakView stopAniamtion];
        [weakSelf.bulletViews removeObject:weakView];
    };
    
    if (self.generrateViewBlock) {
        self.generrateViewBlock(view);
    }
    
}

#pragma mark - lazyload

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"弹幕弹幕我来了",
                                                        @"弹幕弹幕我又来了-----",
                                                        @"弹幕弹幕我走了-----------------"
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
