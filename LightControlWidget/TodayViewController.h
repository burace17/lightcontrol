//
//  TodayViewController.h
//  LightControlWidget
//
//  Created by blair on 7/3/15.
//  Copyright (c) 2015 burace17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LightControlKit/LightControlKit.h>

@interface TodayViewController : UIViewController {
    LightController *lightControl;
    NSString *lightURL;
    NSString *lightStateURL;
    
    IBOutlet UISwitch *powerSwitch;
}
- (IBAction)powerSwitchChanged:(id)sender;
@end
