//
//  exhibitorsViewController.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 15/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface exhibitorsVC : UIViewController
////////////////////////////SINGLETON//////////////////////////////////
+(exhibitorsVC *) getInstance;
//////////////////////////////////////////////////////////////////////
@property (nonatomic,strong) NSMutableArray * listExhibitors;

@property (nonatomic) int selectedWineRow;
@property (nonatomic) int selectedRow;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_exhibitor;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sydney;


- (IBAction)goBackMenu:(id)sender;
- (IBAction)button_addFavourites_speaker:(id)sender;
- (IBAction)search:(id)sender ;
@end
