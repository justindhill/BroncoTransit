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
    NSTimer *timer;
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
    [self getPositionUpdate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getPositionUpdate) userInfo:nil repeats:YES];
}

- (void)stopReceivingUpdates {
    [timer invalidate];
}

- (void)getPositionUpdate {
    dispatch_queue_t globalConcurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    void (^fetch)(void) = ^{
        NSString *urlString = [NSString stringWithFormat:@"http://aead1.auxe.wmich.edu/BroncoTransit/xml/gps%@.xml", self.busId];
        NSString *xml = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
        
        CLLocationCoordinate2D coord = [self coordinateFromXml:xml];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setCoordinate:coord];
            [delegate busCoordinatesDidChange:self];
        });
    };
    dispatch_async(globalConcurrentQueue, fetch);
}

- (CLLocationCoordinate2D)coordinateFromXml:(NSString *)xml {
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:xml error:nil];
    
    TBXMLElement *bus = [TBXML childElementNamed:@"Bus" parentElement:tbxml.rootXMLElement];
    NSString *lat = [TBXML textForElement:[TBXML childElementNamed:@"lat" parentElement:bus]];
    NSString *longitude = [TBXML textForElement:[TBXML childElementNamed:@"long" parentElement:bus]];
    
    return CLLocationCoordinate2DMake([lat doubleValue], [longitude doubleValue]);
}

- (NSString *)color {
    switch (self.busId.intValue) {
        case 9:
            return @"brown";
        case 7:
            return @"yellow";
        case 1:
            return @"blue";
        case 5:
            return @"red";
        case 8:
            return @"red";
        default:
            return @"brown";
    }
}

@end
