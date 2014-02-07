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

@interface DMVTableVController ()

@end

@implementation DMVTableVController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray * arr = [[NSArray alloc]initWithObjects:@"Danilo", @"Lima", nil];
    
    [_uiTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
