//
//  BTAppDelegate.m
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import "BTAppDelegate.h"
#import "BTRoute.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation BTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyD4QUAhpCENkXmjCLtgKXgEotAMaRyJ-oQ"];
    self.routes = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"routes" ofType:@"plist"]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

@end
