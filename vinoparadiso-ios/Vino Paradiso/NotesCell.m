//
//  NotesCell.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 30/7/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "NotesCell.h"

@implementation NotesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end