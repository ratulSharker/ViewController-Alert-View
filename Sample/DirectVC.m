//
//  ViewController.m
//  ViewControllerAlertView
//
//  Created by Ratul Sharker on 3/29/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "DirectVC.h"
#import "CustomAlert.h"


@interface DirectVC ()

@end

@implementation DirectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //
    //  this will actually hide the topmost root UINavigationController
    //
    self.navigationController.navigationBarHidden = YES;
}


#pragma mark IBActions
-(IBAction)onShowCustomAlert:(id)sender
{
    NSLog(@"show on");
    CustomAlert *myAlert = (CustomAlert*) [CustomAlert makeAnAlert:@"custom_alert"];
    [myAlert setJumpInOutAnimationPoint:CGPointZero shouldUseCustomJumpPoint:YES];
    [myAlert showOn:self WithAnimation:SHOW_WITH_JUMP_IN];
}

-(IBAction)onShowOnTopOfTabbar:(id)sender
{
    CustomAlert *myAlert = (CustomAlert*) [CustomAlert makeAnAlert:@"custom_alert"];
    [myAlert showOn:self.parentViewController WithAnimation:SHOW_WITH_DAMPING];
    [myAlert hideAutomaticallyAfter:3.0 withAnimation:HIDE_WITH_DAMPING onComplete:^{
        NSLog(@"hiding done");
    }];
}

-(IBAction)onPushAVCOnRootNavPressed:(id)sender
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"on_root_push_vc"];
    UINavigationController *rootNav = (UINavigationController*)self.parentViewController.parentViewController;
    
    [rootNav pushViewController:viewController animated:YES];
}


@end
