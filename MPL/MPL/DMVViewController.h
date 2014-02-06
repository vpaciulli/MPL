//
//  DMVViewController.h
//  MPL
//
//  Created by VIHP on 2/5/14.
//  Copyright (c) 2014 MPL Foundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface DMVViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet MKMapView *worldmap;

- (IBAction)updateLocation:(id)sender;

- (IBAction)mapType:(id)sender;

-(NSString*)data;
-(void)findLocation:(UITextField *)textField;
@end
