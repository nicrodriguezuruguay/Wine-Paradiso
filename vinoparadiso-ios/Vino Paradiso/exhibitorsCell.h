//
//  exhibitorsCell.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 1/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface exhibitorsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl_wine_name;
@property (weak, nonatomic) IBOutlet UIImageView *lbl_wine_photo;
@property (strong, nonatomic) IBOutlet UITextView *lbl_wine_description;

@property (weak, nonatomic) IBOutlet UILabel *lbl_button_wine_favourites;
@property (weak, nonatomic) IBOutlet UIButton *button_wine_addFavourites;

@property (weak, nonatomic) IBOutlet UILabel *lbl_tableView_wine_name_exhibitor_profile;

- (IBAction)addFavourites:(id)sender;

@end
