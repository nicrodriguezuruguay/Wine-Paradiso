//
//  utilViewController.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 06/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface utilViewController : UIViewController

////////////////////////////SINGLETON//////////////////////////////////
+(utilViewController *) getInstance;
//////////////////////////////////////////////////////////////////////

-(void)createEventInCalendar:(NSString*)eventStart eventEnd:(NSString*) eventEnd eventTitle:(NSString*)eventTitle eventDetails:(NSString*)eventDetails dateFormat:(NSString*) dateFormat ;

-(void) showMessageReminderOk:(NSString*) message;





@end
