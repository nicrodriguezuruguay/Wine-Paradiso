//
//  searchVC.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 21/8/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchVC : UIViewController<UISearchDisplayDelegate>


////////////////////////////SINGLETON//////////////////////////////////
+(searchVC *) getInstance;
//////////////////////////////////////////////////////////////////////

@property (strong,nonatomic) NSMutableArray * searchList;
@property (nonatomic, strong) NSMutableArray *searchResult;
@property (weak, nonatomic) IBOutlet UITableView *tableViewSearch;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;



-(void) loadSearchList;
- (IBAction)goBackMenu:(id)sender;
@end
