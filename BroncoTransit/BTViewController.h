//
//  BTViewController.h
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "BTBusDelegate.h"
#import "AMBlurView.h"
#import "BTRoute.h"

@interface BTViewController : UIViewController <BTBusDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet AMBlurView *resumeButtonContainer;
@property (weak, nonatomic) IBOutlet UILabel *stopNameLabel;
@property (weak, nonatomic) IBOutlet AMBlurView *distanceContainer;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resumeButtonVSpace;

@property (weak, nonatomic) BTRoute *currentRoute;

- (IBAction)resumeButton:(id)sender;
- (void)didPan;

- (void)switchRoute:(NSNumber *)routeIndex;

@end
