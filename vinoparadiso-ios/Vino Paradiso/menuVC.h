//
//  menuViewController.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 04/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuVC : UIViewController
{
    IBOutlet UILabel *lblSydney;
}
////////////////////////////SINGLETON//////////////////////////////////
+(menuVC *) getInstance;
//////////////////////////////////////////////////////////////////////
@property (weak, nonatomic) IBOutlet UIButton *button_ourVibe;
@property (weak, nonatomic) IBOutlet UIButton *button_location;
@property (weak, nonatomic) IBOutlet UIButton *button_floorPlan;
@property (weak, nonatomic) IBOutlet UIButton *button_activities;
@property (weak, nonatomic) IBOutlet UIButton *button_favourites;
@property (weak, nonatomic) IBOutlet UIButton *button_exhibitors;
@property (weak, nonatomic) IBOutlet UIButton *button_tickets;
@property (weak, nonatomic) IBOutlet UIButton *button_sponsors;
@property (weak, nonatomic) IBOutlet UIButton *button_speakers;
@property (weak, nonatomic) IBOutlet UIButton *button_qr;

@property (nonatomic, strong) NSMutableArray *searchResult;


- (IBAction)search:(id)sender;


@end
