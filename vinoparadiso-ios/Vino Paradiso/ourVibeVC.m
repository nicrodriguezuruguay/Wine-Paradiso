//
//  ourVibeViewController.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 12/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ourVibeVC.h"
#import "menuVC.h"

@interface ourVibeVC ()

@end

@implementation ourVibeVC
////////////////////////////SINGLETON//////////////////////////////////

+(ourVibeVC *) getInstance{ // Singleton activitiesViewController
    static  ourVibeVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
        }
    }
    return inst;
}
//////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
@synthesize lbl_A_FloorPlan,
            lbl_B_FloorPlan,
            lbl_C_FloorPlan,
            lbl_D_FloorPlan,
            lbl_E_FloorPlan,
            lbl_F_FloorPlan,
            lbl_title_FloorPlan,
            lblSydney;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /////Font//////
    UIFont *font = [UIFont fontWithName:@"Lato-Light" size:12];
    UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    UIFont *font_title_sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    [lblSydney setFont:font_title_sydney];
    [lbl_title_FloorPlan setFont:subTitle];
    [lbl_A_FloorPlan setFont:font];
    [lbl_B_FloorPlan setFont:font];
    [lbl_C_FloorPlan setFont:font];
    [lbl_D_FloorPlan setFont:font];
    [lbl_E_FloorPlan setFont:font];
    [lbl_F_FloorPlan setFont:font];
    [lblInfo setFont:font];
    [lblOurVibe setFont:subTitle];
    /////Font//////

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackMenu:(id)sender{
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:transition forKey:nil];
        
        [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)search:(id)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];
}



@end
