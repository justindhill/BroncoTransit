//
//  BTBus.h
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "BTBusDelegate.h"
#import "BTAppDelegate.h"
#import "TBXML.h"

@interface BTBus : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) GMSMarker *marker;
@property (strong) NSDictionary *routeInfo;
@property (readonly) NSString *title;
@property (readonly) NSString *color;

- (id)initWithDelegate:(id<BTBusDelegate>)del map:(GMSMapView *)map andRouteInfo:(NSDictionary *)routeInfo;
- (void)beginReceivingUpdates;
- (void)getPositionUpdate;
- (void)stopReceivingUpdates;

@end
