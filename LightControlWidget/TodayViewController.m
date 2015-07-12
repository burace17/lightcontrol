//
//  TodayViewController.m
//  LightControlWidget
//
//  Created by blair on 7/3/15.
//  Copyright (c) 2015 burace17. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(0, 150);
    // Do any additional setup after loading the view from its nib.
    lightControl = [LightController new];
    lightURL = @"http://burace17.net:1337/info/1";
    lightStateURL = @"http://burace17.net:1337/set/1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
   
    [lightControl getLightState:lightURL completionHandler:^(NSDictionary *lightState) {
        if ([lightState[@"on"] boolValue]) {
            [powerSwitch setOn:YES animated:YES];
        } else {
            [powerSwitch setOn:NO animated:YES];
        }
        completionHandler(NCUpdateResultNewData);
    }];
}

- (IBAction)powerSwitchChanged:(id)sender {
    NSString *command = [lightControl toggleSwitch:powerSwitch handlingAttribute:@"on"];
    [lightControl sendCommand:command toLight:lightStateURL];
}

@end
