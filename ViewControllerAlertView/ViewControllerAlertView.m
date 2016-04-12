//
//  ViewControllerAlertView.m
//  Ajura
//
//  Created by Ratul Sharker on 1/28/16.
//  Copyright © 2016 REVE Systems. All rights reserved.
//

#import "ViewControllerAlertView.h"



@interface ViewControllerAlertView ()

@end


@implementation ViewControllerAlertView
{
    UIViewController *currentAlertHolder;
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

-(void)showOn:(UIViewController*)alertHolder
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
        
    
    //[self showOnWithDamping:alertHolder];
    
    [self showOnWithFadeIn:alertHolder];
    
}

-(void)hide
{
    [self hide:nil];
}

-(void)hide:(void (^)(void)) completion
{
    //[self hideWithDampingWithCompletion:completion];
    
    [self hideWithFadeOut:completion];
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
-(void)showOnWithDamping:(UIViewController*)alertHolder
{
    //set initial frame
    CGRect originalFrame = self.view.frame;
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
                     }];
}

-(void)hideWithDampingWithCompletion:(void(^)(void))completion
{
    
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
        
        [UIView animateWithDuration:1.0 delay:0.1 usingSpringWithDamping:0.4 initialSpringVelocity:0.1 options:UIViewAnimationCurveLinear animations:^{
            
            self.view.frame = animatedFrame;
            
        } completion:^(BOOL finished) {
            if(finished)
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
                
            }
        }];
    }
}

-(void)showOnWithFadeIn:(UIViewController*)alertHolder
{
    //set initial frame
    CGRect originalFrame = self.view.frame;
    
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
                     }];
}

-(void)hideWithFadeOut:(void(^)(void))completion
{
    
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
            if(finished)
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
            }
        }];
    }
}

-(void)showOnWithProgressiveCircularOut:(UIViewController*)alertHolder
{
    //set initial frame
    CGRect originalFrame = self.view.frame;
    
    self.view.frame = originalFrame;
    self.view.backgroundColor = [UIColor colorWithRed:50.0/255.0
                                                green:50.0/255.0
                                                 blue:50.0/255.0
                                                alpha:0.85];
    self.view.alpha = 1.0;
    self.view.clipsToBounds = YES;
    self.view.layer.cornerRadius = 0.0;
    [alertHolder.view addSubview:self.view];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         
                         self.view.layer.cornerRadius = MAX(self.view.frame.size.width, self.view.frame.size.height);
                         
                     } completion:^(BOOL finshed){
                         //call delegate that this view controller is shown
                         
                         if(self.vcavDelegate &&
                            [self.vcavDelegate respondsToSelector:(@selector(viewControllerAlertViewDidAppear:))]
                            )
                         {
                             [self.vcavDelegate viewControllerAlertViewDidAppear:self];
                             
                         }
                     }];
}

@end
