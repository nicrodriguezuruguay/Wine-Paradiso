//
//  activitiesViewController.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 06/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface activitiesVC : UIViewController<UIActionSheetDelegate,UIDocumentInteractionControllerDelegate>
////////////////////////////SINGLETON//////////////////////////////////
+(activitiesVC *) getInstance;
//////////////////////////////////////////////////////////////////////
@property(nonatomic,weak) NSMutableArray * listActivities;

@property (weak, nonatomic) IBOutlet UITableView *tableView_activity;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_Activity;
@property (weak, nonatomic) IBOutlet UILabel *lblSydney;
@property (nonatomic) int selectedRow;




-(IBAction)shareEvent:(id)sender;
-(IBAction)goBackMenu:(id)sender;
- (IBAction)search:(id)sender;


@end
