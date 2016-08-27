//
//  BulletManager.h
//  CommentDemo
//
//  Created by Jefferson on 16/8/27.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BulletView;

@interface BulletManager : NSObject

@property (nonatomic, copy) void(^generrateViewBlock)(BulletView *view);

- (void)start;

- (void)stop;

@end
