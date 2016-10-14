//
//  ViewControllerAlertViewFadingInOutAnimation.m
//  ViewControllerAlertView
//
//  Created by Ratul Sharker on 10/14/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewControllerAlertViewFadingInOutAnimation.h"
#import "ViewControllerAlertView.h"

@implementation ViewControllerAlertViewFadingInOutAnimation


+(ViewControllerAlertViewFadingInOutAnimation*)getSharedFadingAnimation
{
    static ViewControllerAlertViewFadingInOutAnimation *staticSingleToneObj;
    
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        staticSingleToneObj = [[ViewControllerAlertViewFadingInOutAnimation alloc] init];
    });
    
    return staticSingleToneObj;
}

-(void)viewControllerAlertView:(ViewControllerAlertView *)viewControllerAlertView
                    willShowIn:(UIViewController *)alertHolder
            withAnimationParam:(NSDictionary *)animationParam
           withCompletionBlock:(ViewControllerAlertViewGeneralPurposeBlock)completionBlock
{
    //initially disable the both view controller
    alertHolder.view.userInteractionEnabled = viewControllerAlertView.view.userInteractionEnabled = NO;
    
    //set initial frame
    CGRect originalFrame = alertHolder.view.frame;
    
    viewControllerAlertView.view.frame = originalFrame;
    viewControllerAlertView.view.backgroundColor = [UIColor colorWithRed:50.0/255.0
                                                                   green:50.0/255.0
                                                                    blue:50.0/255.0
                                                                   alpha:0.85];
    viewControllerAlertView.view.alpha = 0.0;
    [alertHolder.view addSubview:viewControllerAlertView.view];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         
                         viewControllerAlertView.view.alpha = 1.0;
                         
                     } completion:^(BOOL finshed){
                         
                         if(completionBlock)
                             completionBlock();
                         
                         //now enable the both view controller
                         alertHolder.view.userInteractionEnabled = viewControllerAlertView.view.userInteractionEnabled = YES;
                     }];
}

-(void)viewControlleralertView:(ViewControllerAlertView *)viewControllerAlertView
                  willHideFrom:(UIViewController *)alertHolder
            withAnimationParam:(NSDictionary *)animationParam
           withCompletionBlock:(ViewControllerAlertViewGeneralPurposeBlock)completionBlock
{
    //initially disable the both view controller
    alertHolder.view.userInteractionEnabled = viewControllerAlertView.view.userInteractionEnabled = NO;
    
    if(alertHolder)
    {
        //call delegate that this view controller is about to hide
//        if(self.vcavDelegate &&
//           [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewWillDisappear:))]
//           )
//        {
//            [self.vcavDelegate viewControllerAlertViewWillDisappear:self];
//        }
        
        [UIView animateWithDuration:1.0
                         animations:^{
                             
                             viewControllerAlertView.view.alpha = 0.0;
                             
                         } completion:^(BOOL finished) {
                             //if(finished)
                             {
                                 [viewControllerAlertView removeFromParentViewController];
                                 [viewControllerAlertView.view removeFromSuperview];
                                 [viewControllerAlertView willMoveToParentViewController:nil];
                                 
//                                 //call delegate that this view controller is shown
//                                 if(self.vcavDelegate &&
//                                    [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewDiddisappear:))]
//                                    )
//                                 {
//                                     [self.vcavDelegate viewControllerAlertViewDiddisappear:self];
//                                 }
                                 
                                 //  if there is something to do in completion
                                 //  then execute it, otherwise just ignore
//                                 if(completion)
//                                 {
//                                     completion();
//                                 }
                                 
                                 if(completionBlock)
                                     completionBlock();
                                 
                                 //now enable the both view controller
                                 alertHolder.view.userInteractionEnabled = viewControllerAlertView.view.userInteractionEnabled = YES;
                             }
                         }];
    }
}


@end
