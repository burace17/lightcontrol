//
//  DetailViewController.h
//  lightcontrol
//
//  Created by blair on 7/2/15.
//  Copyright (c) 2015 burace17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LightControlKit/LightControlKit.h>

@interface DetailViewController : UITableViewController <NSURLConnectionDataDelegate> {
    NSString *lightURL;
    NSString *lightStateURL;
    
    LightController *lightControl;
    
    IBOutlet UITableViewCell *powerCell;
    IBOutlet UITableViewCell *brightnessCell;
    
    IBOutlet UITableViewCell *hueCell;
    IBOutlet UITableViewCell *saturationCell;
    IBOutlet UITableViewCell *colorLoopCell;
    
    IBOutlet UISwitch *powerSwitch;
    IBOutlet UISwitch *colorLoopSwitch;
    
    IBOutlet UISlider *brightnessSlider;
    IBOutlet UISlider *saturationSlider;
    
    IBOutlet UITextField *hue;
}

- (IBAction)powerSwitchChanged:(id)sender;
- (IBAction)colorLoopSwitchChanged:(id)sender;
- (IBAction)brightnessChanged:(id)sender;
- (IBAction)saturationChanged:(id)sender;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property NSString *light;
@end

