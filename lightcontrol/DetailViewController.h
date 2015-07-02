//
//  DetailViewController.h
//  lightcontrol
//
//  Created by blair on 7/2/15.
//  Copyright (c) 2015 burace17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

