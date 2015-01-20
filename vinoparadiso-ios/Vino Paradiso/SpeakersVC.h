//
//  SpeakersVC.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 24/07/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakersVC : UIViewController

////////////////////////////SINGLETON//////////////////////////////////
+(SpeakersVC *) getInstance;
//////////////////////////////////////////////////////////////////////

- (IBAction)goBackMenu:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView * tableView_speakers;

@property (weak, nonatomic) NSMutableArray * listSpeakers;

@property (weak, nonatomic) IBOutlet UILabel *lblSydney;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_Speakers;
@property (nonatomic) int selectedRow;

- (IBAction)button_addFavourites_speaker:(id)sender;
- (IBAction)search:(id)sender ;




@end
