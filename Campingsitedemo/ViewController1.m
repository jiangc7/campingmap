//
//  ViewController1.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/18.
//

#import "ViewController1.h"
#import "MapAnnotation.h"
#import "detailViewController.h"

@interface ViewController1 ()

@end

@implementation ViewController1

int touchnumber = 1;
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
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 30000, 30000);
    [mapView setRegion:viewRegion animated:YES];
    
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"--选中大头针--");
    
    detailViewController *viewcontroller1 = [[detailViewController alloc]init];
    viewcontroller1.view.backgroundColor = [UIColor whiteColor];
    viewcontroller1.navigationItem.title = @"营地详情";
    
    viewcontroller1.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController pushViewController:viewcontroller1 animated:YES];
    

    
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
    
   
    
    [self setPin:39.82:116.218:@"房车世界，最近的房车露营地"];
    [self setPin:40.071259:116.032873:@"妙峰山森林公园，原始露营地，有厕所"];
    [self setPin:40.346645:116.870036:@"港中旅(密云南山)房车小镇"];
    [self setPin:40.328663:116.421479:@"房车驿家大杨山营地"];
    [self setPin:28.186649:112.943995:@"老蒋家乡 爱晚亭"];

 
   // [mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(29.454686, 106.529259), 5000, 5000) animated:YES];
    

 //   [mapView setCenterCoordinate:mapView.userLocation.coordinate animated:YES];
    
    
}

/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *campsiteID = @"campsiteID";
    
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:campsiteID];
    if(annoView == nil){
        annoView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:campsiteID];
        
    }
    annoView.image = [UIImage imageNamed:@"Icon-60.png"];
    annoView.annotation = annotation;
    annoView.canShowCallout = NO;
    annoView.draggable = YES;
  //  annoview.image = [self ]
    
    
    return annoView;
}
 */

- (void)setPin:(float)Xpin:(float)Ypin:(NSString *)STitle{
    CLLocationCoordinate2D location;
    location.latitude = (double)Xpin;
    location.longitude = (double)Ypin;
    
    
    
    MapAnnotation *newAnnotation = [[MapAnnotation alloc]initWithTitle:STitle andCoordinate:location];
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
    
    [mapView addAnnotation:newAnnotation];
    
}



@end
