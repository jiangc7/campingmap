//
//  CPToolBar.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/21.
//

#import "CPToolBar.h"
@interface CPToolBar()

@property(nonatomic,strong,readwrite) UILabel *campName;
@property(nonatomic,strong,readwrite) UITextField *campNameText;

@property(nonatomic,strong,readwrite) UILabel *campDetail;
@property(nonatomic,strong,readwrite) UITextField *campDetailText;

@property(nonatomic,strong,readwrite) UILabel *campTel;
@property(nonatomic,strong,readwrite) UITextField *campTelText;

@property(nonatomic,strong,readwrite) UIButton *commitButton;

@property(nonatomic,strong,readwrite) UILabel *campLatitude;
@property(nonatomic,strong,readwrite) UILabel *campLatitudetext;
@property(nonatomic,strong,readwrite) UILabel *campLatitudetext1;

@end


@implementation CPToolBar

float Xspin;
float Yspin;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor lightGrayColor];
        self.campName = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 40)];
        self.campName.text = @"营地名称";
        self.campName.font = [UIFont systemFontOfSize:16];
        [self.campName sizeToFit];
        [self addSubview:_campName];
        
        self.campNameText = [[UITextField alloc]initWithFrame:CGRectMake(110, 10,(frame.size.width-130), 30)];
        self.campNameText.borderStyle = UITextBorderStyleRoundedRect;
        self.campNameText.font = [UIFont systemFontOfSize:16];
 
        [self addSubview:_campNameText];
        
   
        self.campDetail = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, 80, 40)];
        self.campDetail.text = @"营地描述";
        self.campDetail.font = [UIFont systemFontOfSize:16];
        [self.campDetail sizeToFit];
        [self addSubview:_campDetail];
        
        self.campDetailText = [[UITextField alloc]initWithFrame:CGRectMake(110, 50,(frame.size.width-130), (frame.size.height-220))];
        
        self.campDetailText.borderStyle = UITextBorderStyleRoundedRect;
        self.campDetailText.font = [UIFont systemFontOfSize:16];

        [self addSubview:_campDetailText];
        
        self.campTel = [[UILabel alloc]initWithFrame:CGRectMake(10, (frame.size.height-155), 80, 30)];
        self.campTel.text = @"营地电话";
        self.campTel.font = [UIFont systemFontOfSize:16];
        [self.campTel sizeToFit];
        [self addSubview:_campTel];
        
        self.campTelText = [[UITextField alloc]initWithFrame:CGRectMake(110, (frame.size.height-160),130, 30)];
        self.campTelText.borderStyle = UITextBorderStyleRoundedRect;
        self.campTelText.font = [UIFont systemFontOfSize:16];
    
        [self addSubview:_campTelText];
        
        self.commitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.commitButton.frame = CGRectMake(250, (frame.size.height-160), (frame.size.width-270), 30);
        [self.commitButton setTitle:@"保存" forState:UIControlStateNormal];
        _commitButton.backgroundColor = [UIColor lightTextColor];
        self.commitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        self.commitButton.hidden = NO;
        self.commitButton.enabled = YES;
        [self addSubview:_commitButton];
        
        self.campLatitude = [[UILabel alloc]initWithFrame:CGRectMake(10, (frame.size.height-115), 80, 30)];
        self.campLatitude.text = @"经度  纬度";
        self.campLatitude.font = [UIFont systemFontOfSize:14];
        [self.campLatitude sizeToFit];
        [self addSubview:_campLatitude];
        
        self.campLatitudetext = [[UILabel alloc]initWithFrame:CGRectMake(110, (frame.size.height-120),100, 30)];
        self.campLatitudetext.text = @"";
        self.campLatitudetext.font = [UIFont systemFontOfSize:14];
       
        [self addSubview:_campLatitudetext];
        
        self.campLatitudetext1 = [[UILabel alloc]initWithFrame:CGRectMake(220, (frame.size.height-120),100, 30)];
        self.campLatitudetext1.text = @"";
        self.campLatitudetext1.font = [UIFont systemFontOfSize:14];
       
        [self addSubview:_campLatitudetext1];
        
        
        
        
    }
    
    return self;
    
    
}

- (void)setPin:(float)Xspin:(float)Yspin{
    
    self.campLatitudetext.text = [[NSString alloc]initWithFormat:@"%f",Xspin];
    self.campLatitudetext1.text = [[NSString alloc]initWithFormat:@"%f",Yspin];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
