//
//  RootPushedVC.m
//  ViewControllerAlertView
//
//  Created by Ratul Sharker on 3/30/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "RootPushedVC.h"
#import "CustomAlert.h"


@interface RootPushedVC ()

@end

@implementation RootPushedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
-(IBAction)onShowAlertOnTopRootVCPressed:(id)sender
{
    CustomAlert *customAlert = (CustomAlert*)[CustomAlert makeAnAlert:@"custom_alert"];
    [customAlert showOn:self WithAnimation:SHOW_WITH_DAMPING];
}

-(IBAction)onShowAlertOnTopRootNavPressed:(id)sender
{
    CustomAlert *customAlert = (CustomAlert*)[CustomAlert makeAnAlert:@"custom_alert"];
    [customAlert showOn:self.parentViewController WithAnimation:SHOW_WITH_DAMPING];
}

@end
