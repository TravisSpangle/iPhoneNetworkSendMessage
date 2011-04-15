//
//  ServicesTableViewController.m
//  iPhoneClient
//
//  Created by 23 on 3/20/10.
//  Copyright 2010 RogueSheep. All rights reserved.
//

#import "ServicesTableViewController.h"

#include <sys/socket.h>
#include <netdb.h>

@implementation ServicesTableViewController

@synthesize services = services_;

#pragma mark -
#pragma mark Initialization

- (void) viewDidLoad
{
    services_		= [[NSMutableArray array] retain];	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [services_ count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc
{
	[services_ release];
    [super dealloc];
}


@end

