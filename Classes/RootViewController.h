//
//  RootViewController.h
//  iPhoneClient
//
//	HW3_1
//
//  Copyright 2010 Chris Parrish

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController<NSNetServiceBrowserDelegate, NSNetServiceDelegate>
{

    NSNetServiceBrowser*	browser_;
	NSMutableArray*			services_;	

}

@property (readwrite, retain) NSNetServiceBrowser *browser_;

@end
