#import <libcolorpicker.h>
#import <Applist/Applist.h>
#import "headers.h"
#import "NotifyManager.h"


%hook SBIconLabelImageParameters

-(UIColor *)textColor{
		if (numberNotify != nil && [NotifyManager sharedInstance].enabled && [[NotifyManager sharedInstance] customLabelIsAvailable:[NSString stringWithFormat:@"textText_enabled-%@", bundleID]])
		{
			return [[NotifyManager sharedInstance] colorForPreference:[NSString stringWithFormat:@"textText-%@", bundleID] fallback:@"#ffffff"];
		}
		else if (numberNotify != nil && [NotifyManager sharedInstance].enabled && [NotifyManager sharedInstance].enableText){
			return [[NotifyManager sharedInstance] colorForPreference:@"textColor" fallback:@"#ffffff"];
		}
		else if ([NotifyManager sharedInstance].enabled && numberNotify != nil)
		{
			return %orig;
		}
		else if ([NotifyManager sharedInstance].enabled && [NotifyManager sharedInstance].hideLabels)
		{
			UIColor *color = [((UIColor *)%orig) colorWithAlphaComponent:0.0];
			return color;
		}
		else 
			return %orig;
}

-(UIColor *)focusHighlightColor{
		if (numberNotify != nil && [NotifyManager sharedInstance].enabled && [[NotifyManager sharedInstance] customLabelIsAvailable:[NSString stringWithFormat:@"textFill_enabled-%@", bundleID]])
		{
			return [[NotifyManager sharedInstance] colorForPreference:[NSString stringWithFormat:@"textFill-%@", bundleID] fallback:@"#8b8b8b"];
		}
		else if (numberNotify != nil && [NotifyManager sharedInstance].enabled && [NotifyManager sharedInstance].enabledFill){
			return [[NotifyManager sharedInstance] colorForPreference:@"fillColor" fallback:@"#8b8b8b"];
		}
		else
			return %orig;
}

-(BOOL)colorspaceIsGrayscale{
	return false;
}
%end


%hook SBLeafIcon

- (id)displayNameForLocation:(int)arg1{
	if ([NotifyManager sharedInstance].enabled && [self doesHaveBadge] && [NotifyManager sharedInstance].hideLabels)
	{
		return numberNotify;
	}
	else if ([NotifyManager sharedInstance].enabled && [self doesHaveBadge])
	{
		return numberNotify;
	}
	else if ([NotifyManager sharedInstance].enabled && [NotifyManager sharedInstance].hideLabels)
	{
		return %orig;
	}
	else {
		return %orig;
	}
}

%new
- (BOOL)doesHaveBadge{
	if ([NotifyManager sharedInstance].enabled){
	bundleID = [self applicationBundleID];

	id badge = [self badgeNumberOrString];


	if([badge isKindOfClass:[NSNumber class]])
	{
		NSString *customLabel = [[NotifyManager sharedInstance] customLabel:[self applicationBundleID]];
		if (customLabel && [badge intValue] > 1 && ![customLabel isEqual:@""] && [NotifyManager sharedInstance].enabledPlural)
		{
			numberNotify = [NSString stringWithFormat:@"%@ %@s", [badge stringValue], customLabel];
		}
		else if (customLabel && ![customLabel isEqual:@""] && [badge intValue] > 0)
		{
			numberNotify = [NSString stringWithFormat:@"%@ %@", [badge stringValue], customLabel];
		}
		else if ([[NotifyManager sharedInstance].defaultLabel isEqual:@""] && [badge intValue] > 0){
			numberNotify = [NSString stringWithFormat:@"%@", [badge stringValue]];
		}
		else if ([NotifyManager sharedInstance].defaultLabel && [badge intValue] > 1 && [NotifyManager sharedInstance].enabledPlural){
			numberNotify = [NSString stringWithFormat:@"%@ %@s", [badge stringValue], [NotifyManager sharedInstance].defaultLabel];
		}
		else if ([NotifyManager sharedInstance].defaultLabel && [badge intValue] > 0){
			numberNotify = [NSString stringWithFormat:@"%@ %@", [badge stringValue], [NotifyManager sharedInstance].defaultLabel];
		}
		else if ([badge intValue] > 1 && [NotifyManager sharedInstance].enabledPlural)
		{
			numberNotify = [NSString stringWithFormat:@"%@ Badges", [badge stringValue]];
		}
		else if([badge intValue] > 0)
		{
			numberNotify = [NSString stringWithFormat:@"%@ Badge", [badge stringValue]];
		}
		return YES;
	}
	else if ([badge isKindOfClass:[NSString class]])
	{
		if ([badge length] != 0)
		{
			NSString *customLabel = [[NotifyManager sharedInstance] customLabel:[self applicationBundleID]];
			if (customLabel && [badge intValue] > 1 && ![customLabel isEqual:@""] && [NotifyManager sharedInstance].enabledPlural)
			{
				numberNotify = [NSString stringWithFormat:@"%@ %@s", badge, customLabel];
			}
			else if (customLabel && ![customLabel isEqual:@""] && [badge intValue] > 0)
			{
				numberNotify = [NSString stringWithFormat:@"%@ %@", badge, customLabel];
			}
			else if ([[NotifyManager sharedInstance].defaultLabel isEqual:@""] && [badge intValue] > 0){
				numberNotify = [NSString stringWithFormat:@"%@", badge];
			}
			else if ([NotifyManager sharedInstance].defaultLabel && [badge intValue] > 1 && [NotifyManager sharedInstance].enabledPlural){
				numberNotify = [NSString stringWithFormat:@"%@ %@s", badge, [NotifyManager sharedInstance].defaultLabel];
			}
			else if ([NotifyManager sharedInstance].defaultLabel && [badge intValue] > 0){
				numberNotify = [NSString stringWithFormat:@"%@ %@", badge, [NotifyManager sharedInstance].defaultLabel];
			}
			else if ([badge intValue] > 1 && [NotifyManager sharedInstance].enabledPlural )
			{
				numberNotify = [NSString stringWithFormat:@"%@ Badges", badge];
			}
			else if ([badge intValue] > 0){
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
		numberNotify = nil;
		return NO;
	}
}

%end


%hook SBFolderIcon

- (id)displayNameForLocation:(int)arg1 {
		if ([NotifyManager sharedInstance].enabled && [self doesHaveBadge] && [NotifyManager sharedInstance].hideLabels)
	{
		return numberNotify;
	}
	else if ([NotifyManager sharedInstance].enabled && [self doesHaveBadge])
	{
		return numberNotify;
	}
	else if ([NotifyManager sharedInstance].enabled && [NotifyManager sharedInstance].hideLabels)
	{
		return %orig;
	}
	else {
		return %orig;
	}
}

%new
- (BOOL)doesHaveBadge{
	if ([NotifyManager sharedInstance].enabled){
	bundleID = [self applicationBundleID];

	id badge = [self badgeNumberOrString];


	if([badge isKindOfClass:[NSNumber class]])
	{
		NSString *customLabel = [[NotifyManager sharedInstance] customLabel:[self applicationBundleID]];
		if (customLabel && [badge intValue] > 1 && ![customLabel isEqual:@""] && [NotifyManager sharedInstance].enabledPlural)
		{
			numberNotify = [NSString stringWithFormat:@"%@ %@s", [badge stringValue], customLabel];
		}
		else if (customLabel && ![customLabel isEqual:@""])
		{
			numberNotify = [NSString stringWithFormat:@"%@ %@", [badge stringValue], customLabel];
		}
		else if ([[NotifyManager sharedInstance].defaultLabel isEqual:@""]){
			numberNotify = [NSString stringWithFormat:@"%@", [badge stringValue]];
		}
		else if ([NotifyManager sharedInstance].defaultLabel && [badge intValue] > 1 && [NotifyManager sharedInstance].enabledPlural){
			numberNotify = [NSString stringWithFormat:@"%@ %@s", [badge stringValue], [NotifyManager sharedInstance].defaultLabel];
		}
		else if ([NotifyManager sharedInstance].defaultLabel){
			numberNotify = [NSString stringWithFormat:@"%@ %@", [badge stringValue], [NotifyManager sharedInstance].defaultLabel];
		}
		else if ([badge intValue] > 1 && [NotifyManager sharedInstance].enabledPlural)
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
			NSString *customLabel = [[NotifyManager sharedInstance] customLabel:[self applicationBundleID]];
			if (customLabel && [badge intValue] > 1 && ![customLabel isEqual:@""] && [NotifyManager sharedInstance].enabledPlural)
			{
				numberNotify = [NSString stringWithFormat:@"%@ %@s", badge, customLabel];
			}
			else if (customLabel && ![customLabel isEqual:@""])
			{
				numberNotify = [NSString stringWithFormat:@"%@ %@", badge, customLabel];
			}
			else if ([[NotifyManager sharedInstance].defaultLabel isEqual:@""]){
				numberNotify = [NSString stringWithFormat:@"%@", badge];
			}
			else if ([NotifyManager sharedInstance].defaultLabel && [badge intValue] > 1 && [NotifyManager sharedInstance].enabledPlural){
				numberNotify = [NSString stringWithFormat:@"%@ %@s", badge, [NotifyManager sharedInstance].defaultLabel];
			}
			else if ([NotifyManager sharedInstance].defaultLabel){
				numberNotify = [NSString stringWithFormat:@"%@ %@", badge, [NotifyManager sharedInstance].defaultLabel];
			}
			else if ([badge intValue] > 1 && [NotifyManager sharedInstance].enabledPlural)
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
		numberNotify = nil;
		return NO;
	}
}


%end

%hook SBIconBadgeView

-(void) layoutSubviews {
	%orig;

	if ([NotifyManager sharedInstance].enabled && ![NotifyManager sharedInstance].enabledBadges){
		self.hidden = YES;
	}
	else if ([NotifyManager sharedInstance].enabled) {
		self.hidden = NO;
	}
}

%end
/*
%hook SBIconLabelView

+(void) updateIconLabelView:(SBIconLabelView *)arg1 withSettings:(_UILegibilitySettings *) arg2 imageParameters:(SBIconLabelImageParameters *) arg3 {
	%log;
	%orig;
}

%end
*/
%hook SBIconView
-(void)_updateLabel {
	%orig;
	MSHookIvar<UIView *>(self, "_labelView").hidden = NO;
}

-(void)layoutSubviews {
	%orig;
	MSHookIvar<UIView *>(self, "_labelView").hidden = NO;
}

-(void)
%end;
/*
%new
- (BOOL)doesHaveBadge{
	if (enabled){
	if(![self isKindOfClass:[%c(SBIconView) class]]){
		numberNotify = nil;
		HBLogDebug(@"Hmmm not a SBIconView ehh?");
		return NO;
	}
	bundleID = [self.icon applicationBundleID];

	id badge = [self.icon badgeNumberOrString];


	if([badge isKindOfClass:[NSNumber class]])
	{
		NSString *labelbundle = [NSString stringWithFormat:@"Label-%@", [self.icon applicationBundleID]];

		NSString *customLabel = [prefs objectForKey:labelbundle];
		if (customLabel && [badge intValue] > 1 && ![customLabel isEqual:@""] && enabledPlural)
		{
			numberNotify = [NSString stringWithFormat:@"%@ %@s", [badge stringValue], customLabel];
		}
		else if (customLabel && ![customLabel isEqual:@""])
		{
			numberNotify = [NSString stringWithFormat:@"%@ %@", [badge stringValue], customLabel];
		}
		else if ([defaultLabel isEqual:@""]){
			numberNotify = [NSString stringWithFormat:@"%@", [badge stringValue]];
		}
		else if (defaultLabel && [badge intValue] > 1 && enabledPlural){
			numberNotify = [NSString stringWithFormat:@"%@ %@s", [badge stringValue], defaultLabel];
		}
		else if (defaultLabel){
			numberNotify = [NSString stringWithFormat:@"%@ %@", [badge stringValue], defaultLabel];
		}
		else if ([badge intValue] > 1 && enabledPlural)
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
			if (customLabel && [badge intValue] > 1 && ![customLabel isEqual:@""] && enabledPlural)
			{
				numberNotify = [NSString stringWithFormat:@"%@ %@s", badge, customLabel];
			}
			else if (customLabel && ![customLabel isEqual:@""])
			{
				numberNotify = [NSString stringWithFormat:@"%@ %@", badge, customLabel];
			}
			else if ([defaultLabel isEqual:@""]){
				numberNotify = [NSString stringWithFormat:@"%@", badge];
			}
			else if (defaultLabel && [badge intValue] > 1 && enabledPlural){
				numberNotify = [NSString stringWithFormat:@"%@ %@s", badge, defaultLabel];
			}
			else if (defaultLabel){
				numberNotify = [NSString stringWithFormat:@"%@ %@", badge, defaultLabel];
			}
			else if ([badge intValue] > 1 && enabledPlural)
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
		numberNotify = nil;
		return NO;
	}
}
%end
*/