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
    BTBus *annotation;
    BOOL shouldFocusPin;
}

@end

@implementation BTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:42.2832 longitude:-85.6152 zoom:17];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.rotateGestures = NO;
    self.navigationItem.title = @"Brown";
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan)];
    pan.delegate = self;
    [self.mapView addGestureRecognizer:pan];
    
    shouldFocusPin = YES;
    self.resumeButtonOutlet.hidden = YES;
    
    // the brown route
    [self switchRoute:@0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)busCoordinatesDidChange:(id)sender {
    BTBus *src = (BTBus *)sender;
    NSLog(@"%@: got new bus coordinates: %f, %f", src.title, annotation.coordinate.latitude, annotation.coordinate.longitude);
    
    if (shouldFocusPin) {
        [self.mapView animateToLocation:annotation.coordinate];
    }
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

- (void)switchRoute:(NSNumber *)routeIndex {
    BTAppDelegate *d = (BTAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *route = d.routes[routeIndex.intValue];
    [annotation stopReceivingUpdates];
    annotation = nil;
    
    BTBus *bus = [[BTBus alloc] initWithDelegate:self map:self.mapView andRouteInfo:route];
    [bus beginReceivingUpdates];
    self.navigationItem.title = route[@"title"];
    shouldFocusPin = YES;
    annotation = bus;
}
@end
