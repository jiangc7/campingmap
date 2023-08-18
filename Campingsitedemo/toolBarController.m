//
//  toolBarController.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/21.
//

#import "toolBarController.h"

@interface toolBarController ()

@property(nonatomic,strong,readwrite) UILabel *campName;
@property(nonatomic,strong,readwrite) UITextField *campNameText;

@property(nonatomic,strong,readwrite) UILabel *campDetail;
@property(nonatomic,strong,readwrite) UITextField *campDetailText;

@property(nonatomic,strong,readwrite) UILabel *campTel;
@property(nonatomic,strong,readwrite) UITextField *campTelText;

@end

@implementation toolBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.campName = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 300, 40)];
    self.campName.text = @"营地名称";
    self.campName.font = [UIFont systemFontOfSize:16];
    [self.campName sizeToFit];
    [self.view addSubview:_campName];
    
    
    
    
    
    
}

- (void)layoutWithModel:(id)model{
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
