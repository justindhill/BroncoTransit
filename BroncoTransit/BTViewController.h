//
//  BTViewController.h
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BTBusDelegate.h"

@interface BTViewController : UIViewController <BTBusDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *resumeButtonOutlet;
- (IBAction)resumeButton:(id)sender;
- (void)didPan;

- (void)switchRoute:(NSNumber *)busId withName:(NSString *)routeName;

@end
