//
//  CPToolBar.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/6/21.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN



@interface CPToolBar : UIView<UIToolbarDelegate>
{
    UILabel* campLatitudetext;
}
- (void)setPin:(float)Xspin:(float)Yspin;

@end

//NS_ASSUME_NONNULL_EN
