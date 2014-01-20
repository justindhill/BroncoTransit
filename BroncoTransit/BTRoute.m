//
//  BTRoute.m
//  BroncoTransit
//
//  Created by Justin Hill on 1/19/14.
//  Copyright (c) 2014 Justin Hill. All rights reserved.
//

#import "BTRoute.h"

@implementation BTRoute

- (id)initWithInfoDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.name = dictionary[@"title"];
        self.busId = ((NSNumber *)dictionary[@"busId"]).integerValue;
        
        NSMutableArray *tempStops = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in dictionary[@"stops"])
        {
            BTStop *stop = [[BTStop alloc] initWithInfoDictionary:dict];
            [tempStops addObject:stop];
        }
        
        self.stops = [NSArray arrayWithArray:tempStops];
    }
    
    return self;
}


- (UIImage *) icon {
    NSString *color;
    switch (self.busId) {
        case 9:
            color = @"brown";
            break;
        case 4:
            color = @"yellow";
            break;
        case 1:
            color = @"blue";
            break;
        case 5:
            color = @"red";
            break;
        case 8:
            color = @"red";
            break;
        case 3:
            color = @"purple";
            break;
        default:
            color = @"brown";
            break;
    }
    
    return [UIImage imageNamed:[NSString stringWithFormat:@"logo-%@", color]];
}

- (BTStop *)closestStopToCoordinates:(CGPoint)coordinates
{
    float shortestDistance = INT32_MAX;
    BTStop *shortestStop;
    
    for (BTStop *stop in self.stops)
    {
        float distance = [stop distanceToCoordinates:coordinates];
        if (distance < shortestDistance)
        {
            shortestDistance = distance;
            shortestStop = stop;
        }
    }
    
    return shortestStop;
}

@end
