//
//  DMVViewController.m
//  MPL
//
//  Created by VIHP on 2/5/14.
//  Copyright (c) 2014 MPL Foundation. All rights reserved.
//

#import "DMVTableVController.h"
#import <MapKit/MapKit.h>
#pragma mark

@implementation DMVTableVController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//  Inicia Toque longo.
//    Traz mapa \/
}

-(void) longPressGestureHandle:(UILongPressGestureRecognizer*)sender{
    if(sender.state==UIGestureRecognizerStateEnded){
        
    }
}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

}


- (void)didReceiveMemoryWarning
{
//    [super didReceiveMemoryWarning];
    
}

//- (IBAction)btmSaida:(id)sender {
//    [self findLocation:_tfSaida];
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return true;
}


-(NSString*)data{
    
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yy"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    
    return newDateString;
    
}


@end
