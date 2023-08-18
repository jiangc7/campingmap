//
//  ViewController1.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/18.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"

@interface ViewController1 : UIViewController
<MKMapViewDelegate, CLLocationManagerDelegate>{
    MKMapView *mapView;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D *zoomLocation;
}

@end
