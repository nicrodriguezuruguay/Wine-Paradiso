//
//  FavouritesVC.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 30/7/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "FavouritesVC.h"
#import "FavouritesCell.h"
#import "NotesCell.h"
#import "CustomIOS7AlertView.h"
#import "SpeakersVC.h"
#import "exhibitorsVC.h"
#import "SponsorsVC.h"

@interface FavouritesVC ()

@end
@implementation FavouritesVC

////////////////////////////SINGLETON//////////////////////////////////

+(FavouritesVC *) getInstance{ // Singleton activitiesViewController
    static  FavouritesVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
            inst.listFavourites = [[NSMutableArray alloc]init];
            inst.listNotes= [[NSMutableArray alloc]init];
        }
    }
    return inst;
}
//////////////////////////////////////////////////////////////////////
@synthesize viewNotes,viewFavourites,listFavourites,tableView_Favourites,tableView_Notes,listNotes,noteTextView,lbl_title_favourites,lbl_Sydney,imageViewPhoto,customView,alertView,photo,editMode,
indexNote;


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
    UIFont *font_title_Sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    
    [lbl_title_favourites setFont:subTitle];
    [lbl_Sydney setFont:font_title_Sydney];
    [viewFavourites setHidden:YES];
    [viewNotes setHidden:NO];
    
    /////UISegmentedControl Font//////
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : [UIColor whiteColor]
                                                              } forState:UIControlStateNormal];
    
    /////UISegmentedControl Font//////
    
    /////Font//////
    
    
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
    FavouritesVC * favourites = [FavouritesVC getInstance];
    
    if (tableView==tableView_Favourites)
    {
        return favourites.listFavourites.count;
    }
    else
    {
       return favourites.listNotes.count;
    }
    
    
    // Return the number of rows in the section.
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath        *)indexPath
{
    FavouritesVC * favourites = [FavouritesVC getInstance];
    
    if (tableView==tableView_Favourites)
    {
        static NSString *cellSpeakers = @"FavouriteCell";//cellSpeakers_profile
        //static NSString *cellSpeakers_profile = @"cellSpeakers_profile";
        
        FavouritesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSpeakers];

        cell.name_favourites.text=[[favourites.listFavourites objectAtIndex:indexPath.row] valueForKey:@"name"];
        /////Font and Style//////
        UIFont *font = [UIFont fontWithName:@"Lato-BoldItalic" size:14];
        [cell.name_favourites setFont:font];
        /////Font and Style//////
        
        return cell;
    }
    else
    {
        static NSString *cellSpeakers = @"NoteCell";
        NotesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSpeakers];
        //Array
        ///Note(dictionary)
        ////>Description = "description"
        ////>photo = "photo"
        cell.description_notes.text=[[favourites.listNotes objectAtIndex:indexPath.row]valueForKey:@"description"];
        UIImageView * photoView = [[UIImageView alloc]init];
        photoView = [[favourites.listNotes objectAtIndex:indexPath.row]valueForKey:@"photo"];
        cell.image_notes.image =photoView.image;
        /////Font and Style//////
        UIFont *font = [UIFont fontWithName:@"Lato-BoldItalic" size:14];
        //[cell.name_favourites setFont:font];
        /////Font and Style//////
        
        return cell;

    }
    
    return nil;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavouritesVC * favourites = [FavouritesVC getInstance];
    SponsorsVC  * sponsVC = [SponsorsVC getInstance];
    SpeakersVC  * speakVC = [SpeakersVC getInstance];
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    
    if (tableView==tableView_Favourites)
    {
    NSString * classObject =[[favourites.listFavourites objectAtIndex:indexPath.row] valueForKey:@"class"];
    
    
     /////////////EXHIBITOR ///////////////
    if ([classObject isEqualToString:@"Exhibitor"]) {
        
        exhibVC.selectedRow = (int) [[[favourites.listFavourites objectAtIndex:indexPath.row] valueForKey:@"indexObject"]integerValue];
        
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitorsProfile"];
        
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:transition forKey:nil];
        [self presentViewController:controller animated:NO completion:nil];

        
    }
    /////////////EXHIBITOR ///////////////
    
    
    /////////////SPONSOR ///////////////
    if ([classObject isEqualToString:@"Sponsor"]) {
        sponsVC.selectedRow = (int) [[[favourites.listFavourites objectAtIndex:indexPath.row] valueForKey:@"indexObject"]integerValue];
        
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SponsorsProfile"];
        
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:transition forKey:nil];
        [self presentViewController:controller animated:NO completion:nil];

        
    }
    /////////////SPONSOR ///////////////
    
    /////////////SPEAKERS ///////////////
    if ([classObject isEqualToString:@"Speakers"]) {
        speakVC.selectedRow = (int) [[[favourites.listFavourites objectAtIndex:indexPath.row] valueForKey:@"indexObject"]integerValue];
        
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SpeakersProfile"];
        
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:transition forKey:nil];
        [self presentViewController:controller animated:NO completion:nil];

    }
    /////////////SPEAKERS ///////////////
        
        /////////////WINE ///////////////
        if ([classObject isEqualToString:@"Wine"]) {
            
            exhibVC.selectedRow = (int) [[[favourites.listFavourites objectAtIndex:indexPath.row] valueForKey:@"indexObjectExhibitor"]integerValue];
            exhibVC.selectedWineRow = (int) [[[favourites.listFavourites objectAtIndex:indexPath.row] valueForKey:@"indexObjectWine"]integerValue];
            
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"wineProfile"];
            
            
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [self.view.window.layer addAnimation:transition forKey:nil];
            [self presentViewController:controller animated:NO completion:nil];
            
        }
        /////////////WINE ///////////////

    }
    
    else{//RETURN THE INDEX OF THE NOTE ///// EDIT ///////
        [self edit_note:indexPath.row];
        
    }//RETURN THE INDEX OF THE NOTE ///// EDIT ///////
    
}
/////////DELETE ROW //////////
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    FavouritesVC * favourites = [FavouritesVC getInstance];
    
    
    if (tableView==tableView_Favourites)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            // Delete the row from the data source
            [tableView beginUpdates];
            [[favourites listFavourites] removeObjectAtIndex:indexPath.row];
            [tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView endUpdates];
        }
    }
    else
    {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            // Delete the row from the data source
            [tableView beginUpdates];
            [[favourites listNotes] removeObjectAtIndex:indexPath.row];
            [tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView endUpdates];
        }

    }

    
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"DELETE";
}

/////////DELETE ROW //////////

- (IBAction)goBackMenu:(id)sender{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

///////MODAL ADD NOTE ////
-(void) edit_note:(int) index {
    indexNote = index;
    FavouritesVC * favorites = [FavouritesVC getInstance];
    editMode =1; //flag EDIT MODE
    
   
    alertView = [[CustomIOS7AlertView alloc] init];
    customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 220)];
    [customView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_menu.png"]]];
    
    noteTextView =[[UITextView alloc]initWithFrame:CGRectMake(120, 10, 150, 200)];
    noteTextView.text = [[favorites.listNotes objectAtIndex:indexNote]valueForKey:@"description"];
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

- (IBAction)add_note:(id)sender {
   
    alertView = [[CustomIOS7AlertView alloc] init];
    customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 220)];
    [customView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_menu.png"]]];
    
    noteTextView =[[UITextView alloc]initWithFrame:CGRectMake(120, 10, 150, 200)];
    imageViewPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    imageViewPhoto.image =[UIImage imageNamed:@"button_add_photo.png"];
    [noteTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
    //////// Image Clicked ///////
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
        initWithTarget:self
        action:@selector(takePhoto:)];
    
    
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
        if (editMode == 1) { //EditMode 1 is ON
            FavouritesVC * favorites = [FavouritesVC getInstance];
            [[favorites.listNotes objectAtIndex:indexNote]setValue:noteTextView.text forKey:@"description"];
            if (photo != nil) {
                [[favorites.listNotes objectAtIndex:indexNote]setValue:photo forKey:@"photo"];
            }
            editMode = 0;//EditMode 1 is OFF
            [tableView_Notes reloadData];//update
            [alertView close];

        }
        else{
            FavouritesVC * favorites = [FavouritesVC getInstance];
            NSMutableDictionary * notes = [[NSMutableDictionary alloc]init];
            [notes setValue:noteTextView.text  forKey:@"description"];
            [notes setValue:photo forKey:@"photo"];
            [favorites.listNotes addObject:notes];
            [tableView_Notes reloadData];//update the Tableview
            [self alertAddFavourites];
            photo = nil;
            [alertView close];
        }
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

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        [viewFavourites setHidden:NO];
        [viewNotes setHidden:YES];
    }
    else{
        //toggle the correct view to be visible
        [viewFavourites setHidden:YES];
        [viewNotes setHidden:NO];
    }
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
