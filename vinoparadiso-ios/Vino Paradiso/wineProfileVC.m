//
//  wineProfileVC.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 15/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "wineProfileVC.h"
#import "exhibitorsVC.h"
#import "DataTestVC.h"
#import <Social/Social.h>//Framework Facebook,Twitter
#import "FavouritesVC.h"
#import "Flurry.h"


@interface wineProfileVC ()

@end

@implementation wineProfileVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
@synthesize lbl_description_wine_profile,image_wine_profile,lbl_name_wine_profile,
lbl_Sydney,lbl_title_wine_profile,lbl_button_wine_profile,wine,photo,alertView,customView,imageViewPhoto,noteTextView,rateSelect,button_rating_1,button_rating_2,button_rating_3,button_rating_4,button_rating_5;
- (void)viewDidLoad
{
    ////// exhibitors Select //////
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    //selectedRow = exhibVC.selectedRow;
    ////// exhibitors Select //////

   
     wine = [[[exhibVC.listExhibitors objectAtIndex:exhibVC.selectedRow]valueForKey:@"wineList"] objectAtIndex:exhibVC.selectedWineRow];
    
    [self showWine:[wine valueForKey:@"Wine Blurb"]
        photo_wine:[wine valueForKey:@"photo"]
         name_wine:[wine valueForKey:@"Wine Name"]];
    
    /////Font//////
    UIFont *font_title_Sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    UIFont *font_text_description = [UIFont fontWithName:@"Lato-Light" size:12];
    UIFont *font_title_MoreSpeakers = [UIFont fontWithName:@"Lato-Light" size:14];
    UIFont *font_title_name = [UIFont fontWithName:@"Lato-Light" size:16];
    UIFont *font_button_addNote = [UIFont fontWithName:@"Lato-Light" size:12];
    UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    /////Font//////
    
    
    /////Style//////
    [lbl_name_wine_profile setFont:font_title_name];
    [lbl_title_wine_profile setFont:subTitle];
    [lbl_Sydney setFont:font_title_Sydney];
    [lbl_description_wine_profile setFont:font_text_description];
    [lbl_button_wine_profile setFont:font_button_addNote];
    
    //// make the image with the circle format (ios 7 compatible)/////
    image_wine_profile.layer.cornerRadius = image_wine_profile.frame.size.height /2;
    image_wine_profile.layer.masksToBounds = YES;
    image_wine_profile.layer.borderWidth = 0;
    //// make the image with the circle format (ios 7 compatible)/////
    /////Style//////
}

-(void) showWine:(NSString*)description_wine photo_wine:(NSString*) photo_wine
       name_wine:(NSString*) name_wine {
    lbl_description_wine_profile.text = description_wine;
    [image_wine_profile setImage:[UIImage imageNamed:photo_wine]];
    lbl_name_wine_profile.text = name_wine;
}


//////////SHARE WITH SOCIAL NETWORKS /////
- (IBAction)postToTwitter:(id)sender{
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@""];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}
- (IBAction)postToFacebook:(id)sender{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@""];
        [controller addURL:[NSURL URLWithString:@""]];
        [controller addImage:[UIImage imageNamed:@""]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
}

- (IBAction)postToInstagram:(id)sender
{
    photo = [[UIImageView alloc]init];
    [photo setImage:[UIImage imageNamed:[wine valueForKey:@"photo"]]];
    UIImage * screenShot = photo.image;
   

    //Remember Image must be larger than 612x612 size if not resize it.
    
    
    NSString* imagePath = [NSString stringWithFormat:@"%@/instagramShare.igo", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    
    UIImage *instagramImage = screenShot ;//[UIImage imageNamed:@"imagename you want to share"];
    [UIImagePNGRepresentation(instagramImage) writeToFile:imagePath atomically:YES];
    NSLog(@"Image Size >>> %@", NSStringFromCGSize(instagramImage.size));
    
    self.dic=[UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:imagePath]];
    self.dic.delegate = self;
    self.dic.UTI = @"com.instagram.exclusivegram";
    [self.dic presentOpenInMenuFromRect: self.view.frame inView:self.view animated:YES ];
}
//////////SHARE WITH SOCIAL NETWORKS /////


- (IBAction)button_addFavourites_wine:(id)sender{
    
    FavouritesVC * favourites = [FavouritesVC getInstance];
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    NSMutableDictionary * favoriteDicc = [[NSMutableDictionary alloc]init];
    
    //////// OBJECT FAVOURITE //////////
    //////// Flurry //////////
    NSString * name = [wine valueForKey:@"Wine Name"];
    NSString * nameFavourite = [NSString stringWithFormat:@"%@%@%@",@"User selected ",name,@" as favourite"];
    [Flurry logEvent:nameFavourite];
    //////// Flurry //////////
    
    [favoriteDicc setValue:name forKey:@"name"];
    [favoriteDicc setValue:@"Wine" forKey:@"class"];
    [favoriteDicc setValue:[NSString stringWithFormat:@"%d",exhibVC.selectedWineRow] forKey:@"indexObjectWine"];
    [favoriteDicc setValue:[NSString stringWithFormat:@"%d",exhibVC.selectedRow] forKey:@"indexObjectExhibitor"];
    
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
///////MODAL ADD NOTE ////
- (IBAction)addNote:(id)sender {
    photo = [[UIImageView alloc]init];
    alertView = [[CustomIOS7AlertView alloc] init];
    customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 220)];
    [customView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_menu.png"]]];
    
    noteTextView =[[UITextView alloc]initWithFrame:CGRectMake(120, 10, 150, 200)];
    imageViewPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    imageViewPhoto.image =[UIImage imageNamed:@"button_add_photo.png"];
    [noteTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
    //////// Image Clicked ///////
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector    (takePhoto:)];
    [imageViewPhoto addGestureRecognizer:singleTap];
    [imageViewPhoto setMultipleTouchEnabled:YES];
    [imageViewPhoto setUserInteractionEnabled:YES];
    
    //////// Image Clicked ///////
    
    [customView addSubview:noteTextView]; // add the noteTextView to the view
    [customView addSubview:imageViewPhoto];
    [alertView setUseMotionEffects:TRUE];
    [alertView setContainerView:customView];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Accept",@"Cancel", nil]];
    [alertView setDelegate:(id)self];
    [alertView show];
    [noteTextView becomeFirstResponder];
    
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        FavouritesVC * favorites = [FavouritesVC getInstance];
        NSMutableDictionary * notes = [[NSMutableDictionary alloc]init];
        [notes setValue:noteTextView.text  forKey:@"description"];
        [notes setValue:photo forKey:@"photo"];
        [favorites.listNotes addObject:notes];
        //[tableView_speakers_profile reloadData];//update the Tableview
        [self alertAddFavourites];
        
        [alertView close];
        
    }
    else{
        [alertView close];
    }
    
}

-(void) alertAddNote {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Note"
                                                   message: @"Added successfully"
                                                  delegate: self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
}

////////Take Photo ////////



- (void)takePhoto:(UIButton *)sender {
    
    alertView.hidden = true;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}


- (IBAction)rating:(id)sender{
    UIImage *enable = [UIImage imageNamed:@"image_rating_enable.png"];
    UIImage *disable = [UIImage imageNamed:@"image_rating_disable.png"];
    
    rateSelect = [sender tag];
    switch (rateSelect) {
        case 1:
            [button_rating_1 setImage:enable forState:UIControlStateNormal];
            [button_rating_2 setImage:disable forState:UIControlStateNormal];
            [button_rating_3 setImage:disable forState:UIControlStateNormal];
            [button_rating_4 setImage:disable forState:UIControlStateNormal];
            [button_rating_5 setImage:disable forState:UIControlStateNormal];
            
            break;
        case 2:
            [button_rating_1 setImage:enable forState:UIControlStateNormal];
            [button_rating_2 setImage:enable forState:UIControlStateNormal];
            [button_rating_3 setImage:disable forState:UIControlStateNormal];
            [button_rating_4 setImage:disable forState:UIControlStateNormal];
            [button_rating_5 setImage:disable forState:UIControlStateNormal];
            break;
        case 3:
            [button_rating_1 setImage:enable forState:UIControlStateNormal];
            [button_rating_2 setImage:enable forState:UIControlStateNormal];
            [button_rating_3 setImage:enable forState:UIControlStateNormal];
            [button_rating_4 setImage:disable forState:UIControlStateNormal];
            [button_rating_5 setImage:disable forState:UIControlStateNormal];
            break;
        case 4:
            [button_rating_1 setImage:enable forState:UIControlStateNormal];
            [button_rating_2 setImage:enable forState:UIControlStateNormal];
            [button_rating_3 setImage:enable forState:UIControlStateNormal];
            [button_rating_4 setImage:enable forState:UIControlStateNormal];
            [button_rating_5 setImage:disable forState:UIControlStateNormal];
            break;
        case 5:
            [button_rating_1 setImage:enable forState:UIControlStateNormal];
            [button_rating_2 setImage:enable forState:UIControlStateNormal];
            [button_rating_3 setImage:enable forState:UIControlStateNormal];
            [button_rating_4 setImage:enable forState:UIControlStateNormal];
            [button_rating_5 setImage:enable forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}


#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    photo = [[UIImageView alloc]init];
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.photo.image = chosenImage;
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [noteTextView becomeFirstResponder];
    
    [customView addSubview:noteTextView]; // add the noteTextView to the view
    alertView.hidden = false;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    alertView.hidden = false;
}
////////Take Photo ////////

///////MODAL ADD NOTE ////

- (IBAction)goBackMenu:(id)sender{
    //////// Flurry //////////
    NSString * name = [wine valueForKey:@"Wine Name"];
    NSString * nameFavourite = [NSString stringWithFormat:@"%@%@%@%d%@",
    @"The user marked the ",name,@" wine with ",rateSelect,@" stars"];

    [Flurry logEvent:nameFavourite];
    //////// Flurry //////////
    
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
