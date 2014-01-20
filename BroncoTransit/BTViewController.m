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
    BTBus *_annotation;
    BTRoute *_route;
    BOOL _shouldFocusPin;
    CLLocationManager *_locationManager;
}

@end

@implementation BTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up map, focused on Kalamazoo, MI
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:42.2832 longitude:-85.6152 zoom:17];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.rotateGestures = NO;
    self.navigationItem.title = @"Brown";
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    // navigation controller
    self.navigationController.navigationBar.barTintColor = RGBA(51., 25., 0., 1.);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor] };
    
    // blur view for distance indicator
    self.distanceContainer.blurTintColor = RGBA(51., 25., 0., 1.);
    
    // pan recognizer
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan)];
    pan.delegate = self;
    [self.mapView addGestureRecognizer:pan];
    
    // defaults
    _shouldFocusPin = YES;
    self.resumeButtonOutlet.hidden = YES;
    
    // the brown route
    [self switchRoute:@0];
    
    [self updateClosestStop];
}

- (void)busCoordinatesDidChange:(id)sender {
    BTBus *src = (BTBus *)sender;
    NSLog(@"%@: got new bus coordinates: %f, %f", src.title, _annotation.coordinate.latitude, _annotation.coordinate.longitude);
    
    [self updateClosestStop];
    
    if (_shouldFocusPin) {
        [self.mapView animateToLocation:_annotation.coordinate];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didPan {
    _shouldFocusPin = NO;
    self.resumeButtonOutlet.hidden = NO;
}

- (IBAction)resumeButton:(id)sender {
    _shouldFocusPin = YES;
    [self busCoordinatesDidChange:self];
    self.resumeButtonOutlet.hidden = YES;
}

- (void)switchRoute:(NSNumber *)routeIndex {
    BTAppDelegate *d = (BTAppDelegate *)[[UIApplication sharedApplication] delegate];
    _route = [[BTRoute alloc] initWithInfoDictionary:d.routes[routeIndex.intValue]];
    [_annotation stopReceivingUpdates];
    _annotation = nil;
    
    BTBus *bus = [[BTBus alloc] initWithDelegate:self map:self.mapView andRoute:_route];
    [bus beginReceivingUpdates];
    self.navigationItem.title = _route.name;
    _shouldFocusPin = YES;
    _annotation = bus;
}

- (void)updateClosestStop
{
    CLLocation *loc = _mapView.myLocation;
    CGPoint coords = CGPointMake(loc.coordinate.longitude, loc.coordinate.latitude);
    BTStop *stop = [_route closestStopToCoordinates:coords];
    float distance = [stop distanceToCoordinates:coords];
    
    self.stopNameLabel.text = [NSString stringWithFormat:@"%@ (%@)", stop.name, [self displayTextForDistanceInMiles:distance]];
};

- (NSString *)displayTextForDistanceInMiles:(float)miles
{
    if (miles < .5)
    {
        return [NSString stringWithFormat:@"%i ft", (int)(miles * 5280)];
    }
    else
    {
        return [NSString stringWithFormat:@"%.1lf miles", miles];
    }
}
@end
