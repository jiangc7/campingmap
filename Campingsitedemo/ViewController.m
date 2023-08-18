//
//  ViewController.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/5/31.
//

#import "ViewController.h"
#import "MapAnnotation.h"
#import "detailViewController.h"
#import "CPListLoader.h"
#import "CPSplashview.h"

@interface ViewController ()
@property(nonatomic,strong,readwrite)CPListLoader *listLoader;
@property(nonatomic,strong,readwrite)NSArray *dataArray;
@property(nonatomic,strong,readwrite)UIButton *Button;
@end

@implementation ViewController

int touchnumber = 1;
int loadersuccess = 0;
int connCount = 0;
//float Xpin;
//float Ypin;


- (CLLocationManager *)locationManager{
   
    
    return locationManager;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(touchnumber == 1){
        [locationManager startUpdatingLocation];
        touchnumber ++;
        
    }else{
        if(loadersuccess == 0)
        [self setListPin];
        
/*
        UITouch *touch = [touches anyObject];
            
            //获取手指所点击的那个点
            CGPoint point = [touch locationInView:mapView];
           NSLog(@"x = %f, y = %f", point.x, point.y);
        
            //self.mapView想要转换，将来自mapView中的点转换成经纬度的点
            CLLocationCoordinate2D coordinate = [mapView convertPoint:point  toCoordinateFromView:mapView];
        
        
            //创建大头针模型,需要我们自定义大头针的模型类
        
      
       //     CLPlacemark *mark = [placemarks firstObject];
            NSLog(@"--开始设置大头针--");
            MapAnnotation *annotation = [[MapAnnotation alloc] init];
            //设置经纬度
            annotation.coordinate = coordinate;
            //设置标题
            annotation.title = @"新营地";
           // annotation.subtitle = @"欢迎欢迎";
            
            //添加大头针模型
          [mapView addAnnotation:annotation];
    
    //        [self setPin:coordinate.latitude:coordinate.longitude:@"新营地"];
        NSLog(@"%f",coordinate.latitude);
        NSLog(@"%f",coordinate.longitude);
*/
       
        
    }
    
    
}




- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"--开始定位--");

    [locationManager stopUpdatingLocation];
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = mapView.userLocation.coordinate.latitude;
    zoomLocation.longitude = mapView.userLocation.coordinate.longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 80000, 80000);
    [mapView setRegion:viewRegion animated:YES];
    
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"--选中大头针--");
    
    /*
    detailViewController *viewcontroller1 = [[detailViewController alloc]init];
    viewcontroller1.view.backgroundColor = [UIColor whiteColor];
    viewcontroller1.navigationItem.title = @"营地详情";
    
    viewcontroller1.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController pushViewController:viewcontroller1 animated:YES];
    
    
     */
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
    [mapView setNeedsDisplay];
    

    
    
    if(locationManager ==nil){
        locationManager = [[CLLocationManager alloc]init];
      
        locationManager.distanceFilter = 10.0f;
        locationManager.delegate = self;
        [locationManager requestWhenInUseAuthorization];
     
        
    }
    
   
    
    [self setListPin];
    
    UINavigationController *nc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    [nc.view addSubview:({
        CPSplashview *splashView = [[CPSplashview alloc]initWithFrame:nc.view.bounds];
        splashView;
    })];


   // [mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.529259), 5000, 5000) animated:YES];
    

 //   [mapView setCenterCoordinate:mapView.userLocation.coordinate animated:YES];
    
    
}



- (void)setListPin{
    
    self.listLoader = [[CPListLoader alloc]init];
//         connCount++;

        
    __weak typeof(self)wself = self;
    [self.listLoader LoadlistDataWithFinishBlock:^(bool success, NSArray<CPlistItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        loadersuccess++;

            for(NSInteger i = 0;i<[dataArray count];i++){
            [self setPinone:[self.dataArray objectAtIndex:i]];
            
        }
        
        
      }];
    
//    if(loadersuccess == 0)
//    [self setListPin];
//    if(self.listLoader.failCount == 3){
//        
//    }
//        if(connCount == 3 && loadersuccess == 0)
//        [self showAlert:@"服务器连接失败" message:@"请检查您的网络状态"];
   
}

- (void)setPinone:(CPlistItem *)item{
   
//    float Flatitude = [newString string];
    CGFloat Flatitude = (CGFloat)[item.latitude floatValue];
    CGFloat Longitude = (CGFloat)[item.longitude floatValue];
 
    [self setPin:Flatitude:Longitude:item];
    
}



- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // 返回nil,意味着交给系统处理
    if ([annotation isKindOfClass:[MapAnnotation class]])
    {
        
        // 创建大头针控件
        static NSString *ID = @"camp";
        CustomAnnotationView *annoView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        annoView.delegate = self;
        if (annoView == nil) {
            annoView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
            annoView.userInteractionEnabled=YES;
            annoView.canShowCallout = NO;
        }
        // 设置模型(位置\标题\子标题)
        annoView.aannotation = annotation;
        
        
        //设置模型（位置、标题、子标题）
        // 设置 自定义标注 的 图片
       
            
           
            //添加工程的项目图标
            annoView.image=[UIImage imageNamed:@"camp"];
      
        
        
        //添加标题的左视图  视图为： button
        /*
        self.Button=[UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        [self.Button setTitle:@"详细信息" forState:(UIControlStateNormal)];
        [self.Button setTitle:@"转向详细" forState:UIControlStateHighlighted];
        self.Button.frame=CGRectMake(0, 0, 100, 25);
        // button.tag=(int)_projectMapInfo.pro_areaid;
        [self.Button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        //标题左视图
        annoView.leftCalloutAccessoryView = self.Button;
        [annoView.leftCalloutAccessoryView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
        
        //添加标题的左视图  视图为： button
      
        UIButton *rightbutton=[UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        [rightbutton setTitle:@"导航去" forState:(UIControlStateNormal)];
        [rightbutton setTitle:@"导航中" forState:UIControlStateHighlighted];
        rightbutton.frame=CGRectMake(0, 0, 100, 25);
        // button.tag=(int)_projectMapInfo.pro_areaid;
        [rightbutton addTarget:self action:@selector(rightbuttonAction) forControlEvents:(UIControlEventTouchUpInside)];
        //标题左视图
        annoView.rightCalloutAccessoryView = rightbutton;
        [annoView.rightCalloutAccessoryView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
        */
        
        
        return annoView;
    }
    return nil;
}
-(void)buttonAction:(id)sender
{
    NSLog(@"详细信息");
    
}
-(void)rightbuttonAction
{
    NSLog(@"导航");
    
    
}



/*

 
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
// Try to dequeue an existing pin view first (code not shown).
 
// If no pin view already exists, create a new one.

MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
                                      initWithAnnotation:annotation reuseIdentifier:@"MapAnnotation"];
customPinView.pinColor = MKPinAnnotationColorPurple;
customPinView.animatesDrop = YES;
customPinView.canShowCallout = YES;
 
// Because this is an iOS app, add the detail disclosure button to display details about the annotation in another view.
UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
[rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
customPinView.rightCalloutAccessoryView = rightButton;
 
      // Add a custom image to the left side of the callout.
UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon@2x.png"]];
    
    
customPinView.leftCalloutAccessoryView = myCustomImage;
    customPinView.draggable = YES;
  
    
    
    
return customPinView;
}

*/

- (void)setPin:(float)Xpin:(float)Ypin:(CPlistItem *)item{
    CLLocationCoordinate2D location;
    location.latitude = (double)Xpin;
    location.longitude = (double)Ypin;
    
    
    
    MapAnnotation *newAnnotation = [[MapAnnotation alloc]initWithTitle:item andCoordinate:location];
    //add MKAnnotationView object
    /*
    static NSString *campsiteID = @"campsiteID";
    
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:campsiteID];
    if(annoView == nil){
        annoView = [[MKAnnotationView alloc]initWithAnnotation:newAnnotation reuseIdentifier:campsiteID];
        
    }
    annoView.annotation = newAnnotation;
    annoView.canShowCallout = NO;
    annoView.draggable = YES;
  //  annoview.image = [self ]
     */
    newAnnotation.subtitle = item.address;
    newAnnotation.threetitle = item.evaluation;
    newAnnotation.fourtitle = [[NSString alloc] initWithFormat:@"%.1f星营地 价格:%@/晚",[item.rate floatValue]/2,item.CPprice];
//    newAnnotation.fourtitle = [[NSString alloc] initWithFormat:@"网友评定为：%@星营地: %@/晚",item.rate,item.CPprice];
    [mapView addAnnotation:newAnnotation];
    
}

- (void)showView:(detailViewController *)DVController{
    NSLog(@"准备弹出详细页面");
 //   [self.navigationController pushViewController:DVController animated:YES];
    
}


- (void)showViewItem:(CPlistItem *)item{

    detailViewController *controller1 = [[detailViewController alloc]initWithObject:item];
    controller1.view.backgroundColor = [UIColor whiteColor];
    controller1.navigationItem.title = [NSString stringWithFormat:@"",@(0)];
    [self.navigationController pushViewController:controller1 animated:NO];
    
}

#pragma mark - Private

- (void)showAlert:(NSString *)title message:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                              }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    });
}



@end
