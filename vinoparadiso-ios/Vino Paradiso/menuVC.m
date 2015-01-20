//
//  menuViewController.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 04/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "menuVC.h"
#import "CustomSegue.h"
#import "DataTestVC.h"
#import "utilViewController.h"

@interface menuVC ()

@end

@implementation menuVC
////////////////////////////SINGLETON//////////////////////////////////

+(menuVC *) getInstance{ // Singleton activitiesViewController
    static  menuVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
        }
    }
    return inst;
}
//////////////////////////////////////////////////////////////////////


@synthesize button_ourVibe,button_location,button_floorPlan,button_activities,
button_favourites,button_exhibitors,button_tickets,button_sponsors,
button_speakers,button_qr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    /////Font//////
    UIFont *font_title_Sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    [lblSydney setFont:font_title_Sydney];
    /////Font//////
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_menu.png"]];
    
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue isKindOfClass:[CustomSegue class]]) {
        // Set the start point for the animation to center of the button for the animation
        ((CustomSegue *)segue).originatingPoint = self.button_ourVibe.center;
        ((CustomSegue *)segue).originatingPoint = self.button_location.center;
        ((CustomSegue *)segue).originatingPoint = self.button_floorPlan.center;
        ((CustomSegue *)segue).originatingPoint = self.button_activities.center;
        ((CustomSegue *)segue).originatingPoint = self.button_favourites.center;
        ((CustomSegue *)segue).originatingPoint = self.button_exhibitors.center;
        ((CustomSegue *)segue).originatingPoint = self.button_tickets.center;
        ((CustomSegue *)segue).originatingPoint = self.button_sponsors.center;
        ((CustomSegue *)segue).originatingPoint = self.button_speakers.center;
        ((CustomSegue *)segue).originatingPoint = self.button_qr.center;

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
