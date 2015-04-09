//
//  AppController.m
//  myOpenApps
//
//  Created by Ricky Nelson on 12/6/07.
//  Copyright 2007 Lark Software, LLC. All rights reserved.
//

#import "AppController.h"
#import "Process.h"


@implementation AppController
@synthesize processes=_processes;
@synthesize myWorkSpace=_myWorkSpace;

- (id) init
{
	self = [super init];
	if (self != nil) {
		_processes = [[NSMutableArray alloc] init];
		_myWorkSpace = [[NSWorkspace alloc] init];
	}
	
	[[_myWorkSpace notificationCenter] addObserver:self
										  selector:@selector(handleNewApplication:) 
											  name:NSWorkspaceDidLaunchApplicationNotification 
											object:nil];
	[[_myWorkSpace notificationCenter] addObserver:self
										  selector:@selector(handleTerminatedApplication:) 
											  name:NSWorkspaceDidTerminateApplicationNotification 
											object:nil];
	[[_myWorkSpace notificationCenter] addObserver:self
										  selector:@selector(handleActiveApplication:) 
											  name:NSWorkspaceSessionDidBecomeActiveNotification 
											object:nil];
	
	for (NSRunningApplication *anApplication in [_myWorkSpace runningApplications])
	{
		Process *aProcess = [[Process alloc] init];
		
        if ([anApplication launchDate] != nil && anApplication.hidden == NO) {
            aProcess.procInfo = anApplication;
            
            [_processes addObject:aProcess];
            [aProcess release];
        }
	}
    
	return self;
}
- (void) dealloc
{
	[_processes release];
	[_myWorkSpace removeObserver:self
					  forKeyPath:NSWorkspaceDidLaunchApplicationNotification];
	[_myWorkSpace removeObserver:self
					  forKeyPath:NSWorkspaceDidTerminateApplicationNotification];
	[_myWorkSpace release];
	[super dealloc];
}

- (void) awakeFromNib
{
	[_tblProcView setAutosaveName:@"procColumns"];
	[_tblProcView setAutosaveTableColumns:YES];
}

/*
 * handleNewApplication
 *	When a new application is launched, add it to the list
 *
 */
- (void) handleNewApplication:(NSNotification *)anApplication
{
	// Make sure the new App is not already in the list
	for (Process *theProcess in _processes)
	{
		NSString *strApp = [[anApplication userInfo] objectForKey:@"NSApplicationName"];
		NSString *strProcess = [theProcess pname];

		if ([strApp localizedCompare:strProcess] == NSOrderedSame) {
			return;
		}
	}

	Process *myProcess = [[Process alloc] init];
	myProcess.procInfo = [[anApplication userInfo] valueForKey:@"NSWorkspaceApplicationKey"];
	
	[_processes addObject:myProcess];
    self.processes = _processes;

	[myProcess release];
}

/*
 * handleTerminatedApplication
 *	When an application terminates, remove it from the list
 *
 */
- (void) handleTerminatedApplication:(NSNotification *)anApplication
{
	for (Process *theProcess in _processes)
	{
		NSString *strApp = [[anApplication userInfo] objectForKey:@"NSApplicationName"];
		NSString *strProcess = [theProcess pname];
		
		if ([strApp localizedCompare:strProcess] == NSOrderedSame) {
			[_processes removeObject:theProcess];
			break;
		}
	}

	[self setProcesses:_processes];
}

- (void) handleActiveApplication:(NSNotification *)anApplication
{
	for (Process *theProcess in _processes)
	{
		NSString *strApp = [[anApplication userInfo] objectForKey:@"NSApplicationName"];
		NSString *strProcess = [theProcess pname];
		
		if ([strApp localizedCompare:strProcess] == NSOrderedSame) {
            //return;
		}
	}
    
	Process *myProcess = [[Process alloc] init];
	myProcess.procInfo = [[anApplication userInfo] valueForKey:@"NSWorkspaceApplicationKey"];
    
	NSLog(@"%@", [myProcess pname]);
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	if ([aNotification object] == _tblProcView)
	{
		NSLog(@"row selected[%@]", [[_processes objectAtIndex:[_tblProcView selectedRow]] pname]);
	}
}

@end
