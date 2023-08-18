//
//  ViewController.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/5/31.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"
#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"
#import "DetailShowDelegate.h"
#import "CPlistItem.h"

@interface ViewController : UIViewController
<MKMapViewDelegate, CLLocationManagerDelegate,DetailShowDelegate>{
    MKMapView *mapView;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D *zoomLocation;
}

@end

