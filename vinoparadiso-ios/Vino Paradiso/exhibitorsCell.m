//
//  exhibitorsCell.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 1/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "exhibitorsCell.h"

@implementation exhibitorsCell

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

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 4;
    frame.size.height -= 2 * 4;
    [super setFrame:frame];
}

- (IBAction)addFavourites:(id)sender {
}
@end
