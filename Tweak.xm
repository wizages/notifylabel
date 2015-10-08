NSNumber *test;

@interface SBIcon : NSObject
- (id)badgeNumberOrString;
- (BOOL)isFolderIcon;
@end

@interface SBIconView : UIView
@property (retain, nonatomic) SBIcon *icon;
-(void)_updateLabelAccessoryView;
-(void)_updateLabel;
- (BOOL)doesHaveBadge;
@end

@interface SBFolderIconView : SBIconView
@property (retain, nonatomic) SBIcon *icon;
- (BOOL)folderHasBadge;
- (BOOL)folderBadge;
@end
/*
%hook SBFolderIconView


-(void)_updateLabel {
	HBLogDebug(@"test");
	if([self folderBadge])
	{

		%orig;
	}
	test = nil;
}

%new
- (BOOL)folderBadge{

	id badge = [self.icon badgeNumberOrString];

	HBLogDebug(@"badge: %@", badge);
	if([badge isKindOfClass:[NSNumber class]])
	{
		NSNumber *badge_number = badge;
		test = badge;
		HBLogDebug(@"%@", [badge_number stringValue]);
		//test = @"1";
		return YES;
	}
	else{
		test = nil;
		return NO;
	}
}
%end
*/
%hook SBIconLabelImageParameters

- (NSString *) text {
	if (test != nil){
		NSString *test2 = [NSString stringWithFormat:@"%@ Notifications", [test stringValue]];
		return test2;
	}
	else
		return %orig;
}
-(UIColor *)textColor{
	if (test != nil){
		return [UIColor redColor];
	}
	else
		return %orig;
}

-(UIColor *)focusHighlightColor{
	if (test != nil){
		return [UIColor greenColor];
	}
	else
		return %orig;
}

-(BOOL)colorspaceIsGrayscale{
	return false;
}

%end

@interface SBIconBadgeView : UIView
@end

%hook SBIconBadgeView

-(void) layoutSubviews {
	%orig;
	self.hidden = YES;
}

%end

%hook SBIconView

-(void)_updateLabel {
	if([self doesHaveBadge])
	{
		//Works
	}
	%orig;
	test = nil;
}

%new
- (BOOL)doesHaveBadge{
	if(![self isKindOfClass:[%c(SBIconView) class]]){
		test = nil;
		return NO;
	}

	id badge = [self.icon badgeNumberOrString];


	if([badge isKindOfClass:[NSNumber class]])
	{
		NSNumber *badge_number = badge;
		test = badge;
		HBLogDebug(@"%@", [badge_number stringValue]);
		//test = @"1";
		return YES;

	}
	else{
		test = nil;
		return NO;
	}
}

%end