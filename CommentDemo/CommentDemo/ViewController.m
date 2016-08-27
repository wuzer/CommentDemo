//
//  ViewController.m
//  CommentDemo
//
//  Created by Jefferson on 16/8/27.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

#import "ViewController.h"
#import "BulletManager.h"
#import "BulletView.h"

@interface ViewController ()

@property (nonatomic, strong) BulletManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [[BulletManager alloc] init];
    
    __weak typeof(self) weakSelf = self;
    self.manager.generrateViewBlock = ^(BulletView *view){
        [weakSelf addBulletView:view];
        
    };
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
//    button.backgroundColor = [UIColor redColor];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [button setTitle:@"点我生成弹幕" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    [self.view addSubview:button];
    
}

- (void)buttonAction {
    
    [self.manager start];
}

- (void)addBulletView:(BulletView *)view {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.trajectory * 40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    [view startAnimation];
}



@end
