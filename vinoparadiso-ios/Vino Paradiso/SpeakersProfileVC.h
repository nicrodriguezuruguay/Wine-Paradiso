//
//  SpeakersProfileVC.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 29/7/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

@interface SpeakersProfileVC : UIViewController <UIDocumentInteractionControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
//UIDocumentInteractionControllerDelegate is of Instagram
////////////////////////////SINGLETON//////////////////////////////////
+(SpeakersProfileVC *) getInstance;
//////////////////////////////////////////////////////////////////////

///////Speakers Profile //////
@property (weak, nonatomic) NSMutableArray * listSpeakers;

@property(strong,nonatomic)UITextView * noteTextView;//notes
@property (weak, nonatomic) IBOutlet UITableView *tableView_speakers_profile;
@property (weak, nonatomic) IBOutlet UILabel *name_speakers_profile;
@property (weak, nonatomic) IBOutlet UIImageView *image_speakers_profile;
@property (weak, nonatomic) IBOutlet UILabel *description_speakers_profile;
@property (weak, nonatomic) IBOutlet UIButton *button_addNote_speakers_profile;
@property (weak, nonatomic) IBOutlet UILabel *text_button_addNote_speakers_profile;

@property (weak, nonatomic) IBOutlet UIButton *button_facebook_speakers_profile;
@property (weak, nonatomic) IBOutlet UIButton *button_twitter_speakers_profile;
@property (weak, nonatomic) IBOutlet UIButton *button_google_speakers_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_speakers_speakers_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_MoreSpeakers;

@property (strong, nonatomic) UIView *customView;
@property (strong, nonatomic) CustomIOS7AlertView *alertView;
@property (strong, nonatomic)  UIImageView *imageViewPhoto;
@property (strong, nonatomic)  UIImageView *photo;

@property (weak, nonatomic) IBOutlet UILabel *lblSydney;
@property (nonatomic) int selectedRow;

@property (nonatomic, retain) UIDocumentInteractionController *dic;


- (IBAction)goBackMenu:(id)sender;
- (IBAction)addNote:(id)sender;
- (IBAction)postToTwitter:(id)sender;
- (IBAction)postToFacebook:(id)sender;
- (IBAction)postToInstagram:(id)sender;
- (IBAction)search:(id)sender ;
//////Speakers Profile //////

@end
