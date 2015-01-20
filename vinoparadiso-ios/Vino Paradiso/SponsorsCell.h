//
//  SponsorsCell.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 1/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SponsorsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl_name_sponsor;
@property (strong, nonatomic) IBOutlet UITextView *lbl_description_sponsor;

@property (weak, nonatomic) IBOutlet UIImageView *image_photo_sponsor;

@property (weak, nonatomic) IBOutlet UIButton *button_addFavourites_sponsor;


@property (weak, nonatomic) IBOutlet UIButton *button_shareFavourites_speaker;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Button_Favourites;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Button_share;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name_tableview_sponsor_profile;

@end
