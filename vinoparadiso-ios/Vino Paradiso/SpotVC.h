//
//  SpotViewController.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 03/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface SpotVC : UIViewController{

    MKMapView * map;
    IBOutlet UILabel *lblInfo;
    IBOutlet UILabel *lblLocation;
}
////////////////////////////SINGLETON//////////////////////////////////
+(SpotVC *) getInstance;
//////////////////////////////////////////////////////////////////////
@property (weak, nonatomic) IBOutlet MKMapView *maps;
@property (weak, nonatomic) IBOutlet UILabel *lblSydney;

-(IBAction)createEventInCalendar:(id)sender;
-(IBAction)goBackMenu:(id)sender;
- (IBAction)search:(id)sender;

@end
