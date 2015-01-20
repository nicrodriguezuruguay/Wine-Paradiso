//
//  SponsorsVC.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 1/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "SponsorsVC.h"
#import "SponsorsCell.h"
#import "DataTestVC.h"
#import "FavouritesVC.h"
#import "Flurry.h"

@interface SponsorsVC ()

@end

@implementation SponsorsVC

////////////////////////////SINGLETON//////////////////////////////////

+(SponsorsVC *) getInstance{ // Singleton activitiesViewController
    static  SponsorsVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
            [inst loadDataOfSponsors];
        }
    }
    return inst;
}
//////////////////////////////////////////////////////////////////////

@synthesize lblSydney,lbl_title_Sponsor;

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
    UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    
    [lbl_title_Sponsor setFont:subTitle];
    [lblSydney setFont:font_title_Sydney];
    /////Font//////

    
}
-(void) loadDataOfSponsors {
    SponsorsVC * sponsorVC = [SponsorsVC getInstance];
    DataTestVC * dataTest = [DataTestVC getInstance];
    sponsorVC.listSponsors = [[[dataTest listLoadData ] objectAtIndex:2]valueForKey:@"Sponsor"];
    
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
    SponsorsVC * sponsorVC = [SponsorsVC getInstance];
    
    return sponsorVC.listSponsors.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    SponsorsVC * sponsorVC = [SponsorsVC getInstance];
    static NSString *cellSponsors = @"cellSponsors";
    
    SponsorsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSponsors];
    
    
    
    cell.lbl_description_sponsor.text=[[sponsorVC.listSponsors objectAtIndex:indexPath.row]valueForKey:@"Sponsor blurb"];
    
    cell.lbl_name_sponsor.text=[[sponsorVC.listSponsors objectAtIndex:indexPath.row]valueForKey:@"Sponsor Name"];
    [cell.image_photo_sponsor setImage:[UIImage imageNamed:[[sponsorVC.listSponsors objectAtIndex:indexPath.row]valueForKey:@"photo"]]];
    [cell.button_addFavourites_sponsor setTag:indexPath.row];
    
    /////Font and Style//////
    UIFont *font = [UIFont fontWithName:@"Lato-BoldItalic" size:14];
    UIFont *font_button_share_favourites = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    UIFont *font2 = [UIFont fontWithName:@"Lato-Light" size:12];
    [cell.lbl_description_sponsor setFont:font2];
    [cell.lbl_name_sponsor setFont:font];
    [cell.lbl_Button_Favourites setFont:font_button_share_favourites];
    [cell.lbl_Button_share setFont:font_button_share_favourites];
    [cell.button_shareFavourites_speaker setTag:indexPath.row];
    
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    cell.opaque = NO;
    cell.backgroundView = nil;
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    //// make the image with the circle format (ios 7 compatible)/////
    cell.image_photo_sponsor.layer.cornerRadius = cell.image_photo_sponsor.frame.size.height /2;
    cell.image_photo_sponsor.layer.masksToBounds = YES;
    cell.image_photo_sponsor.layer.borderWidth = 0;
    //// make the image with the circle format (ios 7 compatible)/////
    
    /////Font and Style//////
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SponsorsVC * sponsorVC = [SponsorsVC getInstance];
    sponsorVC.selectedRow = (int) indexPath.row;
    
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SponsorsProfile"];
    
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
    SponsorsVC * sponsorsVC = [SponsorsVC getInstance];
    
    NSMutableDictionary * favoriteDicc = [[NSMutableDictionary alloc]init];

    
    //////// OBJECT FAVOURITE //////////
    //////// Flurry //////////
    NSString * name = [[sponsorsVC.listSponsors objectAtIndex:[sender tag]]valueForKey:@"Sponsor Name"];
    NSString * nameFavourite = [NSString stringWithFormat:@"%@%@%@",@"User selected ",name,@" as favourite"];
    [Flurry logEvent:nameFavourite];
    //////// Flurry //////////
    
    [favoriteDicc setValue:name forKey:@"name"];
    [favoriteDicc setValue:@"Sponsor" forKey:@"class"];
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
