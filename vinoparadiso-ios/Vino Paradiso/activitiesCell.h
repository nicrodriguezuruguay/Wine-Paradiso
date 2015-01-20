//
//  activities.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 12/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface activitiesCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *title_activity;
@property (weak, nonatomic) IBOutlet UILabel *date_activity;
@property (weak, nonatomic) IBOutlet UILabel *description_activity;
@property (weak, nonatomic) IBOutlet UILabel *hour_activity;

@end
