//
//  ViewControllerAlertViewDampingInOutAnimation.h
//  ViewControllerAlertView
//
//  Created by Ratul Sharker on 10/14/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerAlertViewTransitionAnimtationDelegate.h"

@interface ViewControllerAlertViewDampingInOutAnimation : NSObject <ViewControllerAlertViewTransitionAnimationDelegate>

+(ViewControllerAlertViewDampingInOutAnimation*)getSharedDampingAnimtation;


@end
