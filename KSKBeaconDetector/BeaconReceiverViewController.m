//
//  BeaconReceiverViewController.m
//  IBeacon
//
//  Created by Sanjeeva on 1/30/14.
//  Copyright (c) 2014 Sanjeeva. All rights reserved.
//

#import "BeaconReceiverViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface BeaconReceiverViewController ()<CLLocationManagerDelegate>{
    NSString* message;
    NSString* currentMessage;
}
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (weak, nonatomic) IBOutlet UILabel *major;
@property (weak, nonatomic) IBOutlet UILabel *minor;
@property (weak, nonatomic) IBOutlet UILabel *proximity;
@property (weak, nonatomic) IBOutlet UILabel *rssi;
@property (weak, nonatomic) IBOutlet UILabel *uuid;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation BeaconReceiverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Initialize location manager and set ourselves as the delegate
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.navigationController.title = @"IBEACON Receiver";
    // Create a NSUUID with the same UUID as the broadcasting beacon
    // UUID of estimote beacon is used here.
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"Estimote Region"];
    
    
    self.myBeaconRegion.notifyEntryStateOnDisplay = YES;
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region {
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region {
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region {
    // Beacon found!
    if(beacons.count >0){
        NSLog(@"foundBeacon");
        CLBeacon *foundBeacon = [beacons firstObject];

        if([foundBeacon.major integerValue] == 27388 && [foundBeacon.minor integerValue] == 25468){
            self.uuid.text = [NSString stringWithFormat:@"%@",foundBeacon.proximityUUID.UUIDString];
            self.major.text = [NSString stringWithFormat:@"%@",foundBeacon.major];
            self.minor.text = [NSString stringWithFormat:@"%@",foundBeacon.minor];
            self.proximity.text = [NSString stringWithFormat:@"%d",foundBeacon.proximity];
            
            self.rssi.text = [NSString stringWithFormat:@"%ld",(long)foundBeacon.rssi];
            switch (foundBeacon.proximity) {
                case CLProximityImmediate:{
                    [self.view setBackgroundColor:[UIColor greenColor]];
                    message = @"Right next to you";
                }
                    break;
                case CLProximityNear:{
                    [self.view setBackgroundColor:[UIColor yellowColor]];
                    message = @"Near to you";
                }
                    break;
                case CLProximityFar:{
                    [self.view setBackgroundColor:[UIColor orangeColor]];
                    message = @"Far from you";
                }
                    break;
                case CLProximityUnknown:{
                    [self.view setBackgroundColor:[UIColor redColor]];
                    message = @"unknown Location";
                }
                    break;
                    
                default:
                    break;
            }
            self.distance.text = message;
            if (currentMessage!=message || currentMessage == nil) {
                [self sendNotification:message];
            }
            currentMessage =message;
        }
    }
}
-(void)sendNotification:(NSString*)notfMsg{
    UILocalNotification * theNotification = [[UILocalNotification alloc] init];
    theNotification.alertBody = notfMsg;
    theNotification.alertAction = @"Thanks";
    theNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:0.0];
    theNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:theNotification];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"IBeacon" message:notfMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
