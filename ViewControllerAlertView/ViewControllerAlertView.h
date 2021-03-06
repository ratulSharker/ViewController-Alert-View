//
//  ViewControllerAlertView.h
//
//  Created by Ratul Sharker on 1/28/16.
//  Copyright © 2016 REVE Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

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
};

/*______________________________________________________
 |                                                      |
 |  Completion block declaration to be used in          |
 |  automatically hideout or showup methods.            |
 |______________________________________________________|
*/
typedef void (^ViewControllerAlertViewCompletionBlok)();


/*______________________________________________________
 |                                                      |
 |  Declaration of the ViewControllerAlertViewDelegate, |
 |  which can be used for various state change of the   |
 |  subclassed "YourCustomAlertView" from the           |
 |  ViewControllerAlertView. All it's protocol methods  |
 |  are optional                                        |
 |______________________________________________________|
*/
@protocol ViewControllerAlertViewDelegate <NSObject>
@optional
/*__________________________________________________________________________________
 |                                                                                  |
 |  "viewControllerAlertViewWillAppear:" is meant to called when the subclassed     |
 |  "YourCustomAlertView's" showup animation is about to start. To be specific      |
 |  its called before the animation started. A ViewControllerAlertView object is    |
 |  passed to determine for which ViewControllerAlertView this particular delegate  |
 |  is called.                                                                      |
 |__________________________________________________________________________________|
*/
-(void)viewControllerAlertViewWillAppear    :(ViewControllerAlertView*)vcav;

/*__________________________________________________________________________________
 |                                                                                  |
 |  "viewControllerAlertViewDidAppear:" is meant to called when the subclassed      |
 |  "YourCustomAlertView's" showup animation ended. To be specific its              |
 |  called just after the animation completed. A ViewControllerAlertView object is  |
 |  passed to determine for which ViewControllerAlertView this particular delegate  |
 |  is called.                                                                      |
 |__________________________________________________________________________________|
*/
-(void)viewControllerAlertViewDidAppear     :(ViewControllerAlertView*)vcav;

/*______________________________________________________________________________________
 |                                                                                      |
 |  "viewControllerAlertViewWillDisappear:" is meant to called when the subclassed      |
 |  "YourCustomAlertView's" hideout animation about to start. To be specific its        |
 |  called just after the animation completed. A ViewControllerAlertView object is      |
 |  passed to determine for which ViewControllerAlertView this particular delegate      |
 |  is called.                                                                          |
 |______________________________________________________________________________________|
*/
-(void)viewControllerAlertViewWillDisappear :(ViewControllerAlertView*)vcav;

/*______________________________________________________________________________________
 |                                                                                      |
 |  "viewControllerAlertViewDiddisappear:" is meant to called when the subclassed       |
 |  "YourCustomAlertView's" hideout animation ended. To be specific its                 |
 |  called just after the animation completed. A ViewControllerAlertView object is      |
 |  passed to determine for which ViewControllerAlertView this particular delegate      |
 |  is called.                                                                          |
 |______________________________________________________________________________________|
*/
-(void)viewControllerAlertViewDiddisappear  :(ViewControllerAlertView*)vcav;

@end




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


/*______________________________________________________
 |                                                      |
 |  a static class method, which is meant to act as a   |
 |  factory method for the ViewControllerAlertView.     |
 |______________________________________________________|
*/
+(ViewControllerAlertView*)makeAnAlert:(NSString*)storyboardName;


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
              onComplete:(ViewControllerAlertViewCompletionBlok) completion;

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
                   onComplete:(ViewControllerAlertViewCompletionBlok)completion;
@end
