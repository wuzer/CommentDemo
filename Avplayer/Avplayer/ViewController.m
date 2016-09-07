//
//  ViewController.m
//  Avplayer
//
//  Created by Jefferson on 16/9/2.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.player play];
    [self.player pause];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 70, 70);
    [button setTitle:@"start" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(rotateActiion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)rotateActiion {

    [self.player play];
}

- (AVPlayer *)player {
    
    if (!_player) {
        
         NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        
        _player = [AVPlayer playerWithPlayerItem:item];
        
        AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        playLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view.layer addSublayer:playLayer];
        
    }
    return _player;

}


@end
