//
//  ourVibeViewController.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 12/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ourVibeVC : UIViewController
{
    IBOutlet UILabel *lblOurVibe;
    
    IBOutlet UITextView *lblInfo;
}
////////////////////////////SINGLETON//////////////////////////////////
+(ourVibeVC *) getInstance;
//////////////////////////////////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel *lbl_A_FloorPlan;
@property (weak, nonatomic) IBOutlet UILabel *lbl_B_FloorPlan;
@property (weak, nonatomic) IBOutlet UILabel *lbl_C_FloorPlan;
@property (weak, nonatomic) IBOutlet UILabel *lbl_D_FloorPlan;
@property (weak, nonatomic) IBOutlet UILabel *lbl_E_FloorPlan;
@property (weak, nonatomic) IBOutlet UILabel *lbl_F_FloorPlan;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_FloorPlan;

- (IBAction)goBackMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblSydney;
- (IBAction)search:(id)sender;



@end
