//
//  BTBusDelegate.h
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@protocol BTBusDelegate <NSObject>

- (void)busCoordinatesDidChange:(id)sender;
    
@end
