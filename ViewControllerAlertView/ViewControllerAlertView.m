//
//  ViewControllerAlertView.m
//
//  Created by Ratul Sharker on 1/28/16.
//  Copyright © 2016 REVE Systems. All rights reserved.
//

#import "ViewControllerAlertView.h"

#define VIEWCONTROLLER_TIMER_USERINFO_ANIMATION_KEY     @"timer.animation.key"
#define VIEWCONTROLLER_TIMER_USERINFO_COMPLETION_KEY    @"timer.completion.key"

@interface ViewControllerAlertView ()

@end


@implementation ViewControllerAlertView
{
    
    UIViewController *currentAlertHolder;
    
    //
    //  This jumpPoint point is the point
    //  which is used in case of jump in animation.
    //
    //  In future it may be used in further animation
    //
    CGPoint jumpPoint;
    BOOL    useCustomJumpPoint;
    
    
    //
    //
    //
    //
    //enum PREDEFINED_ANIMATION anim;
    
}

#pragma mark life-cycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark public method
+(ViewControllerAlertView*)makeAnAlert:(NSString*)storyboardName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName
                                                         bundle:[NSBundle mainBundle]];
    
    return (ViewControllerAlertView*)[storyboard instantiateInitialViewController];
}

-(void)setJumpInOutAnimationPoint:(CGPoint)jp shouldUseCustomJumpPoint:(BOOL)useJP
{
    jumpPoint = jp;
    useCustomJumpPoint = useJP;
}

-(void)showOn:(UIViewController*)alertHolder WithAnimation:(enum PREDEFINED_ANIMATION)anim
{
    //call delegate that this view controller is about to show
    if(self.vcavDelegate &&
       [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewWillAppear:))])
    {
        [self.vcavDelegate viewControllerAlertViewWillAppear:self];
    }
    
    
    currentAlertHolder = alertHolder;
    
    [alertHolder addChildViewController:self];
    [self didMoveToParentViewController:alertHolder];
    
    if([alertHolder isKindOfClass:[UINavigationController class]])
    {
        [super viewWillAppear:YES];
    }
        
    switch(anim)
    {
        case SHOW_WITH_DAMPING:
        {
            [self showOnWithDamping:alertHolder];
        }
            break;
        case SHOW_WITH_FADE_IN:
        {
            [self showOnWithFadeIn:alertHolder];
        }
            break;
        case SHOW_WITH_JUMP_IN:
        {
            [self showOnWithJumpIn:alertHolder];
        }
            break;
            
        case HIDE_WITH_DAMPING:
        case HIDE_WITH_FADE_OUT:
        default:
        {
            NSLog(@"WRONG ANIMATION PARAMTER PASSED");
        }
    }
    
}

-(void)hideWithAnimation:(enum PREDEFINED_ANIMATION)anim
              onComplete:(ViewControllerAlertViewCompletionBlok)completion
{
    switch(anim)
    {
        case HIDE_WITH_DAMPING:
        {
            [self hideWithDamping:completion];
        }
            break;
        case HIDE_WITH_FADE_OUT:
        {
            [self hideWithFadeOut:completion];
        }
            break;
        case HIDE_WITH_JUMP_OUT:
        {
            [self hideWithJumpOut:completion];
        }
            break;
            
        case SHOW_WITH_DAMPING:
        case SHOW_WITH_FADE_IN:
        default:
        {
            NSLog(@"WRONG ANIMATION PARAMTER PASSED");
        }
    }
}

-(void)hideAutomaticallyAfter:(NSTimeInterval)hidingTime
                withAnimation:(enum PREDEFINED_ANIMATION)anim
                   onComplete:(ViewControllerAlertViewCompletionBlok)completion
{
    //
    //  incase of no completion block passed or nil passed, dummy completion block is meant to be passed
    //
    ViewControllerAlertViewCompletionBlok dummyBlock=^{
    };
    
    [NSTimer scheduledTimerWithTimeInterval:hidingTime
                                     target:self
                                   selector:@selector(hidingTimerExpired:)
                                   userInfo:@{
                                              
                                              
                                              VIEWCONTROLLER_TIMER_USERINFO_ANIMATION_KEY: [NSNumber numberWithInt:anim],
                                              VIEWCONTROLLER_TIMER_USERINFO_COMPLETION_KEY : ((completion != nil) ? completion : dummyBlock)
                                              }
                                    repeats:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark private factory default animator function

#pragma mark show methods
-(void)showOnWithDamping:(UIViewController*)alertHolder
{
    //initially disable the both view controller
    alertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = NO;
    
    //set initial frame
    CGRect originalFrame = alertHolder.view.frame;
    CGRect initialFrame = CGRectMake(originalFrame.origin.x,
                                     originalFrame.origin.y,
                                     originalFrame.size.width,
                                     originalFrame.size.height);
    initialFrame.origin.y = alertHolder.view.bounds.size.height;
    
    self.view.frame = initialFrame;
    self.view.backgroundColor = [UIColor clearColor];
    [alertHolder.view addSubview:self.view];
    
    [UIView animateWithDuration:1.0
                          delay:0.1
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.1
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         
                         self.view.frame = originalFrame;
                         
                     } completion:^(BOOL finshed){
                         //call delegate that this view controller is shown
                         
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.view.backgroundColor = [UIColor colorWithRed:50.0/255.0
                                                                                          green:50.0/255.0
                                                                                           blue:50.0/255.0
                                                                                          alpha:0.85];
                                          }];
                         
                         
                         
                         if(self.vcavDelegate &&
                            [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewDidAppear:))]
                            )
                         {
                             [self.vcavDelegate viewControllerAlertViewDidAppear:self];
                         }
                         
                         //now enable the both view controller
                         alertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = YES;
                     }];
}

-(void)showOnWithFadeIn:(UIViewController*)alertHolder
{
    //initially disable the both view controller
    alertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = NO;
    
    //set initial frame
    CGRect originalFrame = alertHolder.view.frame;
    
    self.view.frame = originalFrame;
    self.view.backgroundColor = [UIColor colorWithRed:50.0/255.0
                                                green:50.0/255.0
                                                 blue:50.0/255.0
                                                alpha:0.85];
    self.view.alpha = 0.0;
    [alertHolder.view addSubview:self.view];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         
                         self.view.alpha = 1.0;
                         
                     } completion:^(BOOL finshed){
                         //call delegate that this view controller is shown
                         
                         if(self.vcavDelegate &&
                            [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewDidAppear:))]
                            )
                         {
                             [self.vcavDelegate viewControllerAlertViewDidAppear:self];
                             
                         }
                         
                         //now enable the both view controller
                         alertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = YES;
                     }];
}

-(void)showOnWithJumpIn:(UIViewController*)alertHolder
{
    //initially disable the both view controller
    alertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = NO;
    
    //set initial frame
    CGRect originalFrame = alertHolder.view.frame;
    CGRect initialFrame = CGRectMake(originalFrame.origin.x,
                                     originalFrame.origin.y,
                                     originalFrame.size.width,
                                     originalFrame.size.height);
    
    
    self.view.frame = initialFrame;
    self.view.clipsToBounds = YES;
    
    //
    //  coming from arbitrary location
    //
    if(useCustomJumpPoint)
    {
        self.view.center = jumpPoint;
    }
    
    
    [alertHolder.view addSubview:self.view];
    
    CALayer *viewLayer = self.view.layer;
    viewLayer.transform = CATransform3DMakeScale(0, 0, 0);  //from the back coming like a projectile
    //layer.transform = CATransform3DMakeScale(1, 0, 1);  //opening like old television  (horizontally)
    //layer.transform = CATransform3DMakeScale(0, 1, 1);  //opening like twisted curtain (vertically)
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         
                         //layer.transform = translationTransform;
                         viewLayer.transform = CATransform3DIdentity;
                         self.view.center = CGPointMake(CGRectGetMidX(originalFrame),
                                                        CGRectGetMidY(originalFrame));
                         
                     } completion:^(BOOL finshed){
                         //call delegate that this view controller is shown
                         
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.view.backgroundColor = [UIColor colorWithRed:50.0/255.0
                                                                                          green:50.0/255.0
                                                                                           blue:50.0/255.0
                                                                                          alpha:0.85];
                                          }];
                         
                         
                         
                         if(self.vcavDelegate &&
                            [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewDidAppear:))]
                            )
                         {
                             [self.vcavDelegate viewControllerAlertViewDidAppear:self];
                             
                         }
                         
                         //now enable the both view controller
                         alertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = YES;
                     }];
}

#pragma mark hide methods
-(void)hideWithDamping:(void(^)(void))completion
{
    //initially disable the both view controller
    currentAlertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = NO;
    
    if(currentAlertHolder)
    {
        //call delegate that this view controller is about to hide
        if(self.vcavDelegate &&
           [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewWillDisappear:))]
           )
        {
            [self.vcavDelegate viewControllerAlertViewWillDisappear:self];
        }
        
        CGRect animatedFrame = self.view.frame;
        animatedFrame.origin.y = currentAlertHolder.view.frame.size.height;
        
        self.view.backgroundColor = [UIColor clearColor];
        
        [UIView animateWithDuration:1.0
                              delay:0.1
             usingSpringWithDamping:0.4
              initialSpringVelocity:0.1
                            options:UIViewAnimationCurveLinear
                         animations:^{
            
            self.view.frame = animatedFrame;
            
        } completion:^(BOOL finished) {
            //if(finished)
            {
                [self removeFromParentViewController];
                [self.view removeFromSuperview];
                [self willMoveToParentViewController:nil];
                
                //call delegate that this view controller is shown
                if(self.vcavDelegate &&
                   [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewDiddisappear:))]
                   )
                {
                    [self.vcavDelegate viewControllerAlertViewDiddisappear:self];
                }
                
                //  if there is something to do in completion
                //  then execute it, otherwise just ignore
                if(completion)
                {
                    completion();
                }
                
                //now enable the both view controller
                currentAlertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = YES;
            }
        }];
    }
}

-(void)hideWithFadeOut:(void(^)(void))completion
{
    //initially disable the both view controller
    currentAlertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = NO;
    
    if(currentAlertHolder)
    {
        //call delegate that this view controller is about to hide
        if(self.vcavDelegate &&
           [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewWillDisappear:))]
           )
        {
            [self.vcavDelegate viewControllerAlertViewWillDisappear:self];
        }
        
        [UIView animateWithDuration:1.0
                         animations:^{
            
                             self.view.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            //if(finished)
            {
                [self removeFromParentViewController];
                [self.view removeFromSuperview];
                [self willMoveToParentViewController:nil];
                
                //call delegate that this view controller is shown
                if(self.vcavDelegate &&
                   [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewDiddisappear:))]
                   )
                {
                    [self.vcavDelegate viewControllerAlertViewDiddisappear:self];
                }
                
                //  if there is something to do in completion
                //  then execute it, otherwise just ignore
                if(completion)
                {
                    completion();
                }
                
                //now enable the both view controller
                currentAlertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = YES;
            }
        }];
    }
}


-(void)hideWithJumpOut:(void(^)(void))completion
{
    //initially disable the both view controller
    currentAlertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = NO;
    
    if(currentAlertHolder)
    {
        //call delegate that this view controller is about to hide
        if(self.vcavDelegate &&
           [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewWillDisappear:))]
           )
        {
            [self.vcavDelegate viewControllerAlertViewWillDisappear:self];
        }
        
        CALayer *rootLayer = self.view.layer;
        rootLayer.transform = CATransform3DIdentity;
        
        [UIView animateWithDuration:1.0
                         animations:^{
                             
                             if(useCustomJumpPoint)
                             {
                                 self.view.center = jumpPoint;
                             }
                             
                             
                             //
                             // there is a bug in ios
                             //
                             rootLayer.transform = CATransform3DMakeScale(0.00001, 0.00001, 0.00001);
                             
                         } completion:^(BOOL finished) {
                             //if(finished)
                             {
                                 [self removeFromParentViewController];
                                 [self.view removeFromSuperview];
                                 [self willMoveToParentViewController:nil];
                                 
                                 //call delegate that this view controller is shown
                                 if(self.vcavDelegate &&
                                    [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewDiddisappear:))]
                                    )
                                 {
                                     [self.vcavDelegate viewControllerAlertViewDiddisappear:self];
                                 }
                                 
                                 //  if there is something to do in completion
                                 //  then execute it, otherwise just ignore
                                 if(completion)
                                 {
                                     completion();
                                 }
                                 
                                 //now enable the both view controller
                                 currentAlertHolder.view.userInteractionEnabled = self.view.userInteractionEnabled = YES;
                             }
                         }];
    }
}

#pragma mark Timer helper
-(void)hidingTimerExpired:(NSTimer*)timer
{
    if(timer &&
       timer.userInfo)
    {
        
        enum PREDEFINED_ANIMATION anim = (enum PREDEFINED_ANIMATION)[timer.userInfo[VIEWCONTROLLER_TIMER_USERINFO_ANIMATION_KEY] intValue];
        ViewControllerAlertViewCompletionBlok completionBlock = timer.userInfo[VIEWCONTROLLER_TIMER_USERINFO_COMPLETION_KEY];
        
        //  now time to hide
        [self hideWithAnimation:anim onComplete:completionBlock];
    
        //  get rid of the timer
        [timer invalidate];
        timer = nil;
    }
}

@end
