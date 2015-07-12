//
//  DetailViewController.m
//  lightcontrol
//
//  Created by blair on 7/2/15.
//  Copyright (c) 2015 burace17. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    self.navigationItem.title = _light;
    if ([_light isEqualToString:@"Nightstand"]) {
        lightURL = @"http://192.168.1.5:1337/info/1";
        lightStateURL = @"192.168.1.5:1337/set/1";
    } else if ([_light isEqualToString:@"My Room"]) {
        lightURL = @"http://192.168.1.5:1337/info/2";
        lightStateURL = @"http://192.168.1.5:1337/set/2";
    }
    
    lightControl = [LightController new];
    
    // Add labels to each cell
    // For some reason this isn't possible in interface builder?
    powerCell.textLabel.text = @"Power";
    powerCell.selectionStyle = UITableViewCellSelectionStyleNone;
    brightnessCell.textLabel.text = @"Brightness";
    brightnessCell.selectionStyle = UITableViewCellSelectionStyleNone;
    saturationCell.textLabel.text = @"Saturation";
    saturationCell.selectionStyle = UITableViewCellSelectionStyleNone;
    colorLoopCell.textLabel.text = @"Enable Color Loop";
    colorLoopCell.selectionStyle = UITableViewCellSelectionStyleNone;
    hueCell.textLabel.text = @"Hue";
    hueCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Add a toolbar to the number pad which will allow the user to dismiss it
    UIToolbar *numberPadToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberPadToolbar.barStyle = UIBarStyleDefault;
    numberPadToolbar.items = @[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(hueCanceled:)],
                               [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(hueChanged:)]];
    [numberPadToolbar sizeToFit];
    hue.inputAccessoryView = numberPadToolbar;
    
    // Get current light state and update user interface with received data
    [lightControl getLightState:lightURL completionHandler:^(NSDictionary *lightState) {
        if ([lightState[@"on"] boolValue]) {
            [powerSwitch setOn:YES animated:YES];
        } else {
            [powerSwitch setOn:NO animated:YES];
        }
        if ([lightState[@"effect"] isEqualToString:@"none"]) {
            [colorLoopSwitch setOn:NO animated:YES];
        } else {
            [colorLoopSwitch setOn:YES animated:YES];
        }
        [brightnessSlider setValue:[lightState[@"bri"] floatValue]];
        [saturationSlider setValue:[lightState[@"sat"] floatValue]];
        [hue setText:[lightState[@"hue"] stringValue]];

    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Interface Builder Actions

- (IBAction)powerSwitchChanged:(id)sender {
    NSString *command = [lightControl toggleSwitch:powerSwitch handlingAttribute:@"on"];
    [lightControl sendCommand:command toLight:lightStateURL];
}

- (IBAction)colorLoopSwitchChanged:(id)sender {
    NSString *command = [lightControl toggleSwitch:colorLoopSwitch handlingAttribute:@"effect" withPossibleValues:@[@"none", @"colorloop"]];
    [lightControl sendCommand:command toLight:lightStateURL];
}

- (IBAction)brightnessChanged:(id)sender {
    [lightControl sendCommand:[lightControl updateAttr:@"bri" withValue:[brightnessSlider value]] toLight:lightStateURL];
}

- (IBAction)saturationChanged:(id)sender {
    [lightControl sendCommand:[lightControl updateAttr:@"sat" withValue:[saturationSlider value]] toLight:lightStateURL];
}

- (void)hueChanged:(id)sender {
    [lightControl sendCommand:[lightControl updateAttr:@"hue" withValue:[[hue text] intValue]] toLight:lightStateURL];
    [hue resignFirstResponder];
}

- (void)hueCanceled:(id)sender {
    [hue resignFirstResponder];
}

@end
