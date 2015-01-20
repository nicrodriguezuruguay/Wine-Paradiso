//
//  cargarDatosViewController.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 15/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "DataTestVC.h"
#import "activitiesVC.h"
#import "parseCSV.h"

@interface DataTestVC ()

@end

@implementation DataTestVC
////////////////////////////SINGLETON//////////////////////////////////

+(DataTestVC *) getInstance{ // Singleton activitiesViewController
    static  DataTestVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
            [inst loadData];
        }
    }
    return inst;
}
//////////////////////////////////////////////////////////////////////
@synthesize listLoadData,Exhibitor_list,Exhibitor_object;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadData {
    listLoadData = [[NSMutableArray alloc]init];
    
    
    NSMutableArray * Wines_list = [[ NSMutableArray alloc]init];
   // NSMutableArray * Exhibitor_list = [[ NSMutableArray alloc]init];
    NSMutableArray * Sponsor_list = [[ NSMutableArray alloc]init];
    NSMutableArray * Speaker_list = [[ NSMutableArray alloc]init];
    NSMutableArray * Schedule_list = [[ NSMutableArray alloc]init];

    
    NSMutableDictionary * Wines_object = [[NSMutableDictionary alloc]init];
   // NSMutableDictionary * Exhibitor_object = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * Sponsor_object = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * Speaker_object = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * Schedule_object = [[NSMutableDictionary alloc]init];
    
    NSMutableDictionary * Wines = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * Exhibitor = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * Sponsor = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * Speaker = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * Schedule = [[NSMutableDictionary alloc]init];
    
    
    ////****************Create object ****************/////
    
    //////WINE ////////////
    [Wines_object setValue:@"Bream Creek Wines"forKey:@"Exhibitor"];
    [Wines_object setValue:@"Wine Exhibitor 1" forKey:@"Wine Name"];
    [Wines_object setValue:@"Value" forKey:@"Vineyard"];
    [Wines_object setValue:@"Value" forKey:@"Vintage"];
    [Wines_object setValue:@"Value" forKey:@"Grape/Blend"];
    [Wines_object setValue:@"Value" forKey:@"Wine Blurb"];
    [Wines_object setValue:@"Value" forKey:@"Buy now (for future use/optional)"];
    [Wines_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Wines_list addObject:Wines_object];
    Wines_object = [[NSMutableDictionary alloc]init];
    
    [Wines_object setValue:@"Bream Creek Wines"forKey:@"Exhibitor"];
    [Wines_object setValue:@"Wine Exhibitor 1" forKey:@"Wine Name"];
    [Wines_object setValue:@"Value" forKey:@"Vineyard"];
    [Wines_object setValue:@"Value" forKey:@"Vintage"];
    [Wines_object setValue:@"Value" forKey:@"Grape/Blend"];
    [Wines_object setValue:@"Value" forKey:@"Wine Blurb"];
    [Wines_object setValue:@"Value" forKey:@"Buy now (for future use/optional)"];
     [Wines_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Wines_list addObject:Wines_object];
    Wines_object = [[NSMutableDictionary alloc]init];
    
    [Wines_object setValue:@"Bream Creek Wines"forKey:@"Exhibitor"];
    [Wines_object setValue:@"Wine Exhibitor 2" forKey:@"Wine Name"];
    [Wines_object setValue:@"Value" forKey:@"Vineyard"];
    [Wines_object setValue:@"Value" forKey:@"Vintage"];
    [Wines_object setValue:@"Value" forKey:@"Grape/Blend"];
    [Wines_object setValue:@"Value" forKey:@"Wine Blurb"];
    [Wines_object setValue:@"Value" forKey:@"Buy now (for future use/optional)"];
     [Wines_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Wines_list addObject:Wines_object];
    Wines_object = [[NSMutableDictionary alloc]init];
    
    [Wines_object setValue:@"Bream Creek Wines"forKey:@"Exhibitor"];
    [Wines_object setValue:@"Wine Exhibitor 3 " forKey:@"Wine Name"];
    [Wines_object setValue:@"Value" forKey:@"Vineyard"];
    [Wines_object setValue:@"Value" forKey:@"Vintage"];
    [Wines_object setValue:@"Value" forKey:@"Grape/Blend"];
    [Wines_object setValue:@"Value" forKey:@"Wine Blurb"];
    [Wines_object setValue:@"Value" forKey:@"Buy now (for future use/optional)"];
    [Wines_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Wines_list addObject:Wines_object];
    Wines_object = [[NSMutableDictionary alloc]init];
    //////WINE ////////////
    
    //////Exhibitor ////////////
    [self createExhibitor];
    /*
    [Exhibitor_object setValue:@"Exhibitor 1" forKey:@"Exhibitor Name"];
    [Exhibitor_object setValue:@"Value" forKey:@"Exhibitor blurb"];
    [Exhibitor_object setValue:@"Value" forKey:@"Facebook"];
    [Exhibitor_object setValue:@"Value" forKey:@"Twitter"];
    [Exhibitor_object setValue:@"Value" forKey:@"Instagram"];
    [Exhibitor_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Exhibitor_list addObject:Exhibitor_object];
    Exhibitor_object = [[NSMutableDictionary alloc]init];
    
    [Exhibitor_object setValue:@"Exhibitor 2" forKey:@"Exhibitor Name"];
    [Exhibitor_object setValue:@"Value" forKey:@"Exhibitor blurb"];
    [Exhibitor_object setValue:@"Value" forKey:@"Facebook"];
    [Exhibitor_object setValue:@"Value" forKey:@"Twitter"];
    [Exhibitor_object setValue:@"Value" forKey:@"Instagram"];
    [Exhibitor_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Exhibitor_list addObject:Exhibitor_object];
    Exhibitor_object = [[NSMutableDictionary alloc]init];
    
    [Exhibitor_object setValue:@"Exhibitor 3" forKey:@"Exhibitor Name"];
    [Exhibitor_object setValue:@"Value" forKey:@"Exhibitor blurb"];
    [Exhibitor_object setValue:@"Value" forKey:@"Facebook"];
    [Exhibitor_object setValue:@"Value" forKey:@"Twitter"];
    [Exhibitor_object setValue:@"Value" forKey:@"Instagram"];
    [Exhibitor_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Exhibitor_list addObject:Exhibitor_object];
    Exhibitor_object = [[NSMutableDictionary alloc]init];
    
    [Exhibitor_object setValue:@"Exhibitor 4" forKey:@"Exhibitor Name"];
    [Exhibitor_object setValue:@"Value" forKey:@"Exhibitor blurb"];
    [Exhibitor_object setValue:@"Value" forKey:@"Facebook"];
    [Exhibitor_object setValue:@"Value" forKey:@"Twitter"];
    [Exhibitor_object setValue:@"Value" forKey:@"Instagram"];
    [Exhibitor_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Exhibitor_list addObject:Exhibitor_object];
    Exhibitor_object = [[NSMutableDictionary alloc]init];
    */
    //////Exhibitor ////////////
    
    //////Sponsor ////////////

    [Sponsor_object setValue:@"Sponsor Name1" forKey:@"Sponsor Name"];
    [Sponsor_object setValue:@"Sponsor blurb blurb blurb blurb blurb" forKey:@"Sponsor blurb"];
    [Sponsor_object setValue:@"Value" forKey:@"Facebook"];
    [Sponsor_object setValue:@"Value" forKey:@"Twitter"];
    [Sponsor_object setValue:@"Value" forKey:@"Instagram"];
    [Sponsor_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Sponsor_list addObject:Sponsor_object];
    Sponsor_object = [[NSMutableDictionary alloc]init];
    
    [Sponsor_object setValue:@"Sponsor Name2" forKey:@"Sponsor Name"];
    [Sponsor_object setValue:@"Sponsor blurb blurb blurb blurb blurb" forKey:@"Sponsor blurb"];
    [Sponsor_object setValue:@"Value" forKey:@"Facebook"];
    [Sponsor_object setValue:@"Value" forKey:@"Twitter"];
    [Sponsor_object setValue:@"Value" forKey:@"Instagram"];
    [Sponsor_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Sponsor_list addObject:Sponsor_object];
    Sponsor_object = [[NSMutableDictionary alloc]init];
    
    [Sponsor_object setValue:@"Sponsor Name3" forKey:@"Sponsor Name"];
    [Sponsor_object setValue:@"Sponsor blurb blurb blurb blurb blurb" forKey:@"Sponsor blurb"];
    [Sponsor_object setValue:@"Value" forKey:@"Facebook"];
    [Sponsor_object setValue:@"Value" forKey:@"Twitter"];
    [Sponsor_object setValue:@"Value" forKey:@"Instagram"];
    [Sponsor_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Sponsor_list addObject:Sponsor_object];
    Sponsor_object = [[NSMutableDictionary alloc]init];
    
    [Sponsor_object setValue:@"Sponsor Name4" forKey:@"Sponsor Name"];
    [Sponsor_object setValue:@"Sponsor blurb blurb blurb blurb blurb" forKey:@"Sponsor blurb"];
    [Sponsor_object setValue:@"Value" forKey:@"Facebook"];
    [Sponsor_object setValue:@"Value" forKey:@"Twitter"];
    [Sponsor_object setValue:@"Value" forKey:@"Instagram"];
    [Sponsor_object setValue:@"image_exhibitors1.png" forKey:@"photo"];
    [Sponsor_list addObject:Sponsor_object];
    Sponsor_object = [[NSMutableDictionary alloc]init];
     //////Sponsor ////////////
    
     //////Speaker ////////////
    [Speaker_object setValue:@"EMMA THOMPSON" forKey:@"Speaker full name"];
    [Speaker_object setValue:@"Small speaker / Speach description" forKey:@"Speaker bio"];
    [Speaker_object setValue:@"Value" forKey:@"Facebook"];
    [Speaker_object setValue:@"Value" forKey:@"Twitter"];
    [Speaker_object setValue:@"Value" forKey:@"Instagram"];
    [Speaker_object setValue:@"image_exhibitors1.png" forKey:@"photo"];//New data
    [Speaker_list addObject:Speaker_object];
    Speaker_object = [[NSMutableDictionary alloc]init];
    
    
    [Speaker_object setValue:@"EMMA THOMPSON" forKey:@"Speaker full name"];
    [Speaker_object setValue:@"Small speaker / Speach description" forKey:@"Speaker bio"];
    [Speaker_object setValue:@"Value" forKey:@"Facebook"];
    [Speaker_object setValue:@"Value" forKey:@"Twitter"];
    [Speaker_object setValue:@"Value" forKey:@"Instagram"];
    [Speaker_object setValue:@"image_exhibitors1.png" forKey:@"photo"];//New data
    [Speaker_list addObject:Speaker_object];
    Speaker_object = [[NSMutableDictionary alloc]init];

    
    [Speaker_object setValue:@"EMMA THOMPSON" forKey:@"Speaker full name"];
    [Speaker_object setValue:@"Small speaker / Speach description" forKey:@"Speaker bio"];
    [Speaker_object setValue:@"Value" forKey:@"Facebook"];
    [Speaker_object setValue:@"Value" forKey:@"Twitter"];
    [Speaker_object setValue:@"Value" forKey:@"Instagram"];
    [Speaker_object setValue:@"image_exhibitors1.png" forKey:@"photo"];//New data
    [Speaker_list addObject:Speaker_object];
    Speaker_object = [[NSMutableDictionary alloc]init];

    
    [Speaker_object setValue:@"EMMA THOMPSON" forKey:@"Speaker full name"];
    [Speaker_object setValue:@"Small speaker / Speach description" forKey:@"Speaker bio"];
    [Speaker_object setValue:@"Value" forKey:@"Facebook"];
    [Speaker_object setValue:@"Value" forKey:@"Twitter"];
    [Speaker_object setValue:@"Value" forKey:@"Instagram"];
    [Speaker_object setValue:@"image_exhibitors1.png" forKey:@"photo"];//New data
    [Speaker_list addObject:Speaker_object];
    Speaker_object = [[NSMutableDictionary alloc]init];

    
    [Speaker_object setValue:@"EMMA THOMPSON" forKey:@"Speaker full name"];
    [Speaker_object setValue:@"Small speaker / Speach description" forKey:@"Speaker bio"];
    [Speaker_object setValue:@"Value" forKey:@"Facebook"];
    [Speaker_object setValue:@"Value" forKey:@"Twitter"];
    [Speaker_object setValue:@"Value" forKey:@"Instagram"];
    [Speaker_object setValue:@"image_exhibitors1.png" forKey:@"photo"];//New data
    [Speaker_list addObject:Speaker_object];
    Speaker_object = [[NSMutableDictionary alloc]init];
    //////Speaker ////////////
    
    //////Activity ////////////
    [Schedule_object setValue:@"12 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"12:45" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    
    [Schedule_object setValue:@"18 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"17:45" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    
    [Schedule_object setValue:@"20 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"20:15" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    
    [Schedule_object setValue:@"15 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"13:35" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    
    [Schedule_object setValue:@"02 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"19:50" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    
    [Schedule_object setValue:@"09 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"12:45" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    
    [Schedule_object setValue:@"25 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"09:00" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    
    [Schedule_object setValue:@"27 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"11:45" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    
    [Schedule_object setValue:@"29 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"16:40" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    
    [Schedule_object setValue:@"30 DIC" forKey:@"Date DD/MMM"];
    [Schedule_object setValue:@"15:45" forKey:@"Time 24:00"];
    [Schedule_object setValue:@"Title of Activity" forKey:@"Activity Title"];
    [Schedule_object setValue:@"Description of Activity" forKey:@"Activity Description"];
    [Schedule_list addObject:Schedule_object];
    Schedule_object = [[NSMutableDictionary alloc]init];
    //////Activity ////////////
    
    ////****************Create object ****************/////

    
    ////Add the object in the list with the same name /////

    [Wines setValue:Wines_list forKey:@"Wines"];
    [Exhibitor setValue:Exhibitor_list forKey:@"Exhibitor"];
    [Sponsor setValue:Sponsor_list forKey:@"Sponsor"];
    [Speaker setValue:Speaker_list forKey:@"Speaker"];
    [Schedule setValue:Schedule_list forKey:@"Schedule"];
    
    
    ////Add the object in the list with the same name /////
    
    
    /// return all list ////
    [listLoadData addObject:Wines];
    [listLoadData addObject:Exhibitor];
    [listLoadData addObject:Sponsor];
    [listLoadData addObject:Speaker];
    [listLoadData addObject:Schedule];
    /// return all list ////
    
    ///Array
    ///>>>>>Diccionary with the name of the object, for example Wine
    ///>>>>>>>>>>>>>>>Array with all object
    ///>>>>>>>>>>>>>>>>>>>> Object (wine)
    
}

-(void) createExhibitor {
    
    Exhibitor_list = [[ NSMutableArray alloc]init];
    
    CSVParser * parser = [CSVParser new];
    NSString *csvFilePath = [[NSBundle mainBundle] pathForResource:@"Exhibitor-Tabla 1" ofType:@"csv"];
    [parser openFile:csvFilePath];
    NSArray *csvContentArray = [parser parseFile];
    //Array 0 titles
    NSArray * titles = [csvContentArray objectAtIndex:0];
    
    for (int i=1; i<csvContentArray.count; i++){
        Exhibitor_object = [[NSMutableDictionary alloc]init];
        [Exhibitor_object setValue:[[csvContentArray objectAtIndex:i] objectAtIndex:0]forKey:[titles objectAtIndex:0]];
        [Exhibitor_object setValue:[[csvContentArray objectAtIndex:i] objectAtIndex:1]forKey:[titles objectAtIndex:1]];
        [Exhibitor_object setValue:[[csvContentArray objectAtIndex:i] objectAtIndex:2]forKey:[titles objectAtIndex:2]];
        [Exhibitor_object setValue:[[csvContentArray objectAtIndex:i]objectAtIndex:3]forKey:[titles objectAtIndex:3]];
        [Exhibitor_object setValue:[[csvContentArray objectAtIndex:i]objectAtIndex:4]forKey:[titles objectAtIndex:4]];
        [Exhibitor_object setValue:[[csvContentArray objectAtIndex:i]objectAtIndex:5]forKey:[titles objectAtIndex:5]];
        [Exhibitor_list addObject:Exhibitor_object];
    
    [parser closeFile];
    }
}

@end
