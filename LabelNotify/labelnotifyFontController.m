#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import <AppList/AppList.h>
#include "Generic.h"

@interface labelnotifyLabelController : PSListController

@end

@implementation labelnotifyLabelController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Font" target:self] retain];
	}

	return _specifiers;
}

-(void)loadView {
	[super loadView];
}

@end
