//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  DesktopServiceAppDelegate.h
//	HW4_1
//
//  Copyright 2010 Chris Parrish
//
#import "iPhoneClientViewController.h"

#import "ServicesTableViewController.h"

NSString* const			kServiceTypeString		= @"_uwcelistener._tcp.";
NSString* const			kSearchDomain			= @"local.";
	// Bonjour automatically puts everything in the .local domain,
	// ie your mac is something like MyMacSharingName.local


@implementation iPhoneClientViewController

@synthesize servicesTableViewController = servicesTableViewController_;

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}



#pragma mark -
#pragma mark NSNetService

- (void) startServiceSearch
{
    browser_		= [[NSNetServiceBrowser alloc] init];
    [browser_ setDelegate:self];
    [browser_ searchForServicesOfType:kServiceTypeString inDomain:kSearchDomain];
   
	NSLog(@"Started browsing for services: %@", browser_);	
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser 
           didFindService:(NSNetService *)aNetService 
               moreComing:(BOOL)moreComing 
{
    NSLog(@"Adding new service");
    [servicesTableViewController_.services addObject:aNetService];
    [aNetService setDelegate:self];
    [aNetService resolveWithTimeout:5.0];

    if (!moreComing)
	{
        [servicesTableViewController_.tableView reloadData];        
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser 
         didRemoveService:(NSNetService *)aNetService 
               moreComing:(BOOL)moreComing 
{
    NSLog(@"Removing service");
    NSEnumerator *enumerator = [servicesTableViewController_.services objectEnumerator];
    NSNetService *currentNetService;
    while (currentNetService = [enumerator nextObject])
	{
        if ([[currentNetService name] isEqual:[aNetService name]] && 
			[[currentNetService type] isEqual:[aNetService type]] && 
			[[currentNetService domain] isEqual:[aNetService domain]])
		{
            [servicesTableViewController_.services removeObject:currentNetService];
            break;
        }
    }
    if (!moreComing)
	{
        [servicesTableViewController_.tableView reloadData];        
    }
}

- (void)netServiceWillResolve:(NSNetService *)sender
{
	NSLog(@"RESOLVING net service with name %@ and type %@", [sender name], [sender type]);
}


- (void)netServiceDidResolveAddress:(NSNetService *)sender
{
	NSLog(@"RESOLVED net service with name %@ and type %@", [sender name], [sender type]);
	[servicesTableViewController_.tableView reloadData];
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict
{
	NSLog(@"DID NOT RESOLVE net service with name %@ and type %@", [sender name], [sender type]);
	
	NSLog(@"Error Dict:", [errorDict description]);
}


@end
