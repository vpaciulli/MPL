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

@interface DMVTableVController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
     NSArray *tableData;
}

@property (weak, nonatomic) IBOutlet UITableView *uiTbView;

@end
