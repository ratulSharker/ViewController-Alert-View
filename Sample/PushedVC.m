//
//  PushedVC.m
//  ViewControllerAlertView
//
//  Created by Ratul Sharker on 3/29/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "PushedVC.h"
#import "CustomAlert.h"

@interface PushedVC ()

@end

@implementation PushedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark IBAction
-(IBAction)showOnTopOfPushedVCPressed:(id)sender
{
    CustomAlert *myAlert = (CustomAlert*) [CustomAlert makeAnAlert:@"custom_alert"];
    [myAlert showOn:self WithAnimation:SHOW_WITH_DAMPING];
}

-(IBAction)showOnTopOfNavigationOfPushedVCPressed:(id)sender
{
    CustomAlert *myAlert = (CustomAlert*) [CustomAlert makeAnAlert:@"custom_alert"];
    [myAlert showOn:self.parentViewController WithAnimation:SHOW_WITH_DAMPING];
}

-(IBAction)showOnTopOfTabbarControllerPressed:(id)sender
{
    CustomAlert *myAlert = (CustomAlert*) [CustomAlert makeAnAlert:@"custom_alert"];
    [myAlert showOn:self.parentViewController.parentViewController WithAnimation:SHOW_WITH_DAMPING];
}

-(IBAction)showFromArbitaryJumpPosition:(UIButton*)sender
{
    CustomAlert *myAlert = (CustomAlert*)[CustomAlert makeAnAlert:@"custom_alert"];
    
    UITabBarController *tabbar = (UITabBarController*)self.parentViewController.parentViewController;
    
    CGPoint targetPoint = [self.view convertPoint:sender.center toView:tabbar.view];
    [myAlert setJumpInOutAnimationPoint:targetPoint shouldUseCustomJumpPoint:YES];
    [myAlert showOn:tabbar WithAnimation:SHOW_WITH_JUMP_IN];
}

@end
