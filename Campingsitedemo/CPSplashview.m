//
//  CPSplashview.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/9/8.
//

#import "CPSplashview.h"

@interface CPSplashview()

@property(nonatomic,strong,readwrite)UIButton *button;
@property(nonatomic,strong)NSTimer*countDownTimer;

@end

@implementation CPSplashview

static NSInteger  secondsCountDown = 3;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.image = [UIImage imageNamed:@"LaunchImage.png"];
        [self addSubview:({
            _button = [[UIButton alloc]initWithFrame:CGRectMake(300,100,100,40)];
            _button.backgroundColor = [UIColor lightGrayColor];
            [_button setTitle:@"跳过" forState:UIControlStateNormal];
        
            [_button addTarget:self action:@selector(_removeSplashView) forControlEvents:UIControlEventTouchUpInside];
            _button;
        })];
        self.userInteractionEnabled = YES;
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval:secondsCountDown target:self selector:@selector(_removeSplashView) userInfo:nil repeats:NO];

        
    }
    return self;

}

- (void)_removeSplashView{
    NSLog(@"点跳过");
    [self removeFromSuperview];
    
}

- (void)countDownAction{
    NSLog(@"倒计时");
   
    [_button setTitle:[NSString stringWithFormat:@"跳过%ld",(long)secondsCountDown] forState:UIControlStateNormal];
    secondsCountDown--;
    if(secondsCountDown==0){
            
            [_countDownTimer invalidate];
        }
}

@end
