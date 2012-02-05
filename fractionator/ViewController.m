//
//  ViewController.m
//  fractionator
//
//  Created by Gary Foster on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize numerator_1;
@synthesize numerator_2;
@synthesize denominator_1;
@synthesize denominator_2;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNumerator_1:nil];
    [self setNumerator_2:nil];
    [self setDenominator_1:nil];
    [self setDenominator_2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)button_press:(id)sender {
    int which_button = [sender tag];
    double result;
    
    UIButton *button = (UIButton *) [self.view viewWithTag:which_button];
    
    NSString *buttonTitle = button.currentTitle;
    
    if (buttonTitle == @"clear") {
        UITextField *field = (UITextField *) [self.view viewWithTag:which_button + 4];
        [field setText:@""];
        [self number_entered:sender];
    } else {
        UITextField *num1 = (UITextField *) [self.view viewWithTag:5];
        UITextField *num2 = (UITextField *) [self.view viewWithTag:6];
        UITextField *den1 = (UITextField *) [self.view viewWithTag:7];
        UITextField *den2 = (UITextField *) [self.view viewWithTag:8];

        double a = [num1.text doubleValue];
        double b = [num2.text doubleValue];
        double c = [den1.text doubleValue];
        double d = [den2.text doubleValue];
        
        switch (which_button) {
            case 1:
                result = (b * c) / d;
                break;
            case 2:
                result = (a * d) / c;
                break;
            case 3:
                result = (a * d) / b;
                break;
            case 4:
                result = (b * c) / a;
                break;
        }
        
        // now figure out which text field we need to update
        
        UITextField *field = (UITextField *) [self.view viewWithTag:which_button + 4];

        field.text = [NSString stringWithFormat:@"%g",result];
        
        [sender setTitle:@"clear" forState:UIControlStateNormal];
        
        NSLog(@"Result is %g", result);
    }
}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn: (UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)number_entered:(id)sender {
    int which_field;
    int which_button;
    int num_entries = 0;
   
    for (which_button = 1; which_button < 5; which_button++) {
        which_field = which_button + 4;
        
        UITextField *field  = (UITextField *) [self.view viewWithTag:which_field];
        UIButton    *button = (UIButton *)    [self.view viewWithTag:which_button];
        
        NSString *value = field.text;
        if ([value length] > 0) {
            NSLog(@"Enabling button #%i", which_button);
            [button setEnabled:YES];
            [button setTitle:@"clear" forState:UIControlStateNormal];
            num_entries++;
        } else {
            NSLog(@"Disabling button #%i", which_button);
            [button setEnabled:NO];
            [button setTitle:@"" forState:UIControlStateNormal];
        }
    }
    
    // now that we've enabled/disabled all our appropriate buttons, figure out if we need
    // to set one up as a solve button
    
    if (num_entries == 3) {
        for (which_button = 1; which_button < 5; which_button++) {
            which_field = which_button + 4;
            
            UITextField *field  = (UITextField *) [self.view viewWithTag:which_field];
            UIButton    *button = (UIButton *)    [self.view viewWithTag:which_button];
            
            NSString *value = field.text;
            if ([value length] == 0) {
                NSLog(@"Setting solve button #%i", which_button);
                [button setEnabled:YES];
                [button setTitle:@"solve" forState:UIControlStateNormal];
            }
        }
    }
}

- (IBAction)clear_all:(id)sender {
    int which_field;
    for (which_field = 5; which_field < 9; which_field++) {
        
        UITextField *field  = (UITextField *) [self.view viewWithTag:which_field];
        [field setText:@""];
    }
    [self number_entered:sender];
}

@end
