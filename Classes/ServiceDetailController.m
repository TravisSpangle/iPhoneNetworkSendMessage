//
//  ServiceDetailController.m
//  iPhoneClient
//
//	HW3_1
//
//  Copyright 2010 Chris Parrish

#import "ServiceDetailController.h"


@interface ServiceDetailController ()
- (void) connectToService;
@end

@implementation ServiceDetailController

@synthesize	service = service_;
@synthesize statusLabel = statusLabel_;
@synthesize messageTextView = messageTextView_;


- (void)viewDidLoad
{
    [super viewDidLoad];

	[messageTextView_ becomeFirstResponder];
	messageTextView_.returnKeyType = UIReturnKeySend;
	messageTextView_.enablesReturnKeyAutomatically = YES;
	
	if (service_)
		[self connectToService];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	self.statusLabel = nil;
	self.messageTextView = nil;
	self.service = nil;
	[outputStream_ close];
	[outputStream_ release];
	outputStream_ = nil;
}


- (void)dealloc
{
	[service_ release];
	[outputStream_ close];
	[outputStream_ release];
		
    [super dealloc];
}

#pragma mark - 
#pragma mark Service

- (void) connectToService
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
	// We assume the NSNetService has been resolved at this point
	
	// NSNetService makes it easy for us to connect, we don't have to do any socket management
		
    [service_ getInputStream:NULL outputStream:&outputStream_];
    
	// if we wanted, we could scheudled notifcations or other run loop
	// based reading of the input stream to get messages back from the
	// service we connected to
	
    if ( outputStream_ != nil )
    {
        [outputStream_ open];
        statusLabel_.text = @"Connected to service.";
    }
    else
    {
        statusLabel_.text = @"Could not connect to service";
    }
	
}

#pragma mark -
#pragma mark Actions

- (IBAction)	sendMessage:(id)sender
{
	if ( outputStream_ == nil )
	{
		statusLabel_.text = @"Failed to send message, not connected.";
		return;
	}
		
    NSString* messageText = messageTextView_.text;

    const uint8_t* messageBuffer =(const uint8_t*)[messageText UTF8String];
    NSUInteger length = [messageText
                         lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    [outputStream_ write:messageBuffer maxLength:length];	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self sendMessage:textField];
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}

@end
