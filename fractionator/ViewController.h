//
//  ViewController.h
//  fractionator
//
//  Created by Gary Foster on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *numerator_1;
@property (weak, nonatomic) IBOutlet UITextField *numerator_2;
@property (weak, nonatomic) IBOutlet UITextField *denominator_1;
@property (weak, nonatomic) IBOutlet UITextField *denominator_2;

- (IBAction)button_press:(id)sender;
- (IBAction)number_entered:(id)sender;
- (IBAction)clear_all:(id)sender;

@end
