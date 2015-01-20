//
//  wineProfileVC.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 15/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

@interface wineProfileVC : UIViewController<UIDocumentInteractionControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbl_title_wine_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sydney;

@property (weak, nonatomic) IBOutlet UILabel *lbl_name_wine_profile;
@property (weak, nonatomic) IBOutlet UIImageView *image_wine_profile;

@property (weak, nonatomic) IBOutlet UITextView *lbl_description_wine_profile;

@property (weak, nonatomic) IBOutlet UILabel *lbl_button_wine_profile;
@property (weak, nonatomic) IBOutlet UIButton *button_addNote_wine_profile;
@property (weak, nonatomic) IBOutlet UIButton *button_addFavourite_wine_profile;

@property (weak, nonatomic) id wine;
@property (nonatomic, retain) UIDocumentInteractionController *dic;
@property (nonatomic) int selectedRow;

@property (strong, nonatomic) UIView *customView;
@property (strong, nonatomic) CustomIOS7AlertView *alertView;
@property (strong, nonatomic)  UIImageView *imageViewPhoto;
@property (strong, nonatomic)  UIImageView *photo;
@property(strong,nonatomic)UITextView * noteTextView;


//////images rate/////////
@property (weak, nonatomic) IBOutlet UIButton *button_rating_1;
@property (weak, nonatomic) IBOutlet UIButton *button_rating_2;
@property (weak, nonatomic) IBOutlet UIButton *button_rating_3;
@property (weak, nonatomic) IBOutlet UIButton *button_rating_4;
@property (weak, nonatomic) IBOutlet UIButton *button_rating_5;


@property (nonatomic) int rateSelect;

- (IBAction)rating:(id)sender;


//////images rate/////////

- (IBAction)postToTwitter:(id)sender;
- (IBAction)postToFacebook:(id)sender;
- (IBAction)postToInstagram:(id)sender;
- (IBAction)goBackMenu:(id)sender;
-(IBAction)addNote:(id)sender;
- (IBAction)button_addFavourites_wine:(id)sender;
- (IBAction)search:(id)sender ;

@end
