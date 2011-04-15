//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  DesktopServiceAppDelegate.h
//	HW4_1
//
//  Copyright 2010 Chris Parrish
//

#import <UIKit/UIKit.h>

@class ServicesTableViewController;

@interface iPhoneClientViewController : UIViewController
{
    NSNetServiceBrowser*	browser_;
	
	ServicesTableViewController*	servicesTableViewController_;
}

@property (nonatomic, retain) IBOutlet ServicesTableViewController* servicesTableViewController;


- (void) startServiceSearch;
	// starts searching for published services 

@end

