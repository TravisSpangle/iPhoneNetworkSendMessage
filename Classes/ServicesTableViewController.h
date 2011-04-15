//
//  ServicesTableViewController.h
//  iPhoneClient
//
//  Created by 23 on 3/20/10.
//  Copyright 2010 RogueSheep. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ServicesTableViewController : UITableViewController
{
    NSMutableArray*			services_;	
}

@property (nonatomic, readonly) NSMutableArray* services;


@end
