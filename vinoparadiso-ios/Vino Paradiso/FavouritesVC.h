//
//  FavouritesVC.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 30/7/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

@interface FavouritesVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

////////////////////////////SINGLETON//////////////////////////////////
+(FavouritesVC *) getInstance;
//////////////////////////////////////////////////////////////////////

@property (strong,nonatomic) NSMutableArray * listFavourites;
@property (strong,nonatomic) NSMutableArray * listNotes;
@property (weak, nonatomic) IBOutlet UIView *viewFavourites;
@property (weak, nonatomic) IBOutlet UIView *viewNotes;
@property (strong, nonatomic) UIView *customView;
@property (strong, nonatomic) CustomIOS7AlertView *alertView;
@property (strong, nonatomic)  UIImageView *imageViewPhoto;
@property (strong, nonatomic)  UIImageView *photo;

@property (weak, nonatomic) IBOutlet UITableView *tableView_Favourites;
@property (weak, nonatomic) IBOutlet UITableView *tableView_Notes;
@property (strong,nonatomic) UITextView * noteTextView;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_favourites;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sydney;

@property (nonatomic) int editMode;//Flag EDITMODE
@property (nonatomic) int indexNote;
- (IBAction)add_note:(id)sender;
- (IBAction)segmentSwitch:(id)sender;
- (IBAction)goBackMenu:(id)sender;
- (IBAction)search:(id)sender;
@end
