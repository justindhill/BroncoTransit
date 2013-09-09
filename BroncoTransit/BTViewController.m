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
    BOOL shouldFocusPin;
}

@end

@implementation BTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    map.delegate = self;
    map.showsBuildings = YES;
    map.showsPointsOfInterest = YES;
    map.showsUserLocation = YES;
    
    self.navigationItem.title = @"Brown";
    
    BTBus *bus = [[BTBus alloc] initWithDelegate:self busId:@9 andTitle:@"Brown"];
    [bus beginReceivingUpdates];
    annotation = bus;
    
    MKCoordinateRegion region = MKCoordinateRegionMake(bus.coordinate, MKCoordinateSpanMake(.01, .01));
    [map addAnnotation:bus];
    [map setRegion:region animated:YES];
    
    // add pan gesture recognizer to the map view
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan)];
    pan.delegate = self;
    [map addGestureRecognizer:pan];
    
    shouldFocusPin = YES;
    self.resumeButtonOutlet.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)busCoordinatesDidChange:(id)sender {
    BTBus *src = (BTBus *)sender;
    NSLog(@"%@: got new bus coordinates: %f, %f", src.title, annotation.coordinate.latitude, annotation.coordinate.longitude);
    
    if (shouldFocusPin) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [map setCenterCoordinate:annotation.coordinate];
        
        [UIView commitAnimations];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)incoming {
    
    if ([incoming isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *view = [[MKAnnotationView alloc] initWithAnnotation:incoming reuseIdentifier:@"annotationReuse"];
    view.image = [UIImage imageNamed:[NSString stringWithFormat:@"logo-%@.png", annotation.color]];
    
    return view;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didPan {
    shouldFocusPin = NO;
    self.resumeButtonOutlet.hidden = NO;
}

- (IBAction)resumeButton:(id)sender {
    shouldFocusPin = YES;
    [self busCoordinatesDidChange:self];
    self.resumeButtonOutlet.hidden = YES;
}

- (void)switchRoute:(NSNumber *)busId withName:(NSString *)routeName {
    [map removeAnnotation:annotation];
    [annotation stopReceivingUpdates];
    annotation = nil;
    
    BTBus *bus = [[BTBus alloc] initWithDelegate:self busId:busId andTitle:routeName];
    [bus beginReceivingUpdates];
    self.navigationItem.title = bus.title;
    annotation = bus;
    [map addAnnotation:annotation];
}
@end
