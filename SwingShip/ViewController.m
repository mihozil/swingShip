//
//  ViewController.m
//  SwingShip
//
//  Created by Apple on 12/27/15.
//  Copyright (c) 2015 AMOSC. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController{
    UIImageView *background;
    UIImageView *background2;
    UIImageView *ship;
    NSTimer *timer;
    AVAudioPlayer *audioplayer;
}

- (void) initproject{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initproject];
    [self objectAdding];
    [self swingShip];
    [self musicAdding];
}
- (void) objectAdding{
    // background
    background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seabackground.png"]];
    background.frame = self.view.bounds;
    [self.view addSubview:background];
    [self backgroundmove];
    
    //add ship
    ship = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ship.png"]];
    ship.frame = CGRectMake(self.view.bounds.size.width*0.3, self.view.bounds.size.height*0.5,
                            self.view.bounds.size.width*0.4, self.view.bounds.size.height*0.4);
    [self.view addSubview:ship];
    
    
}
- (void) backgroundmove{
    // add background 2
    background2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seabackground.png"]];
    background2.frame = CGRectMake(self.view.bounds.size.width, 0,
                                   self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:background2];
    
    
    // background move
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(dobackgorundmove) userInfo:nil repeats:true];
    
    
}
- (void) dobackgorundmove{
    // moving & go back background
    CGRect backgroundframe = background.frame;    // take backgroundframe
    backgroundframe.origin.x -=1;
    
    
    if (backgroundframe.origin.x<=-self.view.bounds.size.width){   // move back
        backgroundframe.origin.x = self.view.bounds.size.width;
    }
    
    background.frame = backgroundframe;         // update
    
    
    // moving and go back background 2
    backgroundframe = background2.frame;
    backgroundframe.origin.x -= 1;
    
    if (backgroundframe.origin.x <= - self.view.bounds.size.width){
        backgroundframe.origin.x = self.view.bounds.size.width;
    }
    
    background2.frame = backgroundframe;
    
}
- (void) swingShip{
    ship.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self doswingship];
    
}
- (void) doswingship{
    //ship.transform = CGAffineTransformIdentity;

    [UIView animateWithDuration:3 animations:^{
        ship.transform = CGAffineTransformMakeRotation(M_PI_4*0.15);
        
    }completion:^(BOOL finished){
        [UIView animateWithDuration:5 animations:^{
            ship.transform = CGAffineTransformMakeRotation(-M_PI_4*0.1);
            
        }completion:^(BOOL finished){
            
                [self doswingship];
        }];
        
    }];
    
}
- (void) musicAdding{
    NSError *error ;
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"inLove" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filepath];
    
   audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [audioplayer prepareToPlay];
    [audioplayer play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
