//
//  BTBus.m
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import "BTBus.h"

@interface BTBus () {
    id<BTBusDelegate> delegate;
}

@end

@implementation BTBus

- (id)initWithDelegate:(id<BTBusDelegate>)del busId:(NSNumber *)busId andTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        delegate = del;
        _busId = busId;
        _title = title;
    }
    return self;
}

- (void)beginReceivingUpdates {
    NSString *urlString = [NSString stringWithFormat:@"http://aead1.auxe.wmich.edu/BroncoTransit/xml/gps%@.xml", self.busId];
    NSString *xml = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@", xml);
}

@end
