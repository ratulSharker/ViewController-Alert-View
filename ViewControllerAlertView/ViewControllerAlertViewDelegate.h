//
//  ViewControllerAlertViewDelegate.h
//  ViewControllerAlertView
//
//  Created by Ratul Sharker on 10/14/16.
//  Copyright © 2016 test. All rights reserved.
//

#ifndef ViewControllerAlertViewDelegate_h
#define ViewControllerAlertViewDelegate_h

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

#endif /* ViewControllerAlertViewDelegate_h */
