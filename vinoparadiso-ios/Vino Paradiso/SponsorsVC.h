//
//  SponsorsVC.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 1/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SponsorsVC : UIViewController

////////////////////////////SINGLETON//////////////////////////////////
+(SponsorsVC *) getInstance;
//////////////////////////////////////////////////////////////////////

@property (weak, nonatomic) NSMutableArray * listSponsors;
@property (nonatomic) int selectedRow;
@property (weak, nonatomic) IBOutlet UILabel *lblSydney;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_Sponsor;




- (IBAction)goBackMenu:(id)sender;
- (IBAction)button_addFavourites_speaker:(id)sender;
- (IBAction)search:(id)sender ;

@end
