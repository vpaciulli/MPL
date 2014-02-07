//
//  DMVViewController.m
//  MPL
//
//  Created by VIHP on 2/5/14.
//  Copyright (c) 2014 MPL Foundation. All rights reserved.
//

#import "DMVViewController.h"
#import <MapKit/MapKit.h>
#pragma mark

@interface DMVViewController ()

@end


@implementation DMVViewController
@synthesize worldmap;
@synthesize locationManager;
@synthesize indicator;
@synthesize routeline; //
@synthesize routeLineView; //
@synthesize textField; //
@synthesize segcontrol; //
@synthesize desenhaRota; //
@synthesize ListadePontos; //



- (void)viewDidLoad
{
    [super viewDidLoad];
    
//  Inicia Toque longo.

    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    lpgr.minimumPressDuration = 1; //user must press for 2 seconds
    [worldmap addGestureRecognizer:lpgr];
    
//    Traz mapa \/
    locationManager = [[CLLocationManager alloc]init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
    [indicator setHidesWhenStopped:true];
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
    return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:worldmap];
    CLLocationCoordinate2D touchMapCoordinate =
    [worldmap convertPoint:touchPoint toCoordinateFromView:worldmap];
    
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = touchMapCoordinate;
    [worldmap addAnnotation:pa];

}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocationCoordinate2D loc = [newLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    
    [worldmap setRegion:region animated: YES];
    [worldmap setShowsUserLocation:YES];
    [locationManager stopUpdatingLocation];
    [indicator stopAnimating];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self realizabusca];
    return YES;
}

- (IBAction)updateLocation:(id)sender {
    [locationManager startUpdatingLocation];
}

- (IBAction)mapType:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    if (seg.selectedSegmentIndex==0) {
        [worldmap setMapType:MKMapTypeStandard];
    
    }else if (seg.selectedSegmentIndex==1){
        [worldmap setMapType:MKMapTypeHybrid];
    
    }else if (seg.selectedSegmentIndex==2){
        [worldmap setMapType:MKMapTypeSatellite];
    }
    
}

-(NSString*)data{
    
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yy"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    
    return newDateString;
    
}

-(void) realizabusca {
    
    [indicator startAnimating];
    //remove os pins do mapa
    ListadePontos = [[NSMutableArray  alloc] init];
    
    if ( ![ListadePontos isEqualToArray:nil]) {
        [worldmap removeAnnotations:worldmap.annotations];
        
        [ListadePontos removeAllObjects];
    }
    
    
    //Cria a busca responsável pelos pins no mapa.
    
    
    MKLocalSearchRequest * request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = [textField text];
    request.region = worldmap.region;
    //faz a busca e armazena resultados em uma mutableArray
    MKLocalSearch *search =
    [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
            for (MKMapItem *item in response.mapItems)
            {
                MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
                //guarda os itens no mutable array
                CLPlacemark *placemark = item.placemark;
                CLLocation *location = placemark.location;
                CLLocationCoordinate2D loc3 = location.coordinate;
                NSLog(@"%f",location.coordinate.latitude);
                NSLog(@"%f",location.coordinate.longitude);
                [ point setCoordinate:loc3];
                NSLog(@"%f",point.coordinate.latitude);
                NSLog(@"%f",point.coordinate.longitude);
                point.title=item.name;
                [ListadePontos addObject:point];
                NSLog(@"%f", [[ListadePontos objectAtIndex:0 ] coordinate] ) ;
                [worldmap addAnnotation:point];
                [worldmap setCenterCoordinate: [point coordinate]];
                
            }
        
        [indicator stopAnimating];
    }];
    
}


- (IBAction)desenhaRota:(id)sender {
    if (ListadePontos.count != 0) {
        
    }
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    srand(time (NULL));
    int  num = rand() % ListadePontos.count;
    MKPlacemark * place = [[MKPlacemark alloc] initWithCoordinate:((MKPointAnnotation *)[ListadePontos objectAtIndex:0]).coordinate addressDictionary:nil];
    MKPlacemark * place1 = [[MKPlacemark alloc] initWithCoordinate:((MKPointAnnotation *)[ListadePontos objectAtIndex:num]).coordinate addressDictionary:nil];
    // NSLog(@"%@",((MKPointAnnotation *)[ListadePontos objectAtIndex:0]).coordinate);
    //place.coordinate = ((MKPointAnnotation *)[ListadePontos objectAtIndex:0]).coordinate;
    //place1.coordinate = ((MKPointAnnotation *)[ListadePontos objectAtIndex:1]).coordinate;
    //request.source  = [[MKMapItem alloc]initWithPlacemark:place];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = [[MKMapItem alloc] initWithPlacemark:place1];
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             NSLog(@"ERRO MENOR");
         } else {
             [self showRoute:response];
         }
     }];
}


- (void)showRoute:(MKDirectionsResponse *)response
{
    [ListadeFalas removeAllObjects];
    for (MKRoute *route in response.routes)
    {
        [worldmap addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            
            // NSLog(@"%@", step.instructions);
            [ListadeFalas addObject:(NSString *)step.instructions.stringByStandardizingPath];
            [self Speak:step.instructions];
            
        }
    }
    
}

-(void) Speak :(NSString *) text
{
    fala =[[ AVSpeechSynthesizer alloc] init];
    falau = [[AVSpeechUtterance alloc] init];
    falau = [AVSpeechUtterance speechUtteranceWithString:text];
    [falau setRate:0.1f];
//    [falau setVoice:<#(AVSpeechSynthesisVoice *)#>]
//    falau.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"pt-PT"];
    [fala speakUtterance:falau];
}



-(MKOverlayRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer =[[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.strokeColor = [UIColor greenColor];
        routeRenderer.lineWidth = 2;
        routeRenderer.fillColor = [UIColor greenColor];
        return routeRenderer;
    }
    else return nil;
}

//- (void)centerMapAroundSourceAndDestination
//{
//    MKMapRect rect = MKMapRectNull;
//    MKMapPoint sourcePoint = MKMapPointForCoordinate(southWestPoint);
//    rect = MKMapRectUnion(rect, MKMapRectMake(sourcePoint.x, sourcePoint.y, 0, 0));
//    MKMapPoint destinationPoint = MKMapPointForCoordinate(_northEastPoint);
//    rect= MKMapRectUnion(rect, MKMapRectMake(destinationPoint.x, destinationPoint.y, 0, 0));
//    MKCoordinateRegion region = MKCoordinateRegionForMapRect(rect);
//    [worldmap setRegion:region animated:YES];
//}

@end
