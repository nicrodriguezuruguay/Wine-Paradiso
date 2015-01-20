//
//  ExhibitorsProfileVC.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 30/7/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "ExhibitorsProfileVC.h"
#import "CustomIOS7AlertView.h"//Framework Custom Alert View
#import "FavouritesVC.h"
#import "exhibitorsVC.h"
#import "exhibitorsCell.h"
#import "DataTestVC.h"
#import <Social/Social.h>//Framework Facebook,Twitter

@interface ExhibitorsProfileVC ()

@end

@implementation ExhibitorsProfileVC
@synthesize noteTextView,selectedRow,listExhibitors
,lbl_name_exhibitor_profile,lbl_description_exhibitor_profile,
lbl_button_exhibitor_profile,button_addNote_exhibitor_profile,
lbl_title_moreExhibitor_exhibitor_profile,listView_listWine_exhibitor_profile,
image_exhibitor_profile,lbl_title_exhibitorProfile,lbl_Sydney,photo,alertView,customView,imageViewPhoto;


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
    ////// exhibitors Select //////
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    selectedRow = exhibVC.selectedRow;
    ////// exhibitors Select //////
    
    DataTestVC * dataTest = [DataTestVC getInstance];
    listExhibitors = [[[dataTest listLoadData ] objectAtIndex:1]valueForKey:@"Exhibitor"];
    //listExhibitors
    
    [self showExhibitor:[[listExhibitors objectAtIndex:selectedRow] valueForKey:@"Exhibitor blurb"] photo_exhibitor:[[listExhibitors objectAtIndex:selectedRow] valueForKey:@"photo"]name_exhibitor:[[listExhibitors objectAtIndex:selectedRow] valueForKey:@"Exhibitor Name"]];
    
    /////Font//////
    UIFont *font_title_Sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    UIFont *font_text_description = [UIFont fontWithName:@"Lato-Light" size:12];
    UIFont *font_title_MoreSpeakers = [UIFont fontWithName:@"Lato-Light" size:14];
    UIFont *font_title_name = [UIFont fontWithName:@"Lato-Light" size:16];
    UIFont *font_button_addNote = [UIFont fontWithName:@"Lato-Light" size:12];
    UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    /////Font//////

    
    /////Style//////
    [lbl_name_exhibitor_profile setFont:font_title_name];
    [lbl_title_exhibitorProfile setFont:subTitle];
    [lbl_Sydney setFont:font_title_Sydney];
    [lbl_description_exhibitor_profile setFont:font_text_description];
    [lbl_title_moreExhibitor_exhibitor_profile setFont:font_title_MoreSpeakers];
    [lbl_button_exhibitor_profile setFont:font_button_addNote];
    
    //// make the image with the circle format (ios 7 compatible)/////
    image_exhibitor_profile.layer.cornerRadius = image_exhibitor_profile.frame.size.height /2;
    image_exhibitor_profile.layer.masksToBounds = YES;
    image_exhibitor_profile.layer.borderWidth = 0;
    //// make the image with the circle format (ios 7 compatible)/////
    /////Style//////
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showExhibitor:(NSString*)description_exhibitor photo_exhibitor:(NSString*) photo_exhibitor
      name_exhibitor:(NSString*) name_exhibitor {
    lbl_description_exhibitor_profile.text = description_exhibitor;
    [image_exhibitor_profile setImage:[UIImage imageNamed:photo_exhibitor]];
    lbl_name_exhibitor_profile.text = name_exhibitor;
}
//////////////TABLE VIEW WINE ////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [[[listExhibitors objectAtIndex:selectedRow]valueForKeyPath:@"wineList"] count];
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    DataTestVC * dataTest = [DataTestVC getInstance];
    listExhibitors = [[[dataTest listLoadData ] objectAtIndex:1]valueForKey:@"Exhibitor"];
    
    static NSString *cellSpeakers = @"cellExhibitor_profile";
    exhibitorsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSpeakers];
    
    NSString * nameWine =[[[[listExhibitors objectAtIndex:selectedRow]valueForKeyPath:@"wineList"]objectAtIndex:indexPath.row]valueForKeyPath:@"Wine Name"];
    
    cell. lbl_tableView_wine_name_exhibitor_profile.text=nameWine;
    cell.tag=indexPath.row;//add id tag to the cell
    
    /////Font and Style//////
    UIFont *font = [UIFont fontWithName:@"Lato-BoldItalic" size:14];
    [cell.lbl_tableView_wine_name_exhibitor_profile setFont:font];
    /////Font and Style//////
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    exhibVC.selectedWineRow = (int) indexPath.row;
    
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"wineProfile"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];
    
    
}

//////////////TABLE VIEW WINE ////////////

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

-(void) alertAddFavourites {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Note"
                                                   message: @"Added successfully"
                                                  delegate: self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
}

///////MODAL ADD NOTE ////

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

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.photo.image = chosenImage;
    alertView.hidden = false;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
////////Take Photo ////////
///////MODAL ADD NOTE ////

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
- (IBAction)postToTwitter:(id)sender{
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"#VinoParadiso International Wine & Food Festival, OCTOBER 31 - NOVEMBER 2 2014. AUSTRALIAN TECHNOLOGY PARK"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}
- (IBAction)postToFacebook:(id)sender{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"#VinoParadiso International Wine & Food Festival, OCTOBER 31 - NOVEMBER 2 2014. AUSTRALIAN TECHNOLOGY PARK"];
        [controller addURL:[NSURL URLWithString:@"http://www.vinoparadiso.com.au/"]];
        [controller addImage:[UIImage imageNamed:@""]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
}

- (IBAction)postToInstagram:(id)sender
{
    photo = [[UIImageView alloc]init];
    [photo setImage:[UIImage imageNamed:[[listExhibitors objectAtIndex:selectedRow] valueForKey:@"photo"]]];
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
