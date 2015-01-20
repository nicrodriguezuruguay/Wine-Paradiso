//
//  exhibitorsViewController.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 15/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "exhibitorsVC.h"
#import "wine.h"
#import "CustomIOS7AlertView.h"//modalCustom add note
#import "FavouritesVC.h"
#import "DataTestVC.h"
#import "exhibitorsCell.h"
#import "Flurry.h"


@interface exhibitorsVC ()

@end

@implementation exhibitorsVC
////////////////////////////SINGLETON//////////////////////////////////

+(exhibitorsVC *) getInstance{ // Singleton activitiesViewController
    static  exhibitorsVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
            [inst loadDataOfExhibitors];
        }
    }
    return inst;
}
//////////////////////////////////////////////////////////////////////
@synthesize listExhibitors,selectedRow,lbl_title_exhibitor,lbl_Sydney;

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
   
    
    ////////FONT //////
    UIFont *font_title_Sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];

    UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    [lbl_Sydney setFont:font_title_Sydney];
    [lbl_title_exhibitor setFont:subTitle];
    
    
    ////////FONT //////
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadDataOfExhibitors {
    DataTestVC * dataTest = [DataTestVC getInstance];
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    NSMutableDictionary * wineList = [[NSMutableDictionary alloc]init];
    
    exhibVC.listExhibitors = [[[dataTest listLoadData ] objectAtIndex:1]valueForKey:@"Exhibitor"];
    wineList = [[[dataTest listLoadData ] objectAtIndex:0]valueForKey:@"Wines"];

    for (id key in exhibVC.listExhibitors) {
        NSMutableArray * listWineInExhibitor = [[NSMutableArray alloc]init];
        NSString * nameExhibitor = [key valueForKeyPath:@"Exhibitor Name" ];
        for (id key2 in wineList) {
            NSString * nameWine = [key2 valueForKeyPath:@"Exhibitor" ];
            if ([nameWine isEqualToString:nameExhibitor]) {
                
                [listWineInExhibitor addObject:key2];
            }
        }
        [key setValue:listWineInExhibitor forKeyPath:@"wineList"];
    }
    ///Result //
    //Exhibitor
    /////WineList
    /////////////Wine .... n
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];

    return exhibVC.listExhibitors.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *cellSpeakers = @"cellExhibitors";//cellSpeakers_profile
    //static NSString *cellSpeakers_profile = @"cellSpeakers_profile";
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    exhibitorsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSpeakers];
    
    
    
    cell.lbl_wine_name.text=[[exhibVC.listExhibitors objectAtIndex:indexPath.row]valueForKey:@"Exhibitor Name"];
    
    cell.lbl_wine_description.text=[[exhibVC.listExhibitors objectAtIndex:indexPath.row]valueForKey:@"Exhibitor blurb"];
    [cell.lbl_wine_photo setImage:[UIImage imageNamed:[[exhibVC.listExhibitors objectAtIndex:indexPath.row]valueForKey:@"photo"]]];
    [cell.button_wine_addFavourites setTag:indexPath.row];
    
    /////Font and Style//////
    UIFont *font = [UIFont fontWithName:@"Lato-BoldItalic" size:14];
    UIFont *font_button_share_favourites = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    UIFont *font2 = [UIFont fontWithName:@"Lato-Light" size:12];
    [cell.lbl_wine_description setFont:font2];
    [cell.lbl_wine_name setFont:font];
    [cell.lbl_button_wine_favourites setFont:font_button_share_favourites];
   // [cell.lbl_Button_share setFont:font_button_share_favourites];
    
    
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    cell.opaque = NO;
    cell.backgroundView = nil;
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    //// make the image with the circle format (ios 7 compatible)/////
    cell.lbl_wine_photo.layer.cornerRadius = cell.lbl_wine_photo.frame.size.height /2;
    cell.lbl_wine_photo.layer.masksToBounds = YES;
    cell.lbl_wine_photo.layer.borderWidth = 0;
    //// make the image with the circle format (ios 7 compatible)/////
    
    /////Font and Style//////
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    exhibVC.selectedRow = (int) indexPath.row;
    
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitorsProfile"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];
    
    
}


- (IBAction)button_addFavourites_speaker:(id)sender {
    
    FavouritesVC * favourites = [FavouritesVC getInstance];
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    NSMutableDictionary * favoriteDicc = [[NSMutableDictionary alloc]init];
    
    //////// OBJECT FAVOURITE //////////
    //////// Flurry //////////
    NSString * name = [[exhibVC.listExhibitors objectAtIndex:[sender tag]]valueForKey:@"Exhibitor Name"];
    NSString * nameFavourite = [NSString stringWithFormat:@"%@%@%@",@"User selected ",name,@" as favourite"];
    [Flurry logEvent:nameFavourite];
    //////// Flurry //////////
    
    [favoriteDicc setValue:name forKey:@"name"];
    [favoriteDicc setValue:@"Exhibitor" forKey:@"class"];
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
