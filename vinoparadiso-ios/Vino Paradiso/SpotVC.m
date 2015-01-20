//
//  SpotViewController.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 03/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "SpotVC.h"
#import "menuVC.h"
#import <EventKitUI/EventKitUI.h>
#import "MBProgressHUD.h"
#import "utilViewController.h"

@interface SpotVC ()

@end

@implementation SpotVC
@synthesize maps,lblSydney;
////////////////////////////SINGLETON//////////////////////////////////

+(SpotVC *) getInstance{ // Singleton activitiesViewController
    static  SpotVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
        }
    }
    return inst;
}
//////////////////////////////////////////////////////////////////////
-(IBAction)createEventInCalendar:(id)sender{
    utilViewController * utilVC = [utilViewController getInstance];

    [utilVC createEventInCalendar:@"10/31/2014" eventEnd:@"11/02/2014" eventTitle:@"Vino Paradiso" eventDetails:@"International wine & food festival" dateFormat:@"MM/dd/yyyy"] ;
    [self showMessageReminderOk];
    
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
-(void) showMessageReminderOk {
    NSString * message ;
    message= @"Reminder added successfully";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message:" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}


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
    /////Font//////
    UIFont *font = [UIFont fontWithName:@"Lato-Light" size:12];
    UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    UIFont *font_title_sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    [lblSydney setFont:font_title_sydney];
    [lblInfo setFont:font];
    [lblLocation setFont:subTitle];
    /////Font//////

    //Insert the map with the annotation of the event.
    [super viewDidLoad];
    CLLocationCoordinate2D  latiLong;
    CLLocationCoordinate2D initialLocation;
    initialLocation.latitude = -33.8954634;
    initialLocation.longitude= 151.1948337;
    
    latiLong.latitude = -33.8954634;
    latiLong.longitude = 151.1948337;

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = latiLong;
    annotation.title = @"Australian Technology Park";
    annotation.subtitle=@"event management";
    
    [self.maps addAnnotation:annotation];
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(initialLocation, 2000, 2000);
    [self.maps setRegion:region animated:YES];
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
