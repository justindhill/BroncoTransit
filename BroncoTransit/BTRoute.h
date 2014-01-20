//
//  BTRoute.h
//  BroncoTransit
//
//  Created by Justin Hill on 1/19/14.
//  Copyright (c) 2014 Justin Hill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTStop.h"

@interface BTRoute : NSObject

- (id)initWithInfoDictionary:(NSDictionary *)dictionary;
- (BTStop *)closestStopToCoordinates:(CGPoint)coordinates;

@property (readonly) UIImage *icon;
@property (nonatomic, strong) NSArray *stops;
@property (nonatomic, strong) NSString *name;
@property NSInteger busId;

@end
