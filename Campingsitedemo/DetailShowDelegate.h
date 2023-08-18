//
//  DetailShowDelegate.h
//  Campingsitedemo
//
//  Created by changpo jiang on 2021/10/21.
//

#import <Foundation/Foundation.h>
#import "detailViewController.h"
#import "CPlistItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailShowDelegate <NSObject>

- (void)showView:(detailViewController *)DVController;
- (void)showViewItem:(CPlistItem *)item;

@end

NS_ASSUME_NONNULL_END
