//
//  activities.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 12/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "activitiesCell.h"

@implementation activitiesCell


- (void)setFrame:(CGRect)frame {
    frame.origin.y += 4;
    frame.size.height -= 2 * 4;
    [super setFrame:frame];
}
@end
