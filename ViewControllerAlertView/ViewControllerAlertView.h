//
//  ViewControllerAlertView.h
//
//  Created by Ratul Sharker on 1/28/16.
//  Copyright © 2016 REVE Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerAlertViewDelegate.h"
#import "ViewControllerAlertViewTransitionAnimtationDelegate.h"

//
//  default animtation implementation
//
#import "ViewControllerAlertViewDampingInOutAnimation.h"
#import "ViewControllerAlertViewFadingInOutAnimation.h"


/*______________________________________________________
 |                                                      |
 |  Animation enum declaration to be used with the      |
 |  show & the hide functionality of the                |
 |  ViewControllerAlertView class                       |
 |______________________________________________________|
*/
enum PREDEFINED_ANIMATION
{
    SHOW_WITH_DAMPING,
    HIDE_WITH_DAMPING,
    
    SHOW_WITH_FADE_IN,
    HIDE_WITH_FADE_OUT,
    
    SHOW_WITH_JUMP_IN,
    HIDE_WITH_JUMP_OUT
};






/*______________________________________________________
 |                                                      |
 |  "ViewControllerAlertView" class defination          |
 |______________________________________________________|
*/
@interface ViewControllerAlertView : UIViewController

/*______________________________________________________________________
 |                                                                      |
 |  "vcavDelegate" stands for "view controller alert view delegate".    |
 |  vcavDelegate is about to store the reference to the object,         |
 |  which is about to implement the "ViewControllerAlertViewDelegate"   |
 |  methods.                                                            |
 |______________________________________________________________________|
*/
@property  (strong) id<ViewControllerAlertViewDelegate> vcavDelegate;

/*
    TODO write the documentation
 */
@property  (strong) id<ViewControllerAlertViewTransitionAnimationDelegate> transitionAnimationDelegate;

/*______________________________________________________
 |                                                      |
 |  a static class method, which is meant to act as a   |
 |  factory method for the ViewControllerAlertView.     |
 |______________________________________________________|
*/
+(ViewControllerAlertView*)makeAnAlert:(NSString*)storyboardName;


/*______________________________________________________
 |                                                      |
 |  this method is in effect whenever the `jump in` or  |
 |  `jump out` animation param are in use. the param    |
 |  `jumpPoint` dictate the point from which point or   |
 |  to which point the whole alert will `jump in` or    |
 |  `jump out` to.                                      |
 |                                                      |
 |  in order not to use this feature don't need to      |
 |  call this method. It will `jump in` or `jump out`   |
 |  from or to center of the alertHolder.               |
 |                                                      |
 |  in case once you enabled this feature & don't want  |
 |  the feature after all, just call this method with   |
 |  arbitrary point with the `useJumpPoint` `NO` value. |
 |______________________________________________________|
 */
-(void)setJumpInOutAnimationPoint:(CGPoint)jumpPoint shouldUseCustomJumpPoint:(BOOL)useJumpPoint;

/*______________________________________________________
 |                                                      |
 |  this method is used to show the alert on top of any |
 |  UIViewController, UINavigationController or         |
 |  UITabbarController. Pass the controller as          |
 |  alertController parameter & specify the factory     |
 |  animation so that the alert can roll in with        |
 |  specified animation.                                |
 |______________________________________________________|
*/
-(void)showOn:(UIViewController*)alertHolder WithAnimation:(enum PREDEFINED_ANIMATION)anim;

/*______________________________________________________________________________
 |                                                                              |
 |  this method immediately hides the "YourCustomAlertView"                     |
 |  which is subclassed from "ViewControllerAlertView".                         |
 |  hiding animation will be the animation specified by the                     |
 |  anim parameter. pass a completion block, if anything                        |
 |  necessary to do in completion of hiding.                                    |
 |                                                                              |
 |  NB::    you already got "viewControllerAlertViewDiddisappear" delegate      |
 |          which serves the same purpose just an advantage it's gives a        |
 |          scope for less coding.                                              |
 |______________________________________________________________________________|
*/
-(void)hideWithAnimation:(enum PREDEFINED_ANIMATION)anim
              onComplete:(ViewControllerAlertViewGeneralPurposeBlock)completion;

/*__________________________________________________________________________________
 |                                                                                  |
 | this method is just like the "hideWithAnimation: onComplete:", but there is      |
 | a extra benefit of automatically hide the alert after a predefined time.         |
 | after "hidingTime" time passed, it's actually call the "hideWithAnimation..."    |
 |                                                                                  |
 |  NB::    you already got "viewControllerAlertViewDiddisappear" delegate          |
 |          which serves the same purpose just an advantage it's gives a            |
 |          scope for less coding.                                                  |
 |__________________________________________________________________________________|
*/
-(void)hideAutomaticallyAfter:(NSTimeInterval)hidingTime
                withAnimation:(enum PREDEFINED_ANIMATION)anim
                   onComplete:(ViewControllerAlertViewGeneralPurposeBlock)completion;
@end
