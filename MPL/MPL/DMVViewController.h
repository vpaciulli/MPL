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
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface DMVViewController : UIViewController <UITextFieldDelegate>

{
    CLLocationCoordinate2D  coordinates[2]; //
    NSMutableArray * ListadePontos;  //
    NSMutableArray * ListadeFalas;
    AVSpeechSynthesizer * fala;
    AVSpeechUtterance * falau;
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) NSMutableArray *matchingItems;
@property (weak, nonatomic) IBOutlet MKMapView *worldmap;

@property (nonatomic,retain) MKPolyline *routeline; //
@property (nonatomic,retain) MKPolylineView *routeLineView; //
@property (weak, nonatomic) IBOutlet UITextField *textField; //
@property (weak, nonatomic) IBOutlet UIButton *desenhaRota; //
@property (nonatomic,strong) NSMutableArray *ListadePontos; //

- (IBAction)updateLocation:(id)sender;

- (IBAction)mapType:(id)sender;

-(NSString*)data;
@end
