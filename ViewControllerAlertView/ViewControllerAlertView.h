//
//  ViewControllerAlertView.h
//  Ajura
//
//  Created by Ratul Sharker on 1/28/16.
//  Copyright © 2016 REVE Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewControllerAlertView;

enum PREDEFINED_ANIMATION
{
    SHOW_WITH_DAMPING,
    HIDE_WITH_DAMPING,
    
    SHOW_WITH_FADE_IN,
    HIDE_WITH_FADE_OUT
    
};

@protocol ViewControllerAlertViewDelegate <NSObject>
@optional
-(void)viewControllerAlertViewWillAppear:(ViewControllerAlertView*)vcav;
-(void)viewControllerAlertViewDidAppear:(ViewControllerAlertView*)vcav;
-(void)viewControllerAlertViewWillDisappear:(ViewControllerAlertView*)vcav;
-(void)viewControllerAlertViewDiddisappear:(ViewControllerAlertView*)vcav;

@end

@interface ViewControllerAlertView : UIViewController

@property  (strong) id<ViewControllerAlertViewDelegate> vcavDelegate;

+(ViewControllerAlertView*)makeAnAlert:(NSString*)storyboardName;

-(void)showOn:(UIViewController*)alertHolder;

-(void)hide;
-(void)hide:(void (^)(void)) completion;
@end
