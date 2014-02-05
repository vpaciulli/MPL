//
//  DMVViewController.m
//  MPL
//
//  Created by VIHP on 2/5/14.
//  Copyright (c) 2014 MPL Foundation. All rights reserved.
//

#import "DMVViewController.h"
#import <MapKit/MapKit.h>


@interface DMVViewController ()

@end

@implementation DMVViewController
@synthesize worldmap;
@synthesize locationManager;
@synthesize indicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc]init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocationCoordinate2D loc = [newLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    
    [worldmap setRegion:region animated: YES];
    [worldmap setShowsUserLocation:YES];
    [locationManager stopUpdatingLocation];
    [indicator stopAnimating];
    [indicator setHidesWhenStopped:true];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(NSString*)data{
    
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yy"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    
    return newDateString;
    
}


@end
