//
//  TicketVC.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 29/7/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "TicketVC.h"

@interface TicketVC ()

@end

@implementation TicketVC
@synthesize lbl_Sydney,lbl_title_favourites;
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
    ///////Font /////
    UIFont *font_title_Sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
      UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    [lbl_Sydney setFont:font_title_Sydney];
    [lbl_title_favourites setFont:subTitle];
    
    ///////Font /////
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
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

- (IBAction)buy_tickets:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.vinoparadiso.com.au/tickets"]];

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
