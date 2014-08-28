//
//  BeaconBroadcastViewController.h
//  IBeacon
//
//  Created by Sanjeeva on 1/30/14.
//  Copyright (c) 2014 Sanjeeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeaconBroadcastViewController : UIViewController
@property (strong, nonatomic) NSString *uuidString;
@property (strong, nonatomic) NSString *major;
@property (strong, nonatomic) NSString *minor;
@property (strong, nonatomic) NSString *identifier;

@end
