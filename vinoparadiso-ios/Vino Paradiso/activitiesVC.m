//
//  activitiesViewController.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 06/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "activitiesVC.h"
#import "utilViewController.h"
#import "menuVC.h"
#import "activitiesCell.h"
#import "DataTestVC.h"
#import "CustomSegue.h"
#import <Social/Social.h>//Framework Facebook,Twitter


@interface activitiesVC ()

@end

@implementation activitiesVC
@synthesize listActivities,tableView_activity,lbl_title_Activity,lblSydney,selectedRow;
////////////////////////////SINGLETON//////////////////////////////////

+(activitiesVC *) getInstance{ // Singleton
    static  activitiesVC *inst = nil;
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
    DataTestVC * dataTest = [DataTestVC getInstance];
    listActivities = [[[dataTest listLoadData ] objectAtIndex:4]valueForKey:@"Schedule"];
    UIFont *font_title_sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    [lblSydney setFont:font_title_sydney];
   
    /////Font and Style//////
        UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    
        [lbl_title_Activity setFont:subTitle];
        //tableView_activity.backgroundColor = [UIColor clearColor];
        tableView_activity.opaque = NO;
        tableView_activity.backgroundView = nil;
    /////Font and Style//////
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////////////////////////////////TableView////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return listActivities.count;
    
}
-(IBAction)shareEvent:(id)sender{
UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Sharing option:"
                                                   delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                        @"Share on Facebook",
                        @"Share on Twitter",
                        
                        nil];
popup.tag = 1;
[popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self postToFacebook];
                    break;
                case 1:
                    [self postToTwitter];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath        *)indexPath
{
    static NSString *simpleTableIdentifier = @"cellActivities";
    
    activitiesCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.description_activity.text=[[listActivities objectAtIndex:indexPath.row]valueForKey:@"Activity Description"];
    cell.title_activity.text=[[listActivities objectAtIndex:indexPath.row]valueForKey:@"Activity Title"];
    cell.date_activity.text=[[listActivities objectAtIndex:indexPath.row]valueForKey:@"Date DD/MMM"];
    cell.hour_activity.text=[[listActivities objectAtIndex:indexPath.row]valueForKey:@"Time 24:00"];
    
    /////Font and Style//////
    UIFont *font = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    UIFont *font2 = [UIFont fontWithName:@"Lato-Light" size:12];
    [cell.description_activity setFont:font2];
    [cell.title_activity setFont:font];
    [cell.date_activity setFont:font];
    [cell.hour_activity setFont:font];

    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    cell.opaque = NO;
    cell.backgroundView = nil;
    //cell.layer.borderWidth=1.0f;
    //cell.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    /////Font and Style//////
    

    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = (int)indexPath.row; //Save the index row
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Add to Calendar"
                                                   message: @"Would you like to add this activity to your Calendar?"
                                                  delegate: self
                                         cancelButtonTitle:@"NO"
                                         otherButtonTitles:@"YES",nil];
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
       [self createEventInCalendar];
    }
}



-(void)createEventInCalendar{
    //Format @"dd MMM/yyyy HH:mm"
    
    
    utilViewController * utilVC = [utilViewController getInstance];
    NSString * dateActivity = [listActivities objectAtIndex:selectedRow];
    NSString * dateWithHour =[NSString stringWithFormat:@"%@/%@ %@", [dateActivity valueForKey:@"Date DD/MMM"],@"2014",[dateActivity valueForKey:@"Time 24:00"]];
    
    [utilVC createEventInCalendar:dateWithHour
    eventEnd:dateWithHour
    eventTitle:[dateActivity valueForKey:@"Activity Title"]
    eventDetails:[dateActivity valueForKey:@"Activity Description"]
    dateFormat:@"dd MMM/yyyy HH:mm"];
    [self showMessageReminderOk];
    
}

-(void) showMessageReminderOk {
    NSString * message ;
    message= @"Reminder added successfully";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message:" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
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


//////////SHARE WITH SOCIAL NETWORKS /////
- (void)postToTwitter{
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"#VinoParadiso International Wine & Food Festival, OCTOBER 31 - NOVEMBER 2 2014. AUSTRALIAN TECHNOLOGY PARK"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}
- (void)postToFacebook{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"#VinoParadiso International Wine & Food Festival, OCTOBER 31 - NOVEMBER 2 2014. AUSTRALIAN TECHNOLOGY PARK"];
        [controller addURL:[NSURL URLWithString:@""]];
        [controller addImage:[UIImage imageNamed:@""]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
}
//////////SHARE WITH SOCIAL NETWORKS /////

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
