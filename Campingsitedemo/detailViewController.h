//
//  detailViewController.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/5.
//

#import <UIKit/UIKit.h>
#import "UIKit+AFNetworking.h"
#import "MapKit/MapKit.h"
#import <UIKit/UIViewController.h>
#import "CPlistItem.h"
#import "SuccessLoginDelegate.h"
#import "addCommentView.h"
#import "SDCycleScrollView.h"
#import "CPRegisterViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface detailViewController : UIViewController
<MKMapViewDelegate, CLLocationManagerDelegate,SuccessLoginDelegate,SDCycleScrollViewDelegate>{
    MKMapView *mapView;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D *zoomLocation;
}

- (instancetype)initWithObject:(CPlistItem *)listItem;

@end

NS_ASSUME_NONNULL_END
