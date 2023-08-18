//
//  setPinController.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/16.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"
#import "MapAnnotation.h"


NS_ASSUME_NONNULL_BEGIN

@interface setPinController : UIViewController
<MKMapViewDelegate, CLLocationManagerDelegate>{
    MKMapView *setmapView;
    CLLocationManager *locationManager;
    MKPointAnnotation *centerAnnotation;
    CLLocationCoordinate2D *zoomLocation;
    CLLocationCoordinate2D *zoomLocation1;
}

@end

NS_ASSUME_NONNULL_END
