//
//  DMVViewController.m
//  MPL
//
//  Created by VIHP on 2/5/14.
//  Copyright (c) 2014 MPL Foundation. All rights reserved.
//

#import "DMVViewController.h"

@interface DMVViewController ()

@end

@implementation DMVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLog(@"%@",[self data]);
    
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
