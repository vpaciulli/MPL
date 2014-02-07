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
@property (strong, nonatomic) NSMutableArray *matchingItems;
@property (weak, nonatomic) IBOutlet MKMapView *worldmap;
@property (weak, nonatomic) IBOutlet UITextField *tfSaida;
@property (weak, nonatomic) IBOutlet UITextField *tfChegada;

<<<<<<< HEAD
=======
- (IBAction)btmSaida:(id)sender;
- (IBAction)btmChegada:(id)sender;

>>>>>>> 9b383fc89e5c833f78e28c93dc8db7f0ea473638
- (IBAction)updateLocation:(id)sender;


- (IBAction)mapType:(id)sender;
-(NSString*)data;
-(void)findLocation:(UITextField *)textField;
@end
