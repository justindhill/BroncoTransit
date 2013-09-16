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
    GMSMapView *map;
    BTBus *annotation;
    BOOL shouldFocusPin;
}

@end

@implementation BTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:42.2832 longitude:-85.6152 zoom:16];
    map = [GMSMapView mapWithFrame:self.mapView.bounds camera:camera];
    map.myLocationEnabled = YES;
    self.view = map;
    //[self.view addSubview:map];
    //[self.view bringSubviewToFront:map];
    
    self.navigationItem.title = @"Brown";
    
    //BTBus *bus = [[BTBus alloc] initWithDelegate:self map:map busId:@9 andTitle:@"Brown"];
    //[bus beginReceivingUpdates];
    //annotation = bus;
    
    // add pan gesture recognizer to the map view
    //UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan)];
//    pan.delegate = self;
//    [map addGestureRecognizer:pan];
    
    shouldFocusPin = YES;
    //self.resumeButtonOutlet.hidden = YES;
    //[self.view bringSubviewToFront:self.resumeButtonOutlet];
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
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.25];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [map animateToLocation:annotation.coordinate];
        //[map setCenterCoordinate:annotation.coordinate];
        
//        [UIView commitAnimations];
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

- (void)switchRoute:(NSNumber *)busId withName:(NSString *)routeName {
    [annotation stopReceivingUpdates];
    annotation = nil;
    
    BTBus *bus = [[BTBus alloc] initWithDelegate:self map:map busId:busId andTitle:routeName];
    [bus beginReceivingUpdates];
    self.navigationItem.title = bus.title;
    annotation = bus;
}
@end
