//
//  RootViewController.m
//  iPhoneClient
//
//	HW3_1
//
//  Copyright 2010 Chris Parrish

#import "RootViewController.h"
#import "ServiceDetailController.h"


@implementation RootViewController

@synthesize browser_;

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
	[services_ release];
    [super dealloc];
}


#pragma mark -
#pragma mark NSNetService

// < YOU NEED TO MAKE ALL THESE METHODS DO THE RIGHT THING >



- (void) startServiceSearch
{
	
	NSLog(@"Started browsing for services: %@", browser_);	
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser 
           didFindService:(NSNetService *)aNetService 
               moreComing:(BOOL)moreComing 
{
    NSLog(@"Adding new service - %@", aNetService);

    [services_ addObject:aNetService];
    
    [aNetService setDelegate:self];
    [aNetService resolveWithTimeout:5.0];
    
    if(!moreComing){
        NSLog(@"Reloading table data:\n\t %@", services_);
        [self.tableView reloadData];
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser 
         didRemoveService:(NSNetService *)aNetService 
               moreComing:(BOOL)moreComing 
{
    NSLog(@"Removing service");
	
}

- (void)netServiceWillResolve:(NSNetService *)sender
{
	NSLog(@"RESOLVING net service with name %@ and type %@", [sender name], [sender type]);
}


- (void)netServiceDidResolveAddress:(NSNetService *)sender
{
	NSLog(@"RESOLVED net service with name %@ and type %@", [sender name], [sender type]);
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict
{
	NSLog(@"DID NOT RESOLVE net service with name %@ and type %@", [sender name], [sender type]);
	NSLog(@"Error Dict: %@", [errorDict description]);
	
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    browser_ = [[NSNetServiceBrowser alloc] init]; 

   [[self browser_] setDelegate:self];
    
    [browser_ searchForServicesOfType:@"_uwcelistener._tcp" inDomain:@""];

    services_ = [[NSMutableArray alloc] init];
    //we'll need to release this

}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [services_ count];
    NSLog(@"%s\n\t%d",__PRETTY_FUNCTION__, [services_ count]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSNetService* service = [services_ objectAtIndex:indexPath.row];
	NSArray* addresses = [service addresses];
	
	if ([addresses count] == 0)
	{
		cell.textLabel.text = @"Could not resolve address";
	}
	else
	{
		cell.textLabel.text = [service hostName];
	}
	
	cell.detailTextLabel.text = [service name]; 
	
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSNetService* selectedService = [services_ objectAtIndex:indexPath.row];

	// <ADD SOME CODE HERE : 
	// if the selection was not resolved, try to resolve it again, but don't attempt
	// to bring up the details >
	
    ServiceDetailController* detailController = [[ServiceDetailController alloc] initWithNibName:@"ServiceDetailController" bundle:nil];
	
	detailController.service = selectedService;
    [[self navigationController] pushViewController:detailController animated:YES];
    [detailController release];	
}




@end

