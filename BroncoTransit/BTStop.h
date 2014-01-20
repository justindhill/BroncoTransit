//
//  BTStop.h
//  BroncoTransit
//
//  Created by Justin Hill on 1/19/14.
//  Copyright (c) 2014 Justin Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTStop : NSObject

- (id)initWithName:(NSString *)name latitude:(float)latitude longitude:(float)longitude;

- (id)initWithInfoDictionary:(NSDictionary *)dictionary;

- (float)distanceToCoordinates:(CGPoint)coordinates;

@property (nonatomic, strong) NSString *name;
@property float latitude;
@property float longitude;

@end
