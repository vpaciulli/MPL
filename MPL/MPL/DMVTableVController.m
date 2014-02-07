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
    // Initialize table data
    tableData = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
        
    
//  Inicia Toque longo.
//    Traz mapa \/
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}
//pega cellula selecionada e chama metodo de entrada de texto;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSString *cellText = cell.textLabel.text;
//    NSLog(cellText);
    
    UIAlertView * inputBox = [[UIAlertView alloc] initWithTitle:@"Favorito" message:@"Deigite seu local favorito!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    inputBox.alertViewStyle = UIAlertViewStylePlainTextInput;
    [inputBox show];
    
    NSString * texto = inputBox.textInputContextIdentifier;

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"Digitou: %@",[[alertView textFieldAtIndex:0] text]);
//    NSLog(@"Digitou: %@",[[alertView textFieldAtIndex:0] text]);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
