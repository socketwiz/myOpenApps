//
//  Process.h
//  myOpenApps
//
//  Created by Ricky Nelson on 12/6/07.
//  Copyright 2007 Lark Software, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Process : NSObject {
	NSRunningApplication	*_procInfo;
}

@property (readonly) NSString *pname;
@property (retain,readwrite) NSRunningApplication *procInfo;

@end
