//
//  searchVC.m
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 21/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import "searchVC.h"
#import "SpeakersVC.h"
#import "exhibitorsVC.h"
#import "SponsorsVC.h"


@interface searchVC ()

@end

@implementation searchVC
////////////////////////////SINGLETON//////////////////////////////////

+(searchVC *) getInstance{ // Singleton activitiesViewController
    static  searchVC *inst = nil;
    @synchronized(self){
        if (!inst) {
            inst = [[self alloc] init];
            
        }
    }
    return inst;
}
//////////////////////////////////////////////////////////////////////
@synthesize searchList,searchResult,tableViewSearch,searchBar;

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
    [self loadSearchList];
    [searchBar becomeFirstResponder];
   
}

-(void) loadSearchList {
    exhibitorsVC * exhibitors = [exhibitorsVC getInstance];
    SpeakersVC * speakers = [SpeakersVC getInstance];
    SponsorsVC * sponsors = [SponsorsVC getInstance];
    
    
    searchList = [[NSMutableArray alloc]init];
    for (id obj in exhibitors.listExhibitors) {
        [obj setValue:@"Exhibitors" forKey:@"class"];
        [searchList addObject:[obj valueForKeyPath:@"Exhibitor Name"]];
    }
    for (id obj in speakers.listSpeakers) {
        [obj setValue:@"Speakers" forKey:@"class"];
        [searchList addObject:[obj valueForKeyPath:@"Speaker full name"]];
    }
    for (id obj in sponsors.listSponsors) {
        [obj setValue:@"Sponsors" forKey:@"class"];
        [searchList addObject:[obj valueForKeyPath:@"Sponsor Name"]];
    }
}

-(NSMutableDictionary *) searchObject:(NSString*) name {
    exhibitorsVC * exhibitors = [exhibitorsVC getInstance];
    SpeakersVC * speakers = [SpeakersVC getInstance];
    SponsorsVC * sponsors = [SponsorsVC getInstance];
    NSMutableDictionary * result = [[NSMutableDictionary alloc]init];
    
    int indexObject=0;
    
    
    searchList = [[NSMutableArray alloc]init];
    for (id obj in exhibitors.listExhibitors) {
        if ([[obj valueForKeyPath:@"Exhibitor Name"] isEqualToString:name]) {
            [result setValue:[NSString stringWithFormat:@"%d",indexObject] forKeyPath:@"index"];
            [result setValue:[obj valueForKeyPath:@"class"] forKeyPath:@"class"];
            
           
            return result;
        }
        else{
            indexObject = indexObject + 1;
        }
        
    }
      indexObject=0;
    for (id obj in speakers.listSpeakers) {
        if ([[obj valueForKeyPath:@"Speaker full name"] isEqualToString:name]) {
            [result setValue:[NSString stringWithFormat:@"%d",indexObject] forKeyPath:@"index"];
            [result setValue:[obj valueForKeyPath:@"class"] forKeyPath:@"class"];
            

            return result;
        }
        else{
            indexObject = indexObject + 1;
        }
    }
      indexObject=0;
    for (id obj in sponsors.listSponsors) {
        if ([[obj valueForKeyPath:@"Sponsor Name"] isEqualToString:name]) {
            [result setValue:[NSString stringWithFormat:@"%d",indexObject] forKeyPath:@"index"];
            [result setValue:[obj valueForKeyPath:@"class"] forKeyPath:@"class"];
            

            return result;
        }
        else{
            indexObject = indexObject + 1;
        }
    }
    
    return nil;
}

-(void) searchThroughData{
    [self loadSearchList];
    self.searchResult = nil;
    NSPredicate * resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains [search] %@",self.searchBar.text];
    self.searchResult =[[self.searchList filteredArrayUsingPredicate:resultPredicate]mutableCopy];
    
}

-(void) searchBar:(UISearchBar *) searchBar textDidChange:(NSString *)searchText{
    [self searchThroughData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableViewSearch) {
        return searchList.count;
    }
    else{
        [self searchThroughData];
        return searchResult.count;
    }
    
    
    // Return the number of rows in the section.
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath        *)indexPath
{
        static NSString *cellIndentifier = @"SearchCell";
         NSString * classObject =[[searchList objectAtIndex:indexPath.row] valueForKey:@"class"];
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
       cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }

            cell.textLabel.text=[searchResult objectAtIndex:indexPath.row] ;
            /////Font and Style//////
            UIFont *font = [UIFont fontWithName:@"Lato-BoldItalic" size:14];
            [cell.textLabel setFont:font];
            /////Font and Style//////
            return cell;
      
  
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    exhibitorsVC * exhibitors = [exhibitorsVC getInstance];
    SpeakersVC * speakers = [SpeakersVC getInstance];
    SponsorsVC * sponsors = [SponsorsVC getInstance];
    
    
    NSMutableDictionary * result = [[NSMutableDictionary alloc]init];
    NSString * name =[searchResult objectAtIndex:indexPath.row];
    
    result = [self searchObject:name];
    
        NSString * classObject =[result valueForKeyPath:@"class"];
        
        
        /////////////EXHIBITOR ///////////////
        if ([classObject isEqualToString:@"Exhibitors"]) {
            
            exhibitors.selectedRow = (int) [[result valueForKeyPath:@"index"]integerValue];
            
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitorsProfile"];
            
            
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [self.view.window.layer addAnimation:transition forKey:nil];
            [self presentViewController:controller animated:NO completion:nil];
            
            
        }
        /////////////EXHIBITOR ///////////////
        
        
        /////////////SPONSOR ///////////////
        if ([classObject isEqualToString:@"Sponsors"]) {
            sponsors.selectedRow = (int) [[result valueForKeyPath:@"index"]integerValue];
            
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SponsorsProfile"];
            
            
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [self.view.window.layer addAnimation:transition forKey:nil];
            [self presentViewController:controller animated:NO completion:nil];
            
            
        }
        /////////////SPONSOR ///////////////
        
        /////////////SPEAKERS ///////////////
        if ([classObject isEqualToString:@"Speakers"]) {
            speakers.selectedRow = (int) [[result valueForKeyPath:@"index"]integerValue];;
            
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SpeakersProfile"];
            
            
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [self.view.window.layer addAnimation:transition forKey:nil];
            [self presentViewController:controller animated:NO completion:nil];
            
        }
        /////////////SPEAKERS ///////////////
        
    self.searchBar.text = @""; // search clean
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


@end
