//
//  setPinController.m
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/16.
//

#import "setPinController.h"
#import "CPToolBar.h"

@interface setPinController ()<MKAnnotation>
@property(nonatomic,strong,readwrite)CPToolBar *toolBar;

@end

@implementation setPinController
@synthesize coordinate;

int touchnumber1 = 1;
//float Xpin;
//float Ypin;

- (CLLocationManager *)locationManager{
   
    
    return locationManager;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(touchnumber1 == 1){
       [locationManager startUpdatingLocation];
        touchnumber1 ++;
        

        
    }else{
        

        
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    setmapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height - 350)) ];
    setmapView.delegate = self;
    setmapView.showsUserLocation = YES;
    [self.view addSubview:setmapView];
    [setmapView setNeedsDisplay];
    
    self.toolBar = [[CPToolBar alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 350), self.view.frame.size.width, 350)];
    
    [self.view addSubview:_toolBar];
    [_toolBar setNeedsDisplay];
    
    
    if(locationManager ==nil){
        locationManager = [[CLLocationManager alloc]init];
      
        locationManager.distanceFilter = 10.0f;
        locationManager.delegate = self;
        [locationManager requestWhenInUseAuthorization];
     
        
    }
    
  
 
 //   mapView.showsUserLocation = YES;
    NSLog(@"--开始定位--");
    NSLog(@"Latitude= %f",setmapView.userLocation.coordinate.latitude);
    [locationManager stopUpdatingLocation];
  /*
    CLLocationCoordinate2D zoomLocation1;
    zoomLocation1.latitude = mapView.userLocation.coordinate.latitude;
    zoomLocation1.longitude = mapView.userLocation.coordinate.longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation1, 30000, 30000);
    [mapView setRegion:viewRegion animated:YES];
*/
 //   MKAnnotationView *centerAnnotation = [[MKAnnotationView alloc] init];

    //点击屏幕，让键盘退下
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];

}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
 //   centerAnnotation.coordinate = setmapView.centerCoordinate;
    
}

- (void)closeKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)mapView:(MKMapView *)mapView
        annotationView:(MKAnnotationView *)annotationView
        didChangeDragState:(MKAnnotationViewDragState)newState
        fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        NSLog(@"dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        [_toolBar setPin:droppedAt.latitude :droppedAt.longitude];
        
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"--开始定位--");

 //   [locationManager stopUpdatingLocation];
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = setmapView.userLocation.coordinate.latitude;
    zoomLocation.longitude = setmapView.userLocation.coordinate.longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 30000, 30000);
    [setmapView setRegion:viewRegion animated:YES];
    
    MapAnnotation *centerCoordinate = [[MapAnnotation alloc]init];
    centerCoordinate.title = [[NSString alloc]initWithFormat: @"个人定制露营地"];
    centerCoordinate.subtitle = [[NSString alloc]initWithFormat: @"内容越多越好"];
    
    
    MKAnnotationView *aView = [[MKAnnotationView alloc] initWithAnnotation:centerCoordinate reuseIdentifier:@"MapAnnotation"];
  
    
 //   aView.image = [UIImage imageNamed:@"Icon@2x.png"];
 //   aView.centerOffset = CGPointMake(10, -20);
    centerCoordinate.coordinate = setmapView.centerCoordinate;
    aView.annotation.coordinate = setmapView.centerCoordinate;
    aView.draggable = YES;
    
    [setmapView addAnnotation:centerCoordinate];
    
    
}



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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
