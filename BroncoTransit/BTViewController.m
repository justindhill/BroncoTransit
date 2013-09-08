//
//  BTViewController.m
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import "BTViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "BTBus.h"

@interface BTViewController () {
    __weak IBOutlet MKMapView *map;
    BTBus *annotation;
}

@end

@implementation BTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //MKPlacemark *pm = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(40, 50) addressDictionary:nil];
    BTBus *bus = [[BTBus alloc] initWithDelegate:self busId:@9 andTitle:@"Brown bus"];
    [bus beginReceivingUpdates];
    annotation = bus;
    //annotation = [[MKAnnotationView alloc] initWithAnnotation:bus reuseIdentifier:@"busMarker"];
    MKCoordinateRegion region = MKCoordinateRegionMake(bus.coordinate, MKCoordinateSpanMake(.01, .01));
    [map addAnnotation:bus];
    [map setRegion:region animated:YES];
    [self performSelector:@selector(busCoordinatesDidChange) withObject:nil afterDelay:5];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)busCoordinatesDidChange {
    NSLog(@"Ohai");
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(annotation.coordinate.latitude - .01, annotation.coordinate.longitude - .01);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    [annotation setCoordinate:loc];
    [map setCenterCoordinate:loc];
    
    [UIView commitAnimations];
}

@end
