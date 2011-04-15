//
//  iPhoneClientAppDelegate.h
//  iPhoneClient
//	HW3_1
//
//  Copyright 2010 Chris Parrish

#import <UIKit/UIKit.h>

@interface iPhoneClientAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

