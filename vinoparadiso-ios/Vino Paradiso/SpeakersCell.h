//
//  SpeakersCell.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 24/07/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakersCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl_name_speaker;
@property (strong, nonatomic) IBOutlet UITextView *lbl_description_speaker;

@property (weak, nonatomic) IBOutlet UIImageView *image_photo_speaker;

@property (weak, nonatomic) IBOutlet UIButton *button_addFavourites_speaker;
@property (weak, nonatomic) IBOutlet UIButton *button_shareFavourites_speaker;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Button_Favourites;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Button_share;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name_tableview_speakers_profile;



@end
