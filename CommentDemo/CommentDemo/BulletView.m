//
//  BulletView.m
//  CommentDemo
//
//  Created by Jefferson on 16/8/27.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

#import "BulletView.h"

#define padding 10

@interface BulletView ()

@property (nonatomic, strong) UILabel *lbComment;

@end

@implementation BulletView

- (instancetype)initWithComment:(NSString *)comment {
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        
        CGFloat width = [comment sizeWithAttributes:attr].width;
        self.bounds = CGRectMake(0, 0, width + 2 * padding, 30);
        
        self.lbComment.text = comment;
        self.lbComment.backgroundColor = [UIColor redColor];
        self.lbComment.frame = CGRectMake(padding, 0, width, 30);
    }
    
    return self;
}

- (void)startAnimation {

    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0;
    CGFloat wholeWidth = screenW + CGRectGetWidth(self.bounds);
    
    __block CGRect frame = self.frame;
    typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;
        weakSelf.frame = frame;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        if (self.moveStatusBlock) {
            self.moveStatusBlock();
        }
    }];
    
}

- (void)stopAniamtion {
    
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

#pragma mark - lazyload

- (UILabel *)lbComment {

    if (_lbComment) {
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14.0];
        _lbComment.textColor = [UIColor purpleColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        _lbComment.backgroundColor = [UIColor redColor];
        [_lbComment sizeToFit];
        [self addSubview:_lbComment];
    }
    return _lbComment;
}


@end
