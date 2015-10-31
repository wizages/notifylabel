#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import <Applist/Applist.h>
#import <libcolorpicker.h>
#import <QuartzCore/QuartzCore.h>
#include "Generic.h"

NSString *AppID;
@interface labelnotifyLabelController : PSListController
{
	NSString* _AppID;
}
@property (nonatomic, retain) NSString *AppID;
@end

@implementation labelnotifyLabelController

- (NSArray *)specifiers {
	/*
	NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
	[defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:LabelStuff]];
	NSMutableArray *array = [NSMutableArray array];
	[array addObjectsFromArray:[defaults objectForKey: @"items"]];
	
	NSMutableDictionary *defaults2 = [NSMutableDictionary dictionary];
	[defaults2 addEntriesFromDictionary: [[defaults objectForKey: @"items"] objectAtIndex:4]];

	NSMutableDictionary *defaults3 = [NSMutableDictionary dictionary];
	[defaults3 addEntriesFromDictionary: [defaults2 objectForKey: @"libcolorpicker"]];

	NSMutableDictionary *defaults4 = [NSMutableDictionary dictionary];
	[defaults4 addEntriesFromDictionary: [[defaults objectForKey: @"items"] objectAtIndex:7]];

	NSMutableDictionary *defaults5 = [NSMutableDictionary dictionary];
	[defaults5 addEntriesFromDictionary: [defaults4 objectForKey: @"libcolorpicker"]];

	[defaults3 setObject: [NSString stringWithFormat:@"customfill-%@", self.AppID] forKey: @"key"];
	[defaults5 setObject: [NSString stringWithFormat:@"customtext-%@", self.AppID] forKey: @"key"];
	[defaults2 setObject:defaults3 forKey:@"libcolorpicker"];
	[defaults4 setObject:defaults5 forKey:@"libcolorpicker"];
	[array replaceObjectAtIndex:4 withObject:defaults2];
	[array replaceObjectAtIndex:7 withObject:defaults4];
	[defaults setObject:array forKey:@"items"];
	[defaults writeToFile:LabelStuffCustom atomically:YES];
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Label-custom" target:self] retain];
	}
	//HBLogDebug(@"%@",[[_specifiers objectAtIndex:8] class]);
	return _specifiers;
	*/
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Label" target:self] retain];
	}
	//HBLogDebug(@"%@",[[_specifiers objectAtIndex:8] class]);
	return _specifiers;
	/*
	return blah;
	
	return @[
             @{
                 @"cell": @"PSGroupCell",
                 @"label": @"Custom Label Settings"
                 },
             @{
                 @"cell": @"PSEditTextCell",
                 @"default": @"badge",
                 @"defaults": @"com.wizages.labelnotify",
                 @"key": @"test",
                 @"autoCaps": @"words",
                 @"PostNotification": @"com.wizages.labelnotify/settingschanged",
                 @"placeholder": @"test"
                 }
             ];
             
	return nil;
	*/
}

-(void)loadView {
	[super loadView];
}

//NSString *colorFillString = [prefs objectForKey:@"textColor"];

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

-(void)viewDidLoad {
	[super viewDidLoad];
	HBLogDebug(@"%@", NSStringFromCGSize(self.view.bounds.size));
	[self setupHeader];
}

-(void) setupHeader{
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:TweakPreferencePath];
	BOOL enabledText = true;
	enabledText = ( [prefs objectForKey:@"enabled_text"] ? [[prefs objectForKey:@"enabled_text"] boolValue] : enabledText);
    BOOL enabledFill = true;
    enabledFill = ( [prefs objectForKey:@"enabled_fill"] ? [[prefs objectForKey:@"enabled_fill"] boolValue] : enabledFill);
    NSString *label = [prefs objectForKey:[NSString stringWithFormat:@"Label-%@", self.AppID]];
    HBLogDebug(@"%@", label);
    if (!label)
    {
    	label = [prefs objectForKey:@"default_label"];
    	if (!label)
    		label = @"Badge";
    }
	ALApplicationList *al = [ALApplicationList sharedApplicationList];
	NSString *appName = [al valueForKey:@"displayName" forDisplayIdentifier:self.AppID];
	((UINavigationItem*)self.navigationItem).title = appName;
 	UIView *header = nil;
 	if (self.view.bounds.size.width == 0.0f)
 		header = [[UIView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 100)];
	else
    	header = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, 100)];
    UIImage *headerImage;
    headerImage = [al iconOfSize:ALApplicationIconSizeLarge forDisplayIdentifier:self.AppID];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:headerImage];
    //header.frame = (CGRect){ header.frame.origin, headerImage.size };
    //imageView.frame = header.frame;
    imageView.frame = CGRectMake(0, header.frame.origin.y, 75, 75);
    if (self.view.bounds.size.width == 0.0f && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
 		imageView.center = CGPointMake(([UIScreen mainScreen].bounds.size.width*.59)/2, header.bounds.size.height/2);
    }
    else if (self.view.bounds.size.width == 0.0f)
    	imageView.center = CGPointMake(([UIScreen mainScreen].bounds.size.width)/2, header.bounds.size.height/2);
	else{
    	imageView.center = CGPointMake(self.view.bounds.size.width/2, header.bounds.size.height/2);
	}

    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [header addSubview:imageView];
    CGRect rect = CGRectMake((header.frame.size.width/2)-75, imageView.frame.origin.y + imageView.frame.size.height, 50, 20);
    header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, header.frame.size.height);         
    UILabel *subText = [[UILabel alloc] initWithFrame:rect];
    [subText.layer setCornerRadius:5];
    subText.clipsToBounds=YES;
    subText.text = [NSString stringWithFormat:@"1 %@", label];
    subText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    if (enabledFill)
    	subText.backgroundColor = LCPParseColorString([prefs objectForKey:@"fillColor"], @"#8b8b8b");
    else	
    	subText.backgroundColor = [UIColor clearColor];
    if (enabledText)
    	subText.textColor = LCPParseColorString([prefs objectForKey:@"textColor"], @"#ffffff");
    else
    	subText.textColor = [UIColor whiteColor];
    subText.textAlignment = NSTextAlignmentCenter;
    [subText sizeToFit];
    subText.center = CGPointMake(CGRectGetMidX(imageView.frame), subText.center.y);
    subText.frame = CGRectMake(subText.frame.origin.x - 5, subText.frame.origin.y, subText.frame.size.width + 10, subText.frame.size.height);
	[header addSubview:subText];
	
    [self.table setTableHeaderView:header];
}
/*
- (id)navigationTitle {
	return [[self bundle] localizedStringForKey:[super label] value:[super label] table:nil];
}
*/

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self setupHeader];
}

- (void)setSpecifier:(PSSpecifier *)specifier {
	self.AppID = [specifier propertyForKey:@"label"];
	HBLogDebug(@"%@", self.AppID);
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
	HBLogDebug(@"%@-%@", self.AppID, specifier.properties[@"key"]);
    NSDictionary *TweakSettings = [NSDictionary dictionaryWithContentsOfFile:TweakPreferencePath];
    NSString *appendName = [NSString stringWithFormat:@"%@-%@", specifier.properties[@"key"], self.AppID];
    if (!TweakSettings[appendName]) {
        return specifier.properties[@"default"];
    }
    return TweakSettings[appendName];
}
 
-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	HBLogDebug(@"MEH");
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:TweakPreferencePath]];
    if (specifier.properties[@"key"] == nil)
    {
        HBLogDebug(@"Error : Key is nil show specifier ");
        HBLogDebug(@"%@", specifier);
    }
    HBLogDebug(@"%@-%@", self.AppID,specifier.properties[@"key"]);
    [defaults setObject:value forKey:[NSString stringWithFormat:@"%@-%@", specifier.properties[@"key"], self.AppID]];
    [defaults writeToFile:TweakPreferencePath atomically:YES];
    CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
    if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
    [self setupHeader];
}
-(void)_returnKeyPressed:(id)arg1 {
     [super _returnKeyPressed:arg1];
 
     [self.view endEditing:YES];
}

-(void) generateColors{

}

-(void) swapColors{

}
@end
