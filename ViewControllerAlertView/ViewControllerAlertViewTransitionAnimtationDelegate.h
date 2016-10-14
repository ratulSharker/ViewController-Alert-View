//
//  ViewControllerAlertViewTransitionAnimtationDelegate.h
//  ViewControllerAlertView
//
//  Created by Ratul Sharker on 10/14/16.
//  Copyright © 2016 test. All rights reserved.
//

#ifndef ViewControllerAlertViewTransitionAnimtationDelegate_h
#define ViewControllerAlertViewTransitionAnimtationDelegate_h

#import <UIkit/UIKit.h>

/*______________________________________________________
 |                                                      |
 |  Forward declaration of the ViewControllerAlertView  |
 |  class because we are about to use this class        |
 |  type in the ViewControllerAlertViewDelegate         |
 |______________________________________________________|
 */
@class ViewControllerAlertView;

/*______________________________________________________
 |                                                      |
 |  Completion block declaration to be used in          |
 |  automatically hideout or showup methods.            |
 |______________________________________________________|
 */
typedef void (^ViewControllerAlertViewGeneralPurposeBlock)();


@protocol ViewControllerAlertViewTransitionAnimationDelegate <NSObject>
@required
/*
    ratul todo -- write the documentation
 */
-(void)viewControllerAlertView:(ViewControllerAlertView*)viewControllerAlertView
                    willShowIn:(UIViewController*)alertHolder
            withAnimationParam:(NSDictionary*)animationParam
           withCompletionBlock:(ViewControllerAlertViewGeneralPurposeBlock) completionBlock;

/*
    ratul todo -- write the documentation
 */
-(void)viewControlleralertView:(ViewControllerAlertView*)viewControllerAlertView
                  willHideFrom:(UIViewController*)alertHolder
            withAnimationParam:(NSDictionary*)animationParam
           withCompletionBlock:(ViewControllerAlertViewGeneralPurposeBlock)completionBlock;
@end


#endif /* ViewControllerAlertViewTransitionAnimtationDelegate_h */
