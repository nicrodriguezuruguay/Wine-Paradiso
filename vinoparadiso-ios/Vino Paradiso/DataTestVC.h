//
//  cargarDatosViewController.h
//  Vino Paradiso
//
//  Created by Nicolas Rodriguez on 15/06/14.
//  Copyright (c) 2014 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataTestVC : UIViewController


////////////////////////////SINGLETON//////////////////////////////////
+(DataTestVC *) getInstance;
//////////////////////////////////////////////////////////////////////

@property (nonatomic,strong) NSMutableArray * listLoadData;
@property (nonatomic,strong)   NSMutableArray * Exhibitor_list;
@property (nonatomic,strong) NSMutableDictionary * Exhibitor_object;



@end
