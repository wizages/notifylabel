#import "NotifyManager.h"
#import <libcolorpicker.h>

static NSString *const kNMEnabledKey = @"enabled";
static NSString *const kNMETextKey = @"enabled_text";
static NSString *const kNMEFillKey = @"enabled_fill";
static NSString *const kNMEBadgeKey = @"enabled_badges";
static NSString *const kNMELabelKey = @"hide_labels";
static NSString *const kNMDLabelKey = @"default_label";
static NSString *const kNMEPluralKey = @"enable_plurlizer";

@implementation NotifyManager {
	HBPreferences *_preferences;
}

+ (instancetype)sharedInstance {
	static NotifyManager *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		_preferences = [[HBPreferences alloc] initWithIdentifier:@"com.wizages.labelnotify"];
		//BOOL preferences
		[_preferences registerBool:&_enabled default:YES forKey:kNMEnabledKey];
		[_preferences registerBool:&_enableText default:YES forKey:kNMETextKey];
		[_preferences registerBool:&_enabledFill default:YES forKey:kNMEFillKey];
		[_preferences registerBool:&_enabledBadges default:NO forKey:kNMEBadgeKey];
		[_preferences registerBool:&_enabledPlural default:YES forKey:kNMEPluralKey];
		[_preferences registerBool:&_hideLabels default:NO forKey:kNMELabelKey];

		//NSString preferences
		[_preferences registerObject:&_defaultLabel default:@"Badge" forKey:kNMDLabelKey];
	}
	return self;
}

- (UIColor *)colorForPreference:(NSString *)string fallback:(NSString *)fallback {

	NSString *potentialIndividualTint = _preferences[string];
	if (potentialIndividualTint) {
		return LCPParseColorString(potentialIndividualTint, @"#000000");
	}
	return LCPParseColorString(fallback, @"#000000");
}

-(BOOL)customLabelIsAvailable:(NSString *)bundleID
{

	return (BOOL)_preferences[bundleID];
}

-(NSString *)customLabel:(NSString *)string{
	return _preferences[[NSString stringWithFormat:@"Label-%@", string]];
}

#pragma mark - Memory management

- (void)dealloc {
	[_preferences release];

	[super dealloc];
}

@end