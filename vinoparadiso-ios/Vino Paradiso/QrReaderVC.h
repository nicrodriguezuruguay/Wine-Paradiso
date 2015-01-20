//
//  ViewController.h
//  QRCodeReader
//
//  Created by Gabriel Theodoropoulos on 27/11/13.
//  Copyright (c) 2013 Gabriel Theodoropoulos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QrReaderVC : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bbitemStart;

@property (weak, nonatomic) IBOutlet UILabel *lbl_title_QrScanner;

@property (weak, nonatomic) IBOutlet UIView *cam_QR;
@property (weak, nonatomic) IBOutlet UILabel *lblSydney;

- (IBAction)startStopReading:(id)sender;
- (IBAction)goBackMenu:(id)sender;
- (IBAction)search:(id)sender;



@end
