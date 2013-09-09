//
//  BTBus.h
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BTBusDelegate.h"
#import "TBXML.h"

@interface BTBus : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property NSNumber *busId;
@property (readonly) NSString *color;

- (id)initWithDelegate:(id<BTBusDelegate>)del busId:(NSNumber *)busId andTitle:(NSString *)title;
- (void)beginReceivingUpdates;
- (void)getPositionUpdate;
- (void)stopReceivingUpdates;

@end