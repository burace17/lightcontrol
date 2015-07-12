//
//  LightControl.h
//  lightcontrol
//
//  Created by blair on 7/3/15.
//  Copyright (c) 2015 burace17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LightController : NSObject

- (void)sendCommand:(NSString *)command toLight:(NSString *)light;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (NSString *)updateAttr:(NSString *)attr withValue:(int)value;
- (NSString *)toggleSwitch:(UISwitch *)lightSwitch handlingAttribute:(NSString *)attr;
- (NSString *)toggleSwitch:(UISwitch *)lightSwitch handlingAttribute:(NSString *)attr withPossibleValues:(NSArray *)values;
- (void)getLightState:(NSString *)light completionHandler:(void (^)(NSDictionary *results))handler;

@end