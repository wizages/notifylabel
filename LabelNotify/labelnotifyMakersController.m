#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import "SKPersonCell.h"

@interface labelnotifyMakersController : PSListController

@end

@implementation labelnotifyMakersController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Makers" target:self] retain];
	}

	return _specifiers;
}

-(void)loadView {
	[super loadView];
}

-(void) openTwitterDev{
	NSString *userName = @"Wizages";
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:userName]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:userName]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:userName]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:userName]]];
	else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:userName]]];
}

-(void) openTwitterCon{
	NSString *userName = @"iBuzzeh";
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:userName]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:userName]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:userName]]];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:userName]]];
	else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:userName]]];
}

@end

@interface DevPersonCell : SKPersonCell
@end
@implementation  DevPersonCell
-(NSString*)personDescription { return @"Developer"; }
-(NSString*)name { return @"Wizages"; }
-(NSString*)twitterHandle { return @"Wizages"; }
-(NSString*)imageName { return @"Icons/Wizages.png"; }
@end

@interface ConceptPersonCell : SKPersonCell
@end
@implementation  ConceptPersonCell
-(NSString*)personDescription { return @"Concept Artist & Logo Maker"; }
-(NSString*)name { return @"Buzzeh"; }
-(NSString*)twitterHandle { return @"iBuzzeh"; }
-(NSString*)imageName { return @"Icons/Buzzeh.png"; }
@end