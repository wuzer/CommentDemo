//
//  BulletView.m
//  CommentDemo
//
//  Created by Jefferson on 16/8/27.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

#import "BulletView.h"

#define padding 10
#define ImageWidth 30

@interface BulletView ()

@property (nonatomic, strong) UILabel *lbComment;
@property (nonatomic, strong) UIImageView *topImageView;

@end

@implementation BulletView

- (instancetype)initWithComment:(NSString *)comment {
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 15;
        
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        
        CGFloat width = [comment sizeWithAttributes:attr].width;
        self.bounds = CGRectMake(0, 0, width + 2 * padding + ImageWidth, 30);
        
        self.lbComment.text = comment;
        self.lbComment.backgroundColor = [UIColor redColor];
        self.lbComment.frame = CGRectMake(padding + ImageWidth, 0, width, 30);
        
        self.topImageView.frame = CGRectMake(-padding, -padding, ImageWidth + padding, ImageWidth + padding);
        self.topImageView.layer.cornerRadius = (ImageWidth + padding) * 0.5;
        self.topImageView.layer.borderColor = [UIColor yellowColor].CGColor;
        self.topImageView.layer.borderWidth = 1;
        self.topImageView.image = [UIImage imageNamed:@"images"];
    }
    
    return self;
}

- (void)startAnimation {

    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0;
    CGFloat wholeWidth = screenW + CGRectGetWidth(self.bounds);
    
    // 弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(start);
    }
    
    CGFloat speed = wholeWidth / duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds) / speed;
    
    [self performSelector:@selector(EnterScreen) withObject:nil afterDelay:enterDuration];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (self.moveStatusBlock) {
//            self.moveStatusBlock(enter);
//        }
//    });
    
    __block CGRect frame = self.frame;
    typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;
        weakSelf.frame = frame;
    } completion:^(BOOL finished) {
        
        // 弹幕结束
        [self removeFromSuperview];
        if (self.moveStatusBlock) {
            self.moveStatusBlock(end);
        }
    }];
    
}

- (void)EnterScreen {
    
    if (self.moveStatusBlock) {
        self.moveStatusBlock(enter);
    }

}

- (void)stopAniamtion {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

#pragma mark - lazyload

- (UILabel *)lbComment {

    if (!_lbComment) {
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

- (UIImageView *)topImageView {
    
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.clipsToBounds = YES;
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_topImageView];
    }
    return _topImageView;
}

@end
