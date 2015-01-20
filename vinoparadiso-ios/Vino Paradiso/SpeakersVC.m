//
//  SpeakersVC.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 24/07/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "SpeakersVC.h"
#import "DataTestVC.h"
#import "SpeakersCell.h"
#import "CustomSegue.h"
#import "FavouritesVC.h"
#import "FlurryAdDelegate.h"
#import "FlurryAds.h"
#import "Flurry.h"

@interface SpeakersVC ()

@end
@implementation SpeakersVC

////////////////////////////SINGLETON//////////////////////////////////

+(SpeakersVC *) getInstance{ // Singleton activitiesViewController
    static  SpeakersVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
            [inst loadDataOfSpeakers];
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
@synthesize listSpeakers,lblSydney,lbl_title_Speakers,selectedRow;;

- (void)viewDidLoad
{
    [super viewDidLoad];

    /////Font//////
    UIFont *font_title_Sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
     UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    
    [lbl_title_Speakers setFont:subTitle];
    [lblSydney setFont:font_title_Sydney];
    /////Font//////
}
-(void)loadDataOfSpeakers {
    SpeakersVC * speakVC = [SpeakersVC getInstance];
    DataTestVC * dataTest = [DataTestVC getInstance];
    speakVC.listSpeakers = [[[dataTest listLoadData ] objectAtIndex:3]valueForKey:@"Speaker"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    SpeakersVC * speakVC = [SpeakersVC getInstance];

    return speakVC.listSpeakers.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    SpeakersVC * speakVC = [SpeakersVC getInstance];

    static NSString *cellSpeakers = @"cellSpeakers";//cellSpeakers_profile
    //static NSString *cellSpeakers_profile = @"cellSpeakers_profile";
    
    SpeakersCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSpeakers];
    
    
    
    cell.lbl_description_speaker .text=[[speakVC.listSpeakers objectAtIndex:indexPath.row]valueForKey:@"Speaker bio"];
    
    cell.lbl_name_speaker.text=[[speakVC.listSpeakers objectAtIndex:indexPath.row]valueForKey:@"Speaker full name"];
   [cell.image_photo_speaker setImage:[UIImage imageNamed:[[speakVC.listSpeakers objectAtIndex:indexPath.row]valueForKey:@"photo"]]];
    
    /////Font and Style//////
    UIFont *font = [UIFont fontWithName:@"Lato-BoldItalic" size:14];
    UIFont *font_button_share_favourites = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    UIFont *font2 = [UIFont fontWithName:@"Lato-Light" size:12];
    [cell.lbl_description_speaker setFont:font2];
    [cell.lbl_name_speaker setFont:font];
    [cell.lbl_Button_Favourites setFont:font_button_share_favourites];
    [cell.lbl_Button_share setFont:font_button_share_favourites];
    [cell.button_shareFavourites_speaker setTag:indexPath.row];
    
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    cell.opaque = NO;
    cell.backgroundView = nil;
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    //// make the image with the circle format (ios 7 compatible)/////
    cell.image_photo_speaker.layer.cornerRadius = cell.image_photo_speaker.frame.size.height /2;
    cell.image_photo_speaker.layer.masksToBounds = YES;
    cell.image_photo_speaker.layer.borderWidth = 0;
    //// make the image with the circle format (ios 7 compatible)/////
    
    /////Font and Style//////
    
    return cell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpeakersVC * speakVC = [SpeakersVC getInstance];
    speakVC.selectedRow = (int) indexPath.row;
    //NSString * speakers = [listSpeakers objectAtIndex:selectedRow];
    

    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SpeakersProfile"];
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];

    
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


- (IBAction)button_addFavourites_speaker:(id)sender {
    FavouritesVC * favourites = [FavouritesVC getInstance];
    SpeakersVC * speakVC = [SpeakersVC getInstance];
   
    NSMutableDictionary * favoriteDicc = [[NSMutableDictionary alloc]init];
    
    //////// OBJECT FAVOURITE //////////
     //////// Flurry //////////
    NSString * name = [[speakVC.listSpeakers objectAtIndex:[sender tag]] valueForKey:@"Speaker full name"];
    NSString * nameFavourite = [NSString stringWithFormat:@"%@%@%@",@"User selected ",name,@" as favourite"];
    [Flurry logEvent:nameFavourite];
    //////// Flurry //////////
   
    [favoriteDicc setValue:name forKey:@"name"];
    [favoriteDicc setValue:@"Speakers" forKey:@"class"];
    [favoriteDicc setValue:[NSString stringWithFormat:@"%d",[sender tag]] forKey:@"indexObject"];
    
    [favourites.listFavourites addObject:favoriteDicc];
    //////// OBJECT FAVOURITE //////////
    [self alertAddFavourites];
}

-(void) alertAddFavourites {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Favourites"
                                                   message: @"Added successfully"
                                                  delegate: self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
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
