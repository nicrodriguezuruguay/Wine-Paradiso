//
//  SpeakersProfileVC.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 29/7/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "SpeakersProfileVC.h"
#import "DataTestVC.h"
#import "SpeakersCell.h"
#import "SpeakersVC.h"
#import <Social/Social.h>//Framework Facebook,Twitter
#import "FavouritesVC.h"
#import "CustomIOS7AlertView.h"


@interface SpeakersProfileVC ()

@end

@implementation SpeakersProfileVC
////////////////////////////SINGLETON//////////////////////////////////

+(SpeakersProfileVC *) getInstance{ // Singleton activitiesViewController
    static  SpeakersProfileVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
        }
    }
    return inst;
}
//////////////////////////////////////////////////////////////////////

@synthesize dic,tableView_speakers_profile,image_speakers_profile,
            description_speakers_profile,button_addNote_speakers_profile,
            text_button_addNote_speakers_profile,button_facebook_speakers_profile,
            button_twitter_speakers_profile,button_google_speakers_profile,
            lbl_title_speakers_speakers_profile,listSpeakers,lblSydney,lbl_title_MoreSpeakers,selectedRow,name_speakers_profile,noteTextView,photo,alertView,customView,imageViewPhoto;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad

{   ////// Speakers Select //////
    SpeakersVC * speakVC = [SpeakersVC getInstance];
    selectedRow = speakVC.selectedRow;
    ////// Speakers Select //////
    
    
    //listSpeakers
    
    [self showSpeaker:[[speakVC.listSpeakers objectAtIndex:selectedRow] valueForKey:@"Speaker bio"] photo_speakers:[[speakVC.listSpeakers objectAtIndex:selectedRow] valueForKey:@"photo"]name_speakers:[[speakVC.listSpeakers objectAtIndex:selectedRow] valueForKey:@"Speaker full name"]];
    
    /////Font//////
    UIFont *font_title_Sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    UIFont *font_text_description = [UIFont fontWithName:@"Lato-Light" size:12];
    UIFont *font_button_addNote = [UIFont fontWithName:@"Lato-Light" size:12];
    UIFont *font_title_MoreSpeakers = [UIFont fontWithName:@"Lato-Light" size:14];
    UIFont *font_title_name = [UIFont fontWithName:@"Lato-Light" size:16];
    /////Font//////
    
    /////Style//////
    [name_speakers_profile setFont:font_title_name];
    [lbl_title_speakers_speakers_profile setFont:subTitle];
    [lblSydney setFont:font_title_Sydney];
    [description_speakers_profile setFont:font_text_description];
    [lbl_title_MoreSpeakers setFont:font_title_MoreSpeakers];
    [text_button_addNote_speakers_profile setFont:font_button_addNote];
    
    //// make the image with the circle format (ios 7 compatible)/////
    image_speakers_profile.layer.cornerRadius = image_speakers_profile.frame.size.height /2;
    image_speakers_profile.layer.masksToBounds = YES;
    image_speakers_profile.layer.borderWidth = 0;
    //// make the image with the circle format (ios 7 compatible)/////
    /////Style//////

}
-(void) showSpeaker:(NSString*)description_speakers photo_speakers:(NSString*) photo_speakers
name_speakers:(NSString*) name_speakers {
    description_speakers_profile.text = description_speakers;
    [image_speakers_profile setImage:[UIImage imageNamed:photo_speakers]];
    name_speakers_profile.text = name_speakers;
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
    
    static NSString *cellSpeakers = @"cellSpeakers_profile";
    SpeakersCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSpeakers];

    cell.lbl_name_tableview_speakers_profile.text=[[speakVC.listSpeakers objectAtIndex:indexPath.row]valueForKey:@"Speaker full name"];
    
    /////Font and Style//////
    UIFont *font = [UIFont fontWithName:@"Lato-BoldItalic" size:14];
    [cell.lbl_name_tableview_speakers_profile setFont:font];
    /////Font and Style//////
    
    return cell;
    
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
     SpeakersVC * speakVC = [SpeakersVC getInstance];
    
    UIImageView *photoInstangram = [[UIImageView alloc]init];
    [photoInstangram setImage:[UIImage imageNamed:[[speakVC.listSpeakers objectAtIndex:selectedRow] valueForKey:@"photo"]]];
    UIImage * screenShot = photoInstangram.image;
    
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
