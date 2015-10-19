#import <libcolorpicker.h>
#define TweakPreferencePath @"/User/Library/Preferences/com.wizages.labelnotify.plist"

NSMutableDictionary *prefs;

NSString *numberNotify;
BOOL enabled = true;
BOOL enabledText = true;
BOOL enabledFill = true;
BOOL enabledBadges = false;
BOOL hideLabels = false;
NSString *colorTextString;
NSString *colorFillString;
NSString *defaultLabel;

@interface SBIcon : NSObject
- (id)badgeNumberOrString;
- (BOOL)isFolderIcon;
-(id)applicationBundleID;
@end

@interface SBIconView : UIView
@property (retain, nonatomic) SBIcon *icon;
-(void)_updateLabelAccessoryView;
-(void)_updateLabel;
-(void)setLabelHidden:(BOOL)arg1;
- (BOOL)doesHaveBadge;
@end

@interface SBFolderIconView : SBIconView
@property (retain, nonatomic) SBIcon *icon;
- (BOOL)folderHasBadge;
- (BOOL)folderBadge;
@end

%hook SBIconLabelImageParameters

- (NSString *) text {
	if (numberNotify != nil && enabled)
		return numberNotify;
	else if (hideLabels && enabled)
		return %orig;
	else
		return %orig;
}
-(UIColor *)textColor{
	if (numberNotify != nil && enabled && enabledText){
		return LCPParseColorString(colorTextString, @"#ffffff");
	}
	else
		return %orig;
}

-(UIColor *)focusHighlightColor{
	if (numberNotify != nil && enabled && enabledFill){
		return LCPParseColorString(colorFillString, @"#8b8b8b");
	}
	else
		return %orig;
}

-(BOOL)colorspaceIsGrayscale{
	return false;
}

/*
TODO Add custom fonts!
-(UIFont *)font {
	if (numberNotify != nil && enabled)
		return [UIFont fontWithName:@"Verdana" size:13];
	else
		return %orig;
}
*/
-(CGSize)maxSize {
	CGSize size = %orig;
	if ( enabled && numberNotify) {
		
		///CGSize newsize = CGSizeMake(150.0f, size.height);
		//HBLogDebug(@"width = %f", newsize.width);
		return size;
	}
	else
		return size;

}

%end

@interface SBIconBadgeView : UIView
@end

%hook SBIconBadgeView

-(void) layoutSubviews {
	%orig;
	if (enabled && !enabledBadges){
		self.hidden = YES;
	}
	else {
		self.hidden = NO;
	}
}

%end

%hook SBIconView


-(void)_updateLabel {
	if (enabled && [self doesHaveBadge] && hideLabels)
	{
		MSHookIvar<UIView *>(self, "_labelView").hidden = false;
	}
	else if (enabled && hideLabels)
	{
		MSHookIvar<UIView *>(self, "_labelView").hidden = true;
	}
	%orig;
	numberNotify = nil;
}

%new
- (BOOL)doesHaveBadge{
	if (enabled){
	if(![self isKindOfClass:[%c(SBIconView) class]]){
		numberNotify = nil;
		return NO;
	}

	id badge = [self.icon badgeNumberOrString];

	if([badge isKindOfClass:[NSNumber class]])
	{
		NSString *labelbundle = [NSString stringWithFormat:@"Label-%@", [self.icon applicationBundleID]];
		NSString *customLabel = [prefs objectForKey:labelbundle];
		if (customLabel && [badge intValue] > 1)
		{
			numberNotify = [NSString stringWithFormat:@"%@ %@s", [badge stringValue], customLabel];
		}
		else if (customLabel)
		{
			numberNotify = [NSString stringWithFormat:@"%@ %@", [badge stringValue], customLabel];
		}
		else if (defaultLabel){
			numberNotify = [NSString stringWithFormat:@"%@ %@", [badge stringValue], defaultLabel];
		}
		else if (defaultLabel && [badge intValue] > 1){
			numberNotify = [NSString stringWithFormat:@"%@ %@s", [badge stringValue], defaultLabel];
		}
		else if ([badge intValue] > 1)
		{
			numberNotify = [NSString stringWithFormat:@"%@ Badges", [badge stringValue]];
		}
		else
		{
			numberNotify = [NSString stringWithFormat:@"%@ Badge", [badge stringValue]];
		}
		return YES;
	}
	else if ([badge isKindOfClass:[NSString class]])
	{
		if ([badge length] != 0)
		{
			NSString *labelbundle = [NSString stringWithFormat:@"Label-%@", [self.icon applicationBundleID]];
			NSString *customLabel = [prefs objectForKey:labelbundle];
			if (customLabel && [badge intValue] > 1)
			{
				numberNotify = [NSString stringWithFormat:@"%@ %@s", badge, customLabel];
			}
			else if (customLabel)
			{
				numberNotify = [NSString stringWithFormat:@"%@ %@", badge, customLabel];
			}
			else if (defaultLabel){
				numberNotify = [NSString stringWithFormat:@"%@ %@", badge, defaultLabel];
			}
			else if (defaultLabel && [badge intValue] > 1){
				numberNotify = [NSString stringWithFormat:@"%@ %@s", badge, defaultLabel];
			}
			else if ([badge intValue] > 1)
			{
				numberNotify = [NSString stringWithFormat:@"%@ Badges", badge];
			}
			else {
				numberNotify = [NSString stringWithFormat:@"%@ Badge", badge];
			}
			return YES;
		}
		else{
			numberNotify = nil;
			return NO;
		}
	}
	else{
		numberNotify = nil;
		return NO;
	}
	}
	else{
		return NO;
	}
}

%end


static void loadLabelNotifyPrefs()
{
	[prefs release];
	prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:TweakPreferencePath];
    if(prefs)
    {
        enabled =  ( [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] :enabled );
        enabledText = ( [prefs objectForKey:@"enabled_text"] ? [[prefs objectForKey:@"enabled_text"] boolValue] : enabledText);
        enabledFill = ( [prefs objectForKey:@"enabled_fill"] ? [[prefs objectForKey:@"enabled_fill"] boolValue] : enabledFill);
        enabledBadges = ( [prefs objectForKey:@"enabled_badges"] ? [[prefs objectForKey:@"enabled_badges"] boolValue] : enabledBadges);
        hideLabels = ( [prefs objectForKey:@"hide_labels"] ? [[prefs objectForKey:@"hide_labels"] boolValue] : hideLabels);
        colorTextString = [prefs objectForKey:@"textColor"];
        colorFillString = [prefs objectForKey:@"fillColor"];
        defaultLabel = [prefs objectForKey:@"default_label"];
    }
    
}

%ctor 
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadLabelNotifyPrefs, CFSTR("com.wizages.labelnotify/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadLabelNotifyPrefs();
}