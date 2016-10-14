//
//  ViewControllerAlertViewDampingInOutAnimation.m
//  ViewControllerAlertView
//
//  Created by Ratul Sharker on 10/14/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewControllerAlertViewDampingInOutAnimation.h"
#import "ViewControllerAlertView.h"

@implementation ViewControllerAlertViewDampingInOutAnimation


+(ViewControllerAlertViewDampingInOutAnimation*)getSharedDampingAnimtation
{
    static ViewControllerAlertViewDampingInOutAnimation *staticSingleToneObj;
    
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        staticSingleToneObj = [[ViewControllerAlertViewDampingInOutAnimation alloc] init];
    });
    
    return staticSingleToneObj;
}

-(void)viewControllerAlertView:(ViewControllerAlertView*)viewControllerAlertView
                    willShowIn:(UIViewController*)alertHolder
            withAnimationParam:(NSDictionary*)animationParam
           withCompletionBlock:(ViewControllerAlertViewGeneralPurposeBlock) completionBlock;
{
    //initially disable the both view controller
    alertHolder.view.userInteractionEnabled = viewControllerAlertView.view.userInteractionEnabled = NO;
    
    //set initial frame
    CGRect originalFrame = alertHolder.view.frame;
    CGRect initialFrame = CGRectMake(originalFrame.origin.x,
                                     originalFrame.origin.y,
                                     originalFrame.size.width,
                                     originalFrame.size.height);
    initialFrame.origin.y = alertHolder.view.bounds.size.height;
    
    viewControllerAlertView.view.frame = initialFrame;
    viewControllerAlertView.view.backgroundColor = [UIColor clearColor];
    [alertHolder.view addSubview:viewControllerAlertView.view];
    
    [UIView animateWithDuration:1.0
                          delay:0.1
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.1
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         
                         viewControllerAlertView.view.frame = originalFrame;
                         
                     } completion:^(BOOL finshed){
                         //call delegate that this view controller is shown
                         
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              viewControllerAlertView.view.backgroundColor = [UIColor colorWithRed:50.0/255.0
                                                                                          green:50.0/255.0
                                                                                           blue:50.0/255.0
                                                                                          alpha:0.85];
                                          }];
                         
                         if(completionBlock){
                             completionBlock();
                         }

                         //now enable the both view controller
                         alertHolder.view.userInteractionEnabled = viewControllerAlertView.view.userInteractionEnabled = YES;
                     }];
}

-(void)viewControlleralertView:(ViewControllerAlertView*)viewControllerAlertView
                  willHideFrom:(UIViewController*)alertHolder
            withAnimationParam:(NSDictionary*)animationParam
           withCompletionBlock:(ViewControllerAlertViewGeneralPurposeBlock)completionBlock;
{
    //initially disable the both view controller
    alertHolder.view.userInteractionEnabled = viewControllerAlertView.view.userInteractionEnabled = NO;
    
    if(alertHolder)
    {
        
        CGRect animatedFrame = viewControllerAlertView.view.frame;
        animatedFrame.origin.y = alertHolder.view.frame.size.height;
        
        viewControllerAlertView.view.backgroundColor = [UIColor clearColor];
        
        [UIView animateWithDuration:1.0
                              delay:0.1
             usingSpringWithDamping:0.4
              initialSpringVelocity:0.1
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             
                             viewControllerAlertView.view.frame = animatedFrame;
                             
                         } completion:^(BOOL finished) {
                             //if(finished)
                             {
                                 [viewControllerAlertView removeFromParentViewController];
                                 [viewControllerAlertView.view removeFromSuperview];
                                 [viewControllerAlertView willMoveToParentViewController:nil];
                                 

                                 
                                 //now enable the both view controller
                                 alertHolder.view.userInteractionEnabled = viewControllerAlertView.view.userInteractionEnabled = YES;
                             }
                         }];
    }
}

@end
