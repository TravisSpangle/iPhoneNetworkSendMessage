//
//  ServiceDetailController.h
//  iPhoneClient
//
//	HW3_1
//
//  Copyright 2010 Chris Parrish

#import <UIKit/UIKit.h>


@interface ServiceDetailController : UIViewController
{
	
	NSNetService*		service_;
	NSOutputStream*		outputStream_;

	
	UILabel*			statusLabel_;
	UITextField*		messageTextView_;

}

@property (nonatomic, retain)			NSNetService*	service;
@property (nonatomic, retain) IBOutlet	UILabel*		statusLabel;
@property (nonatomic, retain) IBOutlet	UITextField*	messageTextView;


- (IBAction)	sendMessage:(id)sender;



@end
