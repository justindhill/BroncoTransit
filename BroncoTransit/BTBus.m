//
//  BTBus.m
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import "BTBus.h"

@interface BTBus ()

@end

@implementation BTBus

- (id)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate andSubtitle:(NSString *)subtitle
{
    self = [super init];
    if (self) {
        if (title) {
            _title = title;
        }
        
        if (coordinate.latitude && coordinate.longitude) {
            _coordinate = coordinate;
        }
        
        if (subtitle) {
            _subtitle = subtitle;
        }
    }
    return self;
}

@end
