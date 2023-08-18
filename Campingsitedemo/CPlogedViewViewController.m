//
//  CPlogedViewViewController.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/9/16.
//

#import "CPlogedViewViewController.h"

@interface CPlogedViewViewController ()
@property(nonatomic,strong,readwrite) UIImageView *imageView;
@property(nonatomic,strong,readwrite) NSString *Token;
@property(nonatomic,strong,readwrite) UIAlertController* alert;
@property(nonatomic,strong,readwrite) UITextField *usertextfield;
@property(nonatomic,strong,readwrite) UITextField *passwordtextfield;
@property(nonatomic,strong,readwrite) UILabel *userLabel1;
@property(nonatomic,strong,readwrite) UILabel *userLabel;
@property(nonatomic,strong,readwrite) UIImageView *personImage;
@property(nonatomic,strong,readwrite) NSData *imageData;
@property(nonatomic,strong,readwrite) UIButton *telnetButton;

@end

@implementation CPlogedViewViewController

- (void)viewDidLoad {
  
    self.view.backgroundColor=[UIColor systemBlueColor];
    
        //用户名标签
        int yy = (self.view.frame.size.width*2/3)+10;
    self.tokenstring = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSLog(@"取出的token是%@",self.tokenstring);
      
        [super viewDidLoad];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, (self.view.frame.size.width*2/3))];
        self.imageView.backgroundColor = [UIColor blackColor];
        self.imageView.image = [UIImage imageNamed:@"camping.JPG"];
        [self.view addSubview:_imageView];
        

    
    self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, yy,self.view.frame.size.width-100, 40)];
//    self.userLabel.text = [[NSString alloc] initWithFormat:@"用户：%@已登陆，修改个人资料%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],[[NSUserDefaults standardUserDefaults] objectForKey:@"CPid"]];
//    self.userLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, yy+50,self.view.frame.size.width, 40)];
//    self.userLabel1.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    [self.view addSubview:self.userLabel];

    self.personImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, yy,60, 60)];
    self.personImage.backgroundColor = [UIColor blackColor];
    self.personImage.image = [UIImage imageNamed:@"camping.JPG"];
    self.personImage.layer.cornerRadius=self.personImage.frame.size.width/2;//裁成圆角
    self.personImage.layer.masksToBounds=YES;
    self.personImage.layer.borderWidth = 1.5f;
    self.personImage.layer.borderColor = [UIColor whiteColor].CGColor;
    UITapGestureRecognizer *personPic = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeInfo)];
    self.personImage.userInteractionEnabled = YES;
    [self.personImage addGestureRecognizer:personPic];
    [self.view addSubview:_personImage];
    
             
         
               _imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
               if(_imageData != nil)
               {
                   self.personImage.image = [NSKeyedUnarchiver unarchiveObjectWithData:_imageData];
               }
    
    
    
       if(self.tokenstring){
           self.userLabel.text = [[NSString alloc] initWithFormat:@"%@  已登陆，修改个人资料",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
           self.userLabel.textAlignment = UITextAlignmentLeft;
           self.userLabel.lineBreakMode = UILineBreakModeWordWrap;
           self.userLabel.numberOfLines = 0;
           UITapGestureRecognizer *personInfo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeInfo)];
           self.userLabel.userInteractionEnabled = YES;
           [self.userLabel addGestureRecognizer:personInfo];
           self.userLabel.textColor = [UIColor blueColor];
        
     }else{
         
       
         self.userLabel.text = @"还未登录";

        
     }

      
    
    //  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
      UIButton *forgetpassword=[UIButton buttonWithType:UIButtonTypeRoundedRect];
      [forgetpassword setTitle:@"退出" forState:UIControlStateNormal];
      [forgetpassword setFrame:CGRectMake(100, yy+250, (self.view.frame.size.width-200), 30)];
      [forgetpassword addTarget:self action:@selector(logoutclicked:) forControlEvents:UIControlEventTouchUpInside];
      forgetpassword.backgroundColor=[UIColor blueColor];
      [self.view addSubview:forgetpassword];
    
    _telnetButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_telnetButton setTitle:@"登录" forState:UIControlStateNormal];
    [_telnetButton setFrame:CGRectMake(100, yy+200, (self.view.frame.size.width-200), 30)];
    [_telnetButton addTarget:self action:@selector(loginclicked:) forControlEvents:UIControlEventTouchUpInside];
    _telnetButton.backgroundColor=[UIColor blueColor];
    [self.view addSubview:_telnetButton];

  //  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
//    UIButton *registUser=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [registUser setTitle:@"注册用户" forState:UIControlStateNormal];
//    [registUser setFrame:CGRectMake(100, yy+240, (self.view.frame.size.width-200), 30)];
//    [registUser addTarget:self action:@selector(registerclicked:) forControlEvents:UIControlEventTouchUpInside];
//    registUser.backgroundColor=[UIColor blueColor];
//    [self.view addSubview:registUser];


    // Do any additional setup after loading the view.
    
}

- (void)changeInfo{
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Pid"]){
    personInfoViewController *controller1 = [[personInfoViewController alloc]init];

  controller1.view.userInteractionEnabled = YES;
    controller1.index = 1;
    controller1.delegate = self;

    [self.navigationController pushViewController:controller1 animated:YES];
    }
    
}

-(void)logoutclicked:(UIButton*)logoutButton
{   //登出
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"image"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Pid"];
    self.personImage.image = [UIImage imageNamed:@"camping.JPG"];
    self.userLabel.text = @"用户未登录";
    self.userLabel1.text = @"";
    _telnetButton.enabled = YES;
    _telnetButton.backgroundColor = [UIColor blueColor];
 
}

-(void)loginclicked:(UIButton*)logoutButton
{   //登录
 //   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
 //   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
 //   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"image"];
 //   self.userLabel.text = @"用户未登录";
//    self.userLabel1.text = @"";
    CPLoginView *controller = [[CPLoginView alloc]init];
    controller.index = 1;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
 
}

-(void)registerclicked:(UIButton*)logoutButton
{   //注册
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
 //   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"image"];
    
    CPRegisterViewController *controller1 = [[CPRegisterViewController alloc]init];
//
  controller1.view.userInteractionEnabled = YES;
    controller1.delegate = self;
//
//  controller1.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController pushViewController:controller1 animated:YES];
    
}

-(void)returnToViewController:(functionPageName )pageName {
  switch (pageName) {
      case functionPageNameA:{
          if([[NSUserDefaults standardUserDefaults] objectForKey:@"token"]){
              self.userLabel.text = [[NSString alloc] initWithFormat:@"用户：%@已登陆，修改个人资料",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
              UITapGestureRecognizer *personInfo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeInfo)];
              self.userLabel.userInteractionEnabled = YES;
              [self.userLabel addGestureRecognizer:personInfo];
              self.userLabel.textColor = [UIColor blueColor];
              _imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
              if(_imageData != nil)
              {
                  self.personImage.image = [NSKeyedUnarchiver unarchiveObjectWithData:_imageData];
              }
              
              _telnetButton.enabled = NO;
              _telnetButton.backgroundColor = [UIColor systemBlueColor];
          }else{
              self.userLabel.text = @"用户未登录";
              self.userLabel1.text = @"";
          }
          
          
        //  self.userLabel1.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
      }
        //  [self showFirstFunctionViewControllerWithAnimation:YES];
          break;
      case functionPageNameB:{
          self.userLabel.text = @"用户未登录";
          self.userLabel1.text = @"";}
          [self showSecondFunctionViewControllerWithAnimation:YES];
          break;
      default:
       //   [self showLogedViewControllerWithAnimation:NO];
          break;
  }
   
}

- (void)showSecondFunctionViewControllerWithAnimation:(BOOL)animated {
    //弹出注册页面
    CPRegisterViewController *RgViewController = [[CPRegisterViewController alloc] init];
    RgViewController.hidesBottomBarWhenPushed = NO;
 //   RgViewController.view.backgroundColor = [UIColor whiteColor];
    RgViewController.index = 1;
    RgViewController.delegate = self;
    [self.navigationController pushViewController:RgViewController animated:animated];
    
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
