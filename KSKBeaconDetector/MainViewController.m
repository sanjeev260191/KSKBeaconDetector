//
//  MainViewController.m
//  IBeacon
//
//  Created by Sanjeeva on 1/30/14.
//  Copyright (c) 2014 Sanjeeva. All rights reserved.
//

#import "MainViewController.h"
#import "BeaconBroadcastViewController.h"
#import "BeaconReceiverViewController.h"
@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *uuidTextField;
@property (weak, nonatomic) IBOutlet UITextField *majorTextField;
@property (weak, nonatomic) IBOutlet UITextField *minorTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifierTextField;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"iBeacon";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)startBroadcastTapped:(id)sender {
    BeaconBroadcastViewController *beaconBroadcastViewController = [[BeaconBroadcastViewController alloc]initWithNibName:@"BeaconBroadcastViewController" bundle:nil];
    beaconBroadcastViewController.uuidString = self.uuidTextField.text;
    beaconBroadcastViewController.major = self.majorTextField.text;
    beaconBroadcastViewController.minor = self.minorTextField.text;
    beaconBroadcastViewController.identifier = self.identifierTextField.text;
    [self.navigationController pushViewController:beaconBroadcastViewController animated:NO];
}
- (IBAction)startReceivingTapped:(id)sender {
    BeaconReceiverViewController *beaconReceiverViewController = [[BeaconReceiverViewController alloc]initWithNibName:@"BeaconReceiverViewController" bundle:nil];
    [self.navigationController pushViewController:beaconReceiverViewController animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
