//
//  BTStop.m
//  BroncoTransit
//
//  Created by Justin Hill on 1/19/14.
//  Copyright (c) 2014 Justin Hill. All rights reserved.
//

#import <math.h>
#import "BTStop.h"

#define TO_RAD(degrees) ((degrees) * (M_PI / 180.))

@implementation BTStop

- (id)initWithName:(NSString *)name latitude:(float)latitude longitude:(float)longitude
{
    if (self = [super init])
    {
        self.name = name;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    
    return self;
}

- (id)initWithInfoDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.name = dictionary[@"label"];
        self.latitude = [dictionary[@"y"] floatValue];
        self.longitude = [dictionary[@"x"] floatValue];
    }
    
    return self;
}

- (float)distanceToCoordinates:(CGPoint)coordinates
{
    float R = 3959;
    
    float dLat = TO_RAD(self.latitude - coordinates.y);
    float dLong = TO_RAD(self.longitude - coordinates.x);
    
    float lat1 = TO_RAD(coordinates.y);
    float lat2 = TO_RAD(self.latitude);
    
    float a = sinf(dLat / 2) * sinf(dLat / 2) + sinf(dLong / 2) * sinf(dLong / 2) * cosf(lat1) * cosf(lat2);
    float c = 2 * atan2f(sqrtf(a), sqrtf(1 - a));
    float d = R * c;
 
    return d;
}

@end
