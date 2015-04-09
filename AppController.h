//
//  AppController.h
//  myOpenApps
//
//  Created by Ricky Nelson on 12/6/07.
//  Copyright 2007 Lark Software, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
    IBOutlet NSWindow       *_theWindow;
	IBOutlet NSTableView	*_tblProcView;
	NSMutableArray			*_processes;
	NSWorkspace				*_myWorkSpace;
}

@property (retain,readwrite) NSMutableArray *processes;
@property (retain,readwrite) NSWorkspace *myWorkSpace;

- (void) handleNewApplication:(NSNotification *)app;
- (void) handleTerminatedApplication:(NSNotification *)theApplication;
@end
