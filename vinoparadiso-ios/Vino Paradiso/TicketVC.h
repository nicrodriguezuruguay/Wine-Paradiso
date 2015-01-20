//
//  TicketVC.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 29/7/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbl_Sydney;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title_favourites;


- (IBAction)goBackMenu:(id)sender;
- (IBAction)buy_tickets:(id)sender;
- (IBAction)search:(id)sender;

@end
