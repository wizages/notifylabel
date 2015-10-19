#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#include "Generic.h"
#import <libcolorpicker.h>

@interface labelnotifyMiscController : PSListController

@end

@implementation labelnotifyMiscController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Misc" target:self] retain];
	}

	return _specifiers;
}

-(void)loadView {
	[super loadView];
}


@end
