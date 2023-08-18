//
//  detailViewController.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/5.
//

#import "detailViewController.h"
#import "JXMapNavigationView.h"

#import "CPLoginView.h"
#import "CPlogedViewViewController.h"

#define PICcount 3

@interface detailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)JXMapNavigationView *mapNavigationView;

@property(nonatomic,strong,readwrite) UILabel *titleLabel;
@property(nonatomic,strong,readwrite) UILabel *detailLabel;
@property(nonatomic,strong,readwrite) UILabel *priceLabel;
@property(nonatomic,strong,readwrite) UILabel *telLabel;
@property(nonatomic,strong,readwrite) UILabel *rankLabel;
@property(nonatomic,strong,readwrite) UILabel *commentLabel;
@property(nonatomic,strong,readwrite) UIImageView *imageView;
@property(nonatomic,strong,readwrite) UIButton *naviButton;
@property(nonatomic,strong,readwrite) CPlistItem *DlistItem;
@property(nonatomic,strong,readwrite) UIButton *button;
@property(nonatomic,strong,readwrite) UIButton *commentbutton;
@property(nonatomic,strong,readwrite) UIButton *sharebutton;
@property(nonatomic,strong,readwrite) NSString *tokenstring;
@property(nonatomic,strong,readwrite) UIAlertController* alert;
//图片滚动的相关控件
@property (nonatomic,strong,readwrite) IBOutlet UIScrollView *PICscrollView;
@property (nonatomic,strong,readwrite) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic,readwrite) int commentY;

@end

@implementation detailViewController{
    double _currentLatitude;
    double _currentLongitute;
    double _targetLatitude;
    double _targetLongitute;
    NSString *_name;
    CLLocationManager *_manager;
}



- (JXMapNavigationView *)mapNavigationView{
    if (_mapNavigationView == nil) {
        _mapNavigationView = [[JXMapNavigationView alloc]init];
    }
    return _mapNavigationView;
}

- (instancetype)initWithObject:(CPlistItem *)listItem{
    self = [super init];
    if(self){
        self.DlistItem = listItem;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 2);
    scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scrollView];
    
 //传统单个图片显示
    /*
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80,self.view.frame.size.width, (self.view.frame.size.width*2/3))];
    self.imageView.backgroundColor = [UIColor blackColor];
    //http://www.campingmap.site:81/photo/1.jpg
    //NSString *imgurl =
    NSString *imgurl;
    imgurl = [[NSString alloc] initWithFormat:@"http://www.campingmap.site:81/photo/%@.jpg",self.DlistItem.CPid];
    NSLog(@"%@", imgurl);
    [self.imageView setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"camping.JPG"]];
   
    
   // self.imageView.image = [UIImage imageNamed:@"camping.JPG"];
    [scrollView addSubview:_imageView];
     */
    
   
    
    NSMutableArray *imagesURLStrings = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < PICcount; i++) {
       
        NSString *imgurl = [[NSString alloc] initWithFormat:@"http://www.campingmap.site/photo/IMG_%@_%d.JPG",self.DlistItem.CPid,i+1];
        [imagesURLStrings addObject:imgurl];
        NSLog(@"%@", imgurl);
   

    }
    

//    NSArray *imagesURLStrings = @[
//                               @"http://www.campingmap.site:81/photo/IMG_1_1.JPG",
//                               @"http://www.campingmap.site:81/photo/IMG_1_2.JPG",
//                               @"http://www.campingmap.site:81/photo/IMG_1_3.JPG"
//                               ];
    NSArray *titles = @[@"推广合作 675094287@qq.com",
                            @"感谢您的支持，相关营地的任何建议",
                            @"请给我们反馈",
                            @"您能够发邮件给我们"
                            ];
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 80,self.view.frame.size.width, (self.view.frame.size.width*2/3)) delegate:self placeholderImage:[UIImage imageNamed:@"camping.JPG"]];
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView2.titlesGroup = titles;
        cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [scrollView addSubview:cycleScrollView2];
    
   
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 300, 20)];
 //       self.titleLabel.backgroundColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.text = self.DlistItem.CPname;
        [self.titleLabel sizeToFit];
        [scrollView addSubview:_titleLabel];
        
    
    //电话号码的拨打
    self.telLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 45, 300, 20)];
//       self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    self.telLabel.font = [UIFont systemFontOfSize:18];
    self.telLabel.text = [[NSString alloc]initWithFormat:@"电话:%@",self.DlistItem.telephone];
    self.telLabel.textColor = [UIColor systemBlueColor];
    [self.telLabel sizeToFit];
    [scrollView addSubview:_telLabel];
    UITapGestureRecognizer *tapTel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callTel)];
    self.telLabel.userInteractionEnabled = YES;
    [self.telLabel addGestureRecognizer:tapTel];
    
    
    int x1 = (self.view.frame.size.width*1/3);
    
    self.naviButton = [[UIButton alloc]initWithFrame:CGRectMake(x1*2,35,100,30)];
    [self.naviButton setTitle:@"导航去" forState:UIControlStateNormal];
    self.naviButton.enabled = YES;

    self.naviButton.backgroundColor = [UIColor systemBlueColor];
    self.naviButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [scrollView addSubview:_naviButton];
    [_naviButton addTarget:self action:@selector(buttonClick:)forControlEvents:UIControlEventTouchUpInside];
    
//    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0,35,100,30)];
//    [self.button setTitle:@"返回" forState:UIControlStateNormal];
//    self.button.enabled = YES;
//
//    self.button.backgroundColor = [UIColor grayColor];
//    self.button.titleLabel.font = [UIFont systemFontOfSize:16];
//
//    [self.view addSubview:_button];
//    [_button addTarget:self action:@selector(_goBackView)forControlEvents:UIControlEventTouchUpInside];
    
  //  newAnnotation.fourtitle = [[NSString alloc] initWithFormat:@"%@星营地 价格:%@/晚",item.rate,item.CPprice];

    
    int y1 = 80 + (self.view.frame.size.width*2/3) + 35;
    
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, y1-30, 300, 10)];
 //   self.detailLabel.backgroundColor = [UIColor lightGrayColor];
    self.priceLabel.font = [UIFont systemFontOfSize:16];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.text = [[NSString alloc] initWithFormat:@"%.1f星营地 价格:%@/晚",[self.DlistItem.rate floatValue]/2,self.DlistItem.CPprice];

    self.priceLabel.textAlignment = UITextAlignmentCenter;
    [self.priceLabel sizeToFit];
    [scrollView addSubview:_priceLabel];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, y1, 300, 100)];
 //   self.detailLabel.backgroundColor = [UIColor lightGrayColor];
    self.detailLabel.font = [UIFont systemFontOfSize:16];
    self.detailLabel.text = self.DlistItem.address;
    self.detailLabel.textAlignment = UITextAlignmentCenter;
    [self.detailLabel sizeToFit];
    [scrollView addSubview:_detailLabel];
    
    int y2 = y1 + self.detailLabel.bounds.size.height + 10;
    
    self.rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, y2 ,self.view.frame.size.width-30, 200)];
 //   self.rankLabel.backgroundColor = [UIColor lightGrayColor];
    self.rankLabel.font = [UIFont systemFontOfSize:16];
    self.rankLabel.text = self.DlistItem.evaluation;
    self.rankLabel.textAlignment = UITextAlignmentLeft;
    self.rankLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.rankLabel.numberOfLines = 0;
     
    //行间距
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 8;
 
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.DlistItem.evaluation];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.DlistItem.evaluation.length)];
    self.rankLabel.attributedText = attrString;
    
    [self.rankLabel sizeToFit];
    [scrollView addSubview:_rankLabel];
    
    

    int y3 = y2 + self.rankLabel.bounds.size.height + 10;
     
    self.commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, y3, 100, 30)];
    self.commentLabel.backgroundColor = [UIColor systemRedColor];
    self.commentLabel.font = [UIFont systemFontOfSize:16];
    self.commentLabel.textColor = [UIColor whiteColor];
    self.commentLabel.text = @"详细评价";
    [self.commentLabel sizeToFit];
    [scrollView addSubview:_commentLabel];
   
 //详细评价的读取
  _commentY = y3 + 20;
    //comment button
    self.commentbutton = [[UIButton alloc]initWithFrame:CGRectMake(20, _commentY, self.view.frame.size.width/2-20, 30)];
    [self.commentbutton setTitle:@"点评一下" forState:UIControlStateNormal];
    self.commentbutton.enabled = YES;

    self.commentbutton.backgroundColor = [UIColor systemRedColor];
    self.commentbutton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [scrollView addSubview:self->_commentbutton];
    [self->_commentbutton addTarget:self action:@selector(addcomment:)forControlEvents:UIControlEventTouchUpInside];
    //微信分享内容
    self.sharebutton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, _commentY, self.view.frame.size.width/2-20, 30)];
    [self.sharebutton setTitle:@"分享一下" forState:UIControlStateNormal];
    self.sharebutton.enabled = YES;

    self.sharebutton.backgroundColor = [UIColor systemGreenColor];
    self.sharebutton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [scrollView addSubview:self->_sharebutton];
    [self->_sharebutton addTarget:self action:@selector(addshare:)forControlEvents:UIControlEventTouchUpInside];
    
    _commentY = _commentY + 20;
    NSString * CPID = self.DlistItem.CPid;
    
    extern NSString *CampUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@/camping/campsite/v1/commentsByCamsite",CampUrl];
//    NSString *urlString = @"http://www.campingmap.site:18081/camping/campsite/v1/commentsByCamsite";
    NSLog(urlString);
    
  //  NSURL *listURL = [NSURL URLWithString:urlString];
    

    NSDictionary *parameters = @{@"campsiteId": CPID};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        manager.requestSerializer = [AFJSONRequestSerializer serializer];   // 请求JSON格式
        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应JSON格式
  
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];

    [manager GET:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@" 连接成功 %@",responseObject);
            NSDictionary *dataArray = [responseObject objectForKey:@"content"];
           
           
            if(dataArray.count != 0){
            for(NSDictionary *info in dataArray){
                //评价标题
//                    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                dateFormatter.dateFormat=@"yyyy-MM-ddTHH:mm:ss";
               NSString *recordTime = [[info objectForKey:@"createTime"] substringToIndex:19];
//                NSDate *tempDate = [dateFormatter dateFromString:recordTime];//将字符串转换为时间对象
                NSString *username = @"露营者";
//                    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];
//                if([[[info objectForKey:@"username"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] >11){
//                username = [NSString stringWithFormat:@"Camper**%@",[[info objectForKey:@"username"]
//                                                                               substringFromIndex:7]];
//                }else{
//                username = [info objectForKey:@"username"];
//                }
                
                username = [info objectForKey:@"userName"];
                UILabel *commentTitle = [[UILabel alloc]initWithFrame:CGRectMake(20,_commentY+20,scrollView.frame.size.width-25,90)];
                commentTitle.text = [[NSString alloc] initWithFormat:@"%@  留言:%@。 %@",username,[info objectForKey:@"content"],recordTime];
                commentTitle.lineBreakMode = UILineBreakModeWordWrap;
                commentTitle.numberOfLines = 0;
                [scrollView addSubview:commentTitle];
                
                NSString *Pid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Pid"];
                NSString *Pid1 = [info objectForKey:@"loginId"];
                if( Pid == [info objectForKey:@"loginId"]){
                UILabel *commentChange = [[UILabel alloc]initWithFrame:CGRectMake(50, _commentY+110, 150, 20)];
                commentChange.text = @"修改";
                commentChange.textColor = [UIColor blueColor];
                [scrollView addSubview:commentChange];
                    UITapGestureRecognizer *ChangeComment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addcomment:)];
                    commentChange.userInteractionEnabled = YES;
                    [commentChange addGestureRecognizer:ChangeComment];

                }
                //评价细节
//                UILabel *commentdetail = [[UILabel alloc]initWithFrame:CGRectMake(20, commentY+25, 150, 30)];
//                commentTitle.text = [info objectForKey:@"content"];
//                [scrollView addSubview:commentdetail];
                
              
                _commentY = _commentY + 100;
            }
            
            }else{
                
                UILabel *commentBlank = [[UILabel alloc]initWithFrame:CGRectMake(20, _commentY+20, 200, 30)];
                commentBlank.backgroundColor = [UIColor systemRedColor];
                commentBlank.font = [UIFont systemFontOfSize:16];
                commentBlank.textColor = [UIColor whiteColor];
                commentBlank.text = @"暂时没有评价，想第一个留言吗？";
                [commentBlank sizeToFit];
                [scrollView addSubview:commentBlank];
                
            }

            

            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败 %@",error);
        }];
   
 
  //  [self performSelectorOnMainThread:@selector(yourSelector) withObject:nil waitUntilDone:NO];
   
   // self.userInteractionEnabled = YES;
    
    
    
    
}

- (void)_goBackView{
    NSLog(@"点返回");
   // [self.view removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
    
 
    
}

- (void)callTel{
    
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.DlistItem.telephone];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*=_）\\|~(＜＞$%^&*)_ "];
    NSString *strPhone = [[str componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];




               
                  if (@available(iOS 10.0, *)) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strPhone] options:@{} completionHandler:nil];
                   } else {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strPhone]];
                   }
     


    
}

- (void)addshare:(UIButton *)button{
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    NSString *str3 = [self.DlistItem.evaluation substringToIndex:35];
    req.text = [[NSString alloc] initWithFormat:@"分享一个好营地: %@  :%@... 更多信息请下载露营地图",self.DlistItem.CPname,str3];
    req.scene = WXSceneSession;
 //   [WXApi sendReq:req];
    [WXApi sendReq:req completion:nil];
    
}

- (void)addcomment:(UIButton *)button{
    

    NSLog(@"加123点评");
    self.tokenstring = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSLog(@"取出的token是%@",self.tokenstring);

  //  self.tokenstring = @"1";
    
    if(self.tokenstring){
        //if have tenleted, continue
        [self showFirstFunctionViewControllerWithAnimation:YES];
        
    }else{
        
        UIAlertController *alert = [[UIAlertController alloc]init];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"还未登录，请登录系统" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

              NSLog(@"pushViewController Action");
//      //      [self dismissViewControllerAnimated:true completion:NULL];
//           CPLoginView *logedview = [[CPLoginView alloc]init];
//           [self.navigationController pushViewController:logedview animated:YES];
//    //
            [self showLoginViewControllerWithIndex:1];
            
          }];
       
        [alert addAction:okAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
        style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];

    
        
    }
    
  //  UIAlertController *alert = [[UIAlertController alloc]init];
    /*
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

   //       NSLog(@"pushViewController Action");
  //      [self dismissViewControllerAnimated:true completion:NULL];
//            CPLoginView *logedview = [[CPLoginView alloc]init];
//            [self.navigationController pushViewController:logedview animated:YES];
        
        
      }];
    
    [_alert addAction:okAction];
     */
   
}

// 进入功能A
- (void)showFirstFunctionViewControllerWithAnimation:(BOOL)animated {
    addCommentView *ACViewController = [[addCommentView alloc] init];
    ACViewController.hidesBottomBarWhenPushed = NO;
    ACViewController.view.backgroundColor = [UIColor whiteColor];
    ACViewController.campTitle = self.DlistItem.CPname;
    ACViewController.titlelabel.text = self.DlistItem.CPname;
    ACViewController.campsiteid = self.DlistItem.CPid;
    ACViewController.delegate = self;
    [self.navigationController pushViewController:ACViewController animated:animated];
    
    
 //   [self.navigationController presentViewController:ACViewController animated:animated completion:nil];
    
 //   [nc presentViewController:controller1 animated:YES completion:nil];
//   [self.navigationController presentViewController:ACViewController animated:animated];
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
- (void)showLogedViewControllerWithAnimation:(BOOL)animated {
    CPlogedViewViewController *logedview = [[CPlogedViewViewController alloc]init];
    logedview.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:logedview animated:animated];
}
// 打开登录页面
- (void)showLoginViewControllerWithIndex:(NSInteger)index {
    
    CPLoginView *loginViewController = [[CPLoginView alloc]init];
    loginViewController.hidesBottomBarWhenPushed = YES;
    loginViewController.index = index;
    loginViewController.delegate = self;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

-(void)returnToViewController:(functionPageName )pageName {
  switch (pageName) {
      case functionPageNameA:
          [self showFirstFunctionViewControllerWithAnimation:YES];
          break;
      case functionPageNameB:
          [self showSecondFunctionViewControllerWithAnimation:NO];
          break;
      default:
          [self showLogedViewControllerWithAnimation:NO];
          break;
  }
   
}

- (void)buttonClick:(UIButton *)button{
   /*
    [self.mapNavigationView showMapNavigationViewFormcurrentLatitude:30.306906 currentLongitute:120.107265 TotargetLatitude:22.488260 targetLongitute:113.915049 toName:@"中海油华英加油站"];
    [self.view addSubview:_mapNavigationView];
    */
    /*
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",_currentLatitude,_currentLongitute,@"我的位置",_targetLatitude,_targetLongitute,_name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *r = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:r];
     */
    
    _currentLatitude = mapView.userLocation.coordinate.latitude;
    _currentLongitute = mapView.userLocation.coordinate.longitude;
    _targetLatitude = (CGFloat)[self.DlistItem.latitude floatValue];
    _targetLongitute = (CGFloat)[self.DlistItem.longitude floatValue];
    _name = self.DlistItem.CPname;
   
   
    
    //NSArray * endLocation = [NSArray arrayWithObjects:@"26.08",@"119.28", nil];
       
       NSMutableArray *maps = [NSMutableArray array];
       
       //苹果原生地图-苹果原生地图方法和其他不一样
       NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
       iosMapDic[@"title"] = @"苹果地图";
       [maps addObject:iosMapDic];
       
       
       //百度地图
       if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
           NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
           baiduMapDic[@"title"] = @"百度地图";
           NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=北京&mode=driving&coord_type=gcj02",_targetLatitude,_targetLongitute] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
           baiduMapDic[@"url"] = urlString;
           [maps addObject:baiduMapDic];
       }
       
       //高德地图
       if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
           NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
           gaodeMapDic[@"title"] = @"高德地图";
           NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"nav123456",_targetLatitude,_targetLongitute] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
           gaodeMapDic[@"url"] = urlString;
           [maps addObject:gaodeMapDic];
       }
       
       //谷歌地图
       if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
           NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
           googleMapDic[@"title"] = @"谷歌地图";
           NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"导航测试",@"nav123456",_targetLatitude,_targetLongitute] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
           googleMapDic[@"url"] = urlString;
           [maps addObject:googleMapDic];
       }
       
       //腾讯地图
       if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
           NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
           qqMapDic[@"title"] = @"腾讯地图";
           NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=终点&coord_type=1&policy=0",_targetLatitude,_targetLongitute] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
           qqMapDic[@"url"] = urlString;
           [maps addObject:qqMapDic];
       }
       
       
       //选择
       UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
       
       NSInteger index = maps.count;
       
       for (int i = 0; i < index; i++) {
           
           NSString * title = maps[i][@"title"];
           
           //苹果原生地图方法
           if (i == 0) {
               
               UIAlertAction * action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                   [self navAppleMap];
               }];
               [alert addAction:action];
               
               continue;
           }
           
           
           UIAlertAction * action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
               NSString *urlString = maps[i][@"url"];
               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
           }];
           
           [alert addAction:action];
           
       }
       
      UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
      style:UIAlertActionStyleCancel handler:nil];
      [alert addAction:cancelAction];

       [self presentViewController:alert animated:YES completion:nil];
       
    
}


//苹果地图
- (void)navAppleMap
{
//    CLLocationCoordinate2D gps = [JZLocationConverter bd09ToWgs84:self.destinationCoordinate2D];
    
    //终点坐标
    _targetLatitude = (CGFloat)[self.DlistItem.latitude floatValue];
    _targetLongitute = (CGFloat)[self.DlistItem.longitude floatValue];
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(_targetLatitude, _targetLongitute);
    
    
    //用户位置
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    //终点位置
    MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
    
    
    NSArray *items = @[currentLoc,toLocation];
    //第一个
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    //第二个，都可以用
//    NSDictionary * dic = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
//                           MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]};
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
  
}



/*
-(void)tapAddressAction{

 //   _weaktypeof(self)weakSelf =self;

     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"选择地图" preferredStyle:UIAlertControllerStyleActionSheet];
 
    UIAlertAction *action1 = [UIAlertActionactionWithTitle:@"苹果自带地图"style:UIAlertActionStyleDefaulthandler:(UIAlertAction*_Nonnullaction) {

    MKMapItem*currentLocation = [MKMapItemmapItemForCurrentLocation];

    MKMapItem *tolocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:weakSelf.coordinate addressDictionary:nil]];

    tolocation.name= weakSelf.address;

    [MKMapItem openMapsWithItems:@[currentLocation,tolocation]launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,

    MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];

    }];

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {

    UIAlertAction *action2 = [UIAlertActionactionWithTitle:@"高德地图"style:UIAlertActionStyleDefaulthandler:^(UIAlertAction*_Nonnullaction) {

    NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",weakSelf.coordinate.latitude,weakSelf.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];

    }];

    [alertaddAction:action2];

    }

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {

    UIAlertAction*action3 = [UIAlertActionactionWithTitle:@"百度地图"style:UIAlertActionStyleDefaulthandler:^(UIAlertAction*_Nonnullaction) {

    NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",weakSelf.coordinate.latitude,weakSelf.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];

    }];

    [alert addAction:action3];

    }

    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];

    [alert addAction:action1];

    [alert addAction:action4];

    [self.navigationController presentViewController:alert animated:YES completion:nil];

}
*/
    
/*
- (instancetype)initWithFrame:(CGRect)frame {

    if(self){
        
        [self.view addSubview:({
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 100, 100)];
            self.titleLabel.backgroundColor = [UIColor lightGrayColor];
            self.titleLabel.enabled;
            
        })];
    }
    
    return self;
    
}
 */
/* 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)closeKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

@end
