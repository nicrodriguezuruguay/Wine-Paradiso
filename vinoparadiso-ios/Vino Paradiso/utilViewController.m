//
//  utilViewController.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 06/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "utilViewController.h"
#import <EventKitUI/EventKitUI.h>
#import "MBProgressHUD.h"
#import "searchVC.h"

@interface utilViewController ()

@end

@implementation utilViewController
////////////////////////////SINGLETON//////////////////////////////////

+(utilViewController *) getInstance{ // Singleton utilViewController
    static  utilViewController *inst = nil;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) showMessageReminderOk:(NSString*) message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message:" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

-(void)createEventInCalendar:(NSString*)eventStart eventEnd:(NSString*) eventEnd eventTitle:(NSString*)eventTitle eventDetails:(NSString*)eventDetails dateFormat:(NSString*) dateFormat  {
    
    NSDateFormatter *mmddccyy = [[NSDateFormatter alloc] init];
    mmddccyy.timeStyle = NSDateFormatterNoStyle;
    mmddccyy.dateFormat = dateFormat;
    NSDate *dateEvent = [mmddccyy dateFromString:eventStart];
    NSDate *endDate = [mmddccyy dateFromString:eventEnd];
    
    EKEventStore *eventStore=[[EKEventStore alloc] init];
    
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
     {
         
         /////Add reminder///////////
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
         dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
             if (granted)
             {
                 EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                 NSString * NoteDetails =eventDetails;
                 //Create the end date components
                 NSDateComponents *tomorrowDateComponents = [[NSDateComponents alloc] init];
                 tomorrowDateComponents.day = 1;
                 event.title =eventTitle;
                 event.startDate=dateEvent;
                 event.endDate=endDate;
                 event.notes = NoteDetails;
                 event.allDay=YES;
                 
                 [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                 NSError *err;
                 [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
             }
             else
             {
                 NSLog(@"NoPermission to access the calendar");
             }
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         });
         
         /////Add reminder///////////
     }];
    
}


@end
