//
//  ViewController.m
//  QRCodeReader
//
//  Created by Gabriel Theodoropoulos on 27/11/13.
//  Copyright (c) 2013 Gabriel Theodoropoulos. All rights reserved.
//

#import "QrReaderVC.h"
#import "menuVC.h"
#import "exhibitorsVC.h"

@interface QrReaderVC ()
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL isReading;

-(BOOL)startReading;
-(void)stopReading;
-(void)loadBeepSound;

@end

@implementation QrReaderVC
@synthesize cam_QR,lblSydney,lbl_title_QrScanner;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /////Font//////
    UIFont *font_title_sydney = [UIFont fontWithName:@"Lato-BoldItalic" size:12];
    UIFont *subTitle = [UIFont fontWithName:@"Lato-BoldItalic" size:16];
    
    [lbl_title_QrScanner setFont:subTitle];
    [lblSydney setFont:font_title_sydney];
    
    /////Font//////
    
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initially make the captureSession object nil.
    _captureSession = nil;
    
    // Set the initial value of the flag to NO.
    _isReading = NO;
    
    // Begin loading the sound effect so to have it ready for playback when it's needed.
    [self loadBeepSound];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackMenu:(id)sender{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
#pragma mark - IBAction method implementation

- (IBAction)startStopReading:(id)sender {
        if ([self startReading]) {
            // If the startReading methods returns YES and the capture session is successfully
            // running, then change the start button title and the status message.
            [_bbitemStart setTitle:@"Stop"];
            [_lblStatus setText:@"Scanning for QR Code..."];
        }
}


#pragma mark - Private method implementation

- (BOOL)startReading {
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];

    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    // Start video capture.
    [_captureSession startRunning];
    
    return YES;
}


-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
}


-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    /*
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];

    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
    }
     */
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            NSString * result = [metadataObj stringValue];
            [self showExhibitorProfileQR:result];
           
        }
    }
    
    
}

-(void) showExhibitorProfileQR:(NSString *)nameExhibitor {

    [self performSelectorOnMainThread:@selector(moveToProductDescription:) withObject:nameExhibitor waitUntilDone:NO];
    
}

- (void)moveToProductDescription:(NSString*)nameExhibitor
{
    int indexObject;
    
    exhibitorsVC * exhibVC = [exhibitorsVC getInstance];
    if (nameExhibitor != nil) {
        for (id key in exhibVC.listExhibitors) {
            if ([[key valueForKey:@"Exhibitor Name"] isEqualToString:nameExhibitor]) {
                indexObject = [exhibVC.listExhibitors indexOfObject:key];
                
            }
        }
    }
    
    exhibVC.selectedRow = indexObject;
    
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitorsProfile"];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)search:(id)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];
}

@end
