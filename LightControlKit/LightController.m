//
//  LightControl.m
//  lightcontrol
//
//  Created by blair on 7/3/15.
//  Copyright (c) 2015 burace17. All rights reserved.
//

#import "LightController.h"

@implementation LightController

- (void)getLightState:(NSString *)light completionHandler:(void (^)(NSDictionary *results))handler {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:light]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error) {
             NSLog(@"Connection error: %@", [error localizedDescription]);
         }
         id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
         if (error) {
             NSLog(@"JSON error: %@", [error localizedDescription]);
         }
         if ([obj isKindOfClass:[NSDictionary class]]) {
             NSDictionary *result = obj;
             if ([result objectForKey:@"state"]) {
                 // Callback
                 handler(result[@"state"]);
             }
         }
     }];
}

- (void)sendCommand:(NSString *)command toLight:(NSString *)light {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:light]];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:[command dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *strdata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Received Data: %@", strdata);
}

- (NSString *)updateAttr:(NSString *)attr withValue:(int)value {
    return [NSString stringWithFormat:@"{\"bears\":0, \"%@\" : %d }", attr, value];
}

- (NSString *)toggleSwitch:(UISwitch *)lightSwitch handlingAttribute:(NSString *)attr {
    NSString *command = nil;
    if (lightSwitch.isOn) {
        command = [NSString stringWithFormat:@"{\"bears\":0, \"%@\" : true}", attr];
    } else {
        command = [NSString stringWithFormat:@"{\"bears\":0, \"%@\" : false}", attr];
    }
    return command;
}

// Values array: first element should be false state, second element should be true state.
- (NSString *)toggleSwitch:(UISwitch *)lightSwitch handlingAttribute:(NSString *)attr withPossibleValues:(NSArray *)values {
    NSString *command = nil;
    if (lightSwitch.isOn) {
        command = [NSString stringWithFormat:@"{\"bears\":0, \"%@\" : \"%@\"}", attr, values[1]];
    } else {
        command = [NSString stringWithFormat:@"{\"bears\":0, \"%@\" : \"%@\"}", attr, values[0]];
    }
    NSLog(@"Command: %@", command);
    return command;
}

@end