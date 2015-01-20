//
//  SponsorsProfileVC.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 1/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

@interface SponsorsProfileVC : UIViewController<UIDocumentInteractionControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(strong,nonatomic)UITextView * noteTextView;

@property (weak, nonatomic) IBOutlet UILabel *lbl_title_sponsorsProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sydney;

@property (weak, nonatomic) IBOutlet UILabel *lbl_name_sponsors_profile;

@property (weak, nonatomic) IBOutlet UITextView *lbl_description_sponsors_profile;

@property (weak, nonatomic) IBOutlet UILabel *lbl_button_sponsors_profile;
@property (weak, nonatomic) IBOutlet UIButton *button_addNote_sponsors_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_moreSponsors_exhibitor_profile;
@property (weak, nonatomic) IBOutlet UITableView *listView_listWine_sponsors_profile;
@property (nonatomic) int selectedRow;
@property (weak, nonatomic) NSMutableArray * listSponsors;
@property (weak, nonatomic) IBOutlet UIImageView *image_sponsors_profile;

@property (nonatomic, retain) UIDocumentInteractionController *dic;

@property (strong, nonatomic) UIView *customView;
@property (strong, nonatomic) CustomIOS7AlertView *alertView;
@property (strong, nonatomic)  UIImageView *imageViewPhoto;
@property (strong, nonatomic)  UIImageView *photo;


- (IBAction)postToFacebook:(id)sender;
- (IBAction)postToTwitter:(id)sender;
- (IBAction)postToInstagram:(id)sender;
- (IBAction)goBackMenu:(id)sender;
-(IBAction)addNote:(id)sender;
- (IBAction)search:(id)sender;



@end
