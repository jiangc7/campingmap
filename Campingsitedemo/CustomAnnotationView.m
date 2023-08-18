//
//  CustomAnnotationView.m
//  监控
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 com.admin. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"
#import "AppDelegate.h"
#import "MapAnnotation.h"




#define kCalloutWidth       200.0
#define kCalloutHeight      95.0

@interface CustomAnnotationView ()


@end

@implementation CustomAnnotationView
double _currentLatitude;
double _currentLongitute;
double _targetLatitude;
double _targetLongitute;
NSString *_name;
CLLocationManager *_manager;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle= self.aannotation.subtitle;
        self.calloutView.threetitle=self.aannotation.threetitle;
        self.calloutView.fourtitle=self.aannotation.fourtitle;
        self.leftCalloutAccessoryView.frame=CGRectMake(0, 0, 100, 25);
        
        UIButton *Button=[UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        [Button setTitle:@"详细信息" forState:(UIControlStateNormal)];
        [Button setTitle:@"转向详细" forState:UIControlStateHighlighted];
        Button.frame=CGRectMake(0, 0, 100, 25);
        // button.tag=(int)_projectMapInfo.pro_areaid;
        [Button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        //标题左视图
        [self.calloutView.portraitView addSubview: Button];
     //   [self.calloutView.portraitView addSubview: self.leftCalloutAccessoryView];
        
        UIButton *rightbutton=[UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        [rightbutton setTitle:@"导航去" forState:(UIControlStateNormal)];
        [rightbutton setTitle:@"导航中" forState:UIControlStateHighlighted];
        rightbutton.frame=CGRectMake(0, 0, 100, 25);
        // button.tag=(int)_projectMapInfo.pro_areaid;
        [rightbutton addTarget:self action:@selector(rightbuttonAction) forControlEvents:(UIControlEventTouchUpInside)];
        //标题左视图
        [self.calloutView.rightimageView addSubview:rightbutton];
        
    //    [self.calloutView.rightimageView addSubview:self.rightCalloutAccessoryView];
        [self addSubview:self.calloutView];
    }
    else
    {
       [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

-(void)buttonAction:(id)sender
{
    NSLog(@"详细信息去");
    CPlistItem *item = self.aannotation.item;
    detailViewController *controller1 = [[detailViewController alloc]initWithObject:item];
    controller1.view.backgroundColor = [UIColor whiteColor];
    controller1.navigationItem.title = [NSString stringWithFormat:@"%@",@(0)];
    
 //   UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
 //   [nav pushViewController:controller1 animated:YES];

    [self.viewcontroller.navigationController  pushViewController: controller1  animated:YES];
    
 //   UIViewController *viewcontroller = [[UIViewController alloc]init];
    
    


   //  [viewcontroller pushViewController:controller1 animated:YES];
  //  [self.navigationController pushViewController:controller1 animated:YES];
  //     AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
       
  // [appDelegate.navigationController pushViewController:second animated:YES];
     
}
-(void)rightbuttonAction
{
    NSLog(@"导航去");
    _currentLatitude = mapView.userLocation.coordinate.latitude;
    _currentLongitute = mapView.userLocation.coordinate.longitude;
    _targetLatitude = (CGFloat)[self.aannotation.item.latitude floatValue];
    _targetLongitute = (CGFloat)[self.aannotation.item.longitude floatValue];
    _name = self.aannotation.item.CPname;
    
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",_currentLatitude,_currentLongitute,@"我的位置",_targetLatitude,_targetLongitute,_name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *r = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:r];
    
    
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView != nil)
    {
        [self.superview bringSubviewToFront:self];
    }
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect rect = self.bounds;
    BOOL isInside = CGRectContainsPoint(rect, point);
    if(!isInside)
    {
        for (UIView *view in self.subviews)
        {
            isInside = CGRectContainsPoint(view.frame, point);
            if(isInside)
                break;
        }
    }
    return isInside;
}

@end
