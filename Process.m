//
//  Process.m
//  myOpenApps
//
//  Created by Ricky Nelson on 12/6/07.
//  Copyright 2007 Lark Software, LLC. All rights reserved.
//

#import "Process.h"


@implementation Process
@dynamic pname;
@synthesize procInfo=_procInfo;

- (void) dealloc
{
	[_procInfo release];
	[super dealloc];
}

- (NSString *)pname
{
	if (_procInfo)
	{
        return _procInfo.localizedName;
	}
	return @"";
}

@end
