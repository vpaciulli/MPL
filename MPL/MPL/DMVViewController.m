//
//  DMVViewController.m
//  MPL
//
//  Created by VIHP on 2/5/14.
//  Copyright (c) 2014 MPL Foundation. All rights reserved.
//

#import "DMVViewController.h"
#import <MapKit/MapKit.h>


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
//    [indicator stopAnimating];
//    [indicator setHidesWhenStopped:true];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)updateLocation:(id)sender {
    [locationManager startUpdatingLocation];
}

-(NSString*)data{
    
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yy"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    
    return newDateString;
    
}

//2. Buscar Localização (Danilo)
-(void)findLocation:(UITextField *)textField
{
    [indicator startAnimating];
    MKLocalSearchRequest *request =
    [[MKLocalSearchRequest alloc] init];
    
    [request setNaturalLanguageQuery: [textField text]];
    [request setRegion:[worldmap region]];
    
    
    _matchingItems = [[NSMutableArray alloc] init];
    
    MKLocalSearch *search =
    [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
        {
            MKMapItem *item = response.mapItems.firstObject;
//            item = response.mapItems.firstObject;
            [_matchingItems addObject:item];
            
            MKPlacemark * plMark = [[MKPlacemark alloc] initWithPlacemark:item.placemark];
            [worldmap addAnnotation:plMark];
            [worldmap setCenterCoordinate: [plMark coordinate]];
            NSLog(@"coordenada inicial: @", [[item placemark]coordinate]);
            
        }
    }];
    [indicator stopAnimating];
}



@end
