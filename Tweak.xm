#import <libcolorpicker.h>
#define TweakPreferencePath @"/User/Library/Preferences/com.wizages.labelnotify.plist"
#define ColorPreferencePath @"/User/Library/Preferences/com.wizages.labelnotify.color.plist"
#import <Applist/Applist.h>
#import "headers.h"

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
		NSString *enabledTextCustombundle = [NSString stringWithFormat:@"textText_enabled-%@", bundleID];
		BOOL enabledTextCustom = false;
		enabledTextCustom = ( [prefs objectForKey:enabledTextCustombundle] ? [[prefs objectForKey:enabledTextCustombundle] boolValue] :  enabledTextCustom);
		if (numberNotify != nil && enabled && enabledTextCustom)
		{
			NSString *textCustomBundle = [NSString stringWithFormat:@"textText-%@", bundleID];
			NSString *textCustom = [prefs objectForKey:textCustomBundle];
			return LCPParseColorString(textCustom, @"#ffffff");
		}
		else if (numberNotify != nil && enabled && enabledText){
			return LCPParseColorString(colorTextString, @"#ffffff");
		}
		else
			return %orig;
}

-(UIColor *)focusHighlightColor{
		NSString *enabledFillCustomBundle = [NSString stringWithFormat:@"textFill_enabled-%@", bundleID];
		BOOL enabledFillCustom = false;
		enabledFillCustom = ( [prefs objectForKey:enabledFillCustomBundle] ? [[prefs objectForKey:enabledFillCustomBundle] boolValue] :  enabledFillCustom);
		if (numberNotify != nil && enabled && enabledFillCustom)
		{
			NSString *fillCustomBundle = [NSString stringWithFormat:@"textFill-%@", bundleID];
			NSString *fillCustom = [prefs objectForKey:fillCustomBundle];
			return LCPParseColorString(fillCustom, @"#8b8b8b");
		}
		else if (numberNotify != nil && enabled && enabledFill){
			return LCPParseColorString(colorFillString, @"#8b8b8b");
		}
		else
			return %orig;
	/*
		if (numberNotify != nil) {
		
			NSArray *settings = [ ColorSettings[bundleID] componentsSeparatedByString:@" "];
    		if ([settings count] == 5)
        	{
        		HBLogDebug(@"%@, %@", settings, bundleID);
        		return [UIColor colorWithRed:[[settings objectAtIndex:1] floatValue] green:[[settings objectAtIndex:2] floatValue] blue: [[settings objectAtIndex:3] floatValue] alpha:[[settings objectAtIndex:4] floatValue]];
        	}
		}
	*/
	/*
	if (test_COLOR == nil)
	{
		return %orig;
	}
	else {
		return test_COLOR;
	}
	*/
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
*/
%end

%hook SBLeafIcon

- (id)badgeNumberOrString {
	id test = %orig;
	HBLogDebug(@"%@ - %@", [self applicationBundleID], test);
	return test;
}

- (id)displayNameForLocation:(int)arg1{
	if (enabled && [self doesHaveBadge] && hideLabels)
	{
		return numberNotify;
	}
	else if (enabled && [self doesHaveBadge])
	{
		return numberNotify;
	}
	else if (enabled && hideLabels)
	{
		return %orig;
	}
	else {
		return %orig;
	}
}

%new
- (BOOL)doesHaveBadge{
	if (enabled){
	bundleID = [self applicationBundleID];

	id badge = [self badgeNumberOrString];


	if([badge isKindOfClass:[NSNumber class]])
	{
		NSString *labelbundle = [NSString stringWithFormat:@"Label-%@", [self applicationBundleID]];

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
			NSString *labelbundle = [NSString stringWithFormat:@"Label-%@", [self applicationBundleID]];
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

%hook SBFolderIcon

- (id)displayNameForLocation:(int)arg1 {
	if (enabled && [self doesHaveBadge] && hideLabels)
	{
		return numberNotify;
	}
	else if (enabled && [self doesHaveBadge])
	{
		return numberNotify;
	}
	else if (enabled && hideLabels)
	{
		return %orig;
	}
	else {
		return %orig;
	}
}


-(void)updateLabel {

if (enabled && [self doesHaveBadge] && hideLabels)
	{
		//MSHookIvar<UIView *>(self, "_labelView").hidden = false;
		//MSHookIvar<long long>(self, "_currentLabelAccessoryType") = 1;
		//MSHookIvar<unsigned>(self, "_hideLabelAccessoryView") = 0;
		/*
		if (!ColorSettings){
			ALApplicationList *al = [ALApplicationList sharedApplicationList];
			NSDictionary *bundleList = [al applicationsFilteredUsingPredicate:nil onlyVisible:true titleSortedIdentifiers:nil];
			HBLogDebug(@"%@", [bundleList allKeys]);
			NSArray *keys = [bundleList allKeys];
			for(NSString* appID in keys)
			{
				NSArray *appColors = [[self mainColoursInImage:[al iconOfSize:ALApplicationIconSizeSmall forDisplayIdentifier:appID] detail:1] objectForKey:@"colours"];
				if ([appColors count] > 1)
					[self setPreferenceValue:[[appColors objectAtIndex:1] description] key:appID];
				else{
					//Do nothing
				}
			}
			loadLabelNotifyPrefs();
			HBLogDebug(@"ColorSettings = %@", ColorSettings);
		}
		*/
	}
	else if (enabled && hideLabels)
	{
		//MSHookIvar<UIView *>(self, "_labelView").hidden = true;
		//MSHookIvar<long long>(self, "_currentLabelAccessoryType") = 0;
	}
	//[self.icon reloadIconImagePurgingImageCache:YES];
	//self.labelView = nil;
	%orig;
	/*
	SBIconLabelImageParameters *newParams = [self labelView].imageParameters;
	if (newParams != nil &&  self.legibilitySettings != nil)
	{
		newView = [%c(SBIconLabelView) newIconLabelViewWithSettings:self.legibilitySettings imageParameters:newParams];
		self.labelView = newView;
	//(id)newIconLabelViewWithSettings:
		HBLogDebug(@"%@", newView);
	}
	*/
	//newParams.text = @"Test new hook";
	
	numberNotify = nil;
}

%new
- (BOOL)doesHaveBadge{
	if (enabled){
	bundleID = [self applicationBundleID];

	id badge = [self badgeNumberOrString];

	HBLogDebug(@"%@", badge);
	if([badge isKindOfClass:[NSNumber class]])
	{
		NSString *labelbundle = [NSString stringWithFormat:@"Label-%@", [self applicationBundleID]];

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
			NSString *labelbundle = [NSString stringWithFormat:@"Label-%@", [self applicationBundleID]];
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

%hook SBIconLabelView

+(void) updateIconLabelView:(SBIconLabelView *)arg1 withSettings:(_UILegibilitySettings *) arg2 imageParameters:(SBIconLabelImageParameters *) arg3 {
	%log;
	%orig;
}

%end

%hook SBIconView

-(void)_updateLabel {
	/*NSDictionary *mainColours = [self mainColoursInImage:[self iconImageSnapshot] detail:1];
	NSArray *test_COLOR32 = [mainColours objectForKey:@"colours"];
	if ([test_COLOR32 count] > 1)
	{
		HBLogDebug(@"%@", [test_COLOR32 objectAtIndex:1] );
		test_COLOR = (UIColor *)[test_COLOR32 objectAtIndex:1];
	}
	else{
		test_COLOR = nil;
	}
	*/
	/*
	if ([self.icon applicationBundleID] != nil){

		if (ColorSettings[[self.icon applicationBundleID]]) {
        NSArray *settings = [ ColorSettings[[self.icon applicationBundleID]] componentsSeparatedByString:@" "];
        if ([settings count] == 5)
        {
        	test_COLOR = [UIColor colorWithRed:[[settings objectAtIndex:1] floatValue] green:[[settings objectAtIndex:2] floatValue] blue: [[settings objectAtIndex:3] floatValue] alpha:[[settings objectAtIndex:4] floatValue]];
        	if (![test_COLOR isKindOfClass:[UIColor class]] )
        	{
        		test_COLOR = nil;
        	}
        }
        else
        	test_COLOR = nil;

   		}else{
    	if ([self iconImageSnapshot] != nil)
    	{
    		NSDictionary *mainColours = [self mainColoursInImage:[self iconImageSnapshot] detail:1];
			NSArray *test_COLOR32= [mainColours objectForKey:@"colours"];
		if ([test_COLOR32 count] > 1)
		{
			test_COLOR = (UIColor *)[test_COLOR32 objectAtIndex:1];
			if (![test_COLOR isKindOfClass:[UIColor class]] || test_COLOR == nil || [self.icon applicationBundleID] == nil || [[self.icon applicationBundleID] isEqual:@""] || [[NSString stringWithFormat:@"%@", test_COLOR ] rangeOfString:@"UIDeviceRGBColorSpace"].location == NSNotFound)
        	{
        		test_COLOR = nil;
        	}
        	else{
        		[self setPreferenceValue:[test_COLOR description] key:[self.icon applicationBundleID]];
        	}
		}
    	}
    	
    }
	}
    */
	if (enabled && [self doesHaveBadge] && hideLabels)
	{
		MSHookIvar<UIView *>(self, "_labelView").hidden = false;
		//MSHookIvar<long long>(self, "_currentLabelAccessoryType") = 1;
		//MSHookIvar<unsigned>(self, "_hideLabelAccessoryView") = 0;
		/*
		if (!ColorSettings){
			ALApplicationList *al = [ALApplicationList sharedApplicationList];
			NSDictionary *bundleList = [al applicationsFilteredUsingPredicate:nil onlyVisible:true titleSortedIdentifiers:nil];
			HBLogDebug(@"%@", [bundleList allKeys]);
			NSArray *keys = [bundleList allKeys];
			for(NSString* appID in keys)
			{
				NSArray *appColors = [[self mainColoursInImage:[al iconOfSize:ALApplicationIconSizeSmall forDisplayIdentifier:appID] detail:1] objectForKey:@"colours"];
				if ([appColors count] > 1)
					[self setPreferenceValue:[[appColors objectAtIndex:1] description] key:appID];
				else{
					//Do nothing
				}
			}
			loadLabelNotifyPrefs();
			HBLogDebug(@"ColorSettings = %@", ColorSettings);
		}
		*/
	}
	else if (enabled && hideLabels)
	{
		MSHookIvar<UIView *>(self, "_labelView").hidden = true;
		//MSHookIvar<long long>(self, "_currentLabelAccessoryType") = 0;
	}
	[self.icon reloadIconImagePurgingImageCache:YES];
	//self.labelView = nil;
	%orig;
	
	//newParams.text = @"Test new hook";
	
	numberNotify = nil;
}

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

/*
%new
-(void) setPreferenceValue:(id)value key:(NSString *)key {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:ColorPreferencePath]];
    [defaults setObject:value forKey:key];
    [defaults writeToFile:ColorPreferencePath atomically:YES];
}

%new
-(NSDictionary*) mainColoursInImage:(UIImage *)image detail:(int)detail{

	//1. determine detail vars (0==low,1==default,2==high)
	//default detail
	float dimension = 10;
	float flexibility = 2;
	float range = 60;

	//low detail
	if (detail==0){
	    dimension = 4;
	    flexibility = 1;
	    range = 100;

	//high detail (patience!)
	} else if (detail==2){
	    dimension = 100;
	    flexibility = 10;
	    range = 20;
	}

	//2. determine the colours in the image
	NSMutableArray * colours = [NSMutableArray new];
	CGImageRef imageRef = [image CGImage];
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	unsigned char *rawData = (unsigned char*) calloc(dimension * dimension * 4, sizeof(unsigned char));
	NSUInteger bytesPerPixel = 4;
	NSUInteger bytesPerRow = bytesPerPixel * dimension;
	NSUInteger bitsPerComponent = 8;
	CGContextRef context = CGBitmapContextCreate(rawData, dimension, dimension, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	CGColorSpaceRelease(colorSpace);
	CGContextDrawImage(context, CGRectMake(0, 0, dimension, dimension), imageRef);
	CGContextRelease(context);

	float x = 0;
	float y = 0;
	for (int n = 0; n<(dimension*dimension); n++){

	    int index = (bytesPerRow * y) + x * bytesPerPixel;
	    int red   = rawData[index];
	    int green = rawData[index + 1];
	    int blue  = rawData[index + 2];
	    int alpha = rawData[index + 3];
	    NSArray * a = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%i",red],[NSString stringWithFormat:@"%i",green],[NSString stringWithFormat:@"%i",blue],[NSString stringWithFormat:@"%i",alpha], nil];
	    [colours addObject:a];

	    y++;
	    if (y==dimension){
	        y=0;
	        x++;
	    }
	}
	free(rawData);

	//3. add some colour flexibility (adds more colours either side of the colours in the image)
	NSArray * copyColours = [NSArray arrayWithArray:colours];
	NSMutableArray * flexibleColours = [NSMutableArray new];

	float flexFactor = flexibility * 2 + 1;
	float factor = flexFactor * flexFactor * 3; //(r,g,b) == *3
	for (int n = 0; n<(dimension * dimension); n++){

	    NSArray * pixelColours = copyColours[n];
	    NSMutableArray * reds = [NSMutableArray new];
	    NSMutableArray * greens = [NSMutableArray new];
	    NSMutableArray * blues = [NSMutableArray new];

	    for (int p = 0; p<3; p++){

	        NSString * rgbStr = pixelColours[p];
	        int rgb = [rgbStr intValue];

	        for (int f = -flexibility; f<flexibility+1; f++){
	            int newRGB = rgb+f;
	            if (newRGB<0){
	                newRGB = 0;
	            }
	            if (p==0){
	                [reds addObject:[NSString stringWithFormat:@"%i",newRGB]];
	            } else if (p==1){
	                [greens addObject:[NSString stringWithFormat:@"%i",newRGB]];
	            } else if (p==2){
	                [blues addObject:[NSString stringWithFormat:@"%i",newRGB]];
	            }
	        }
	    }

	    int r = 0;
	    int g = 0;
	    int b = 0;
	    for (int k = 0; k<factor; k++){

	        int red = [reds[r] intValue];
	        int green = [greens[g] intValue];
	        int blue = [blues[b] intValue];

	        NSString * rgbString = [NSString stringWithFormat:@"%i,%i,%i",red,green,blue];
	        [flexibleColours addObject:rgbString];

	        b++;
	        if (b==flexFactor){ b=0; g++; }
	        if (g==flexFactor){ g=0; r++; }
	    }
	}

	//4. distinguish the colours
	//orders the flexible colours by their occurrence
	//then keeps them if they are sufficiently disimilar

	NSMutableDictionary * colourCounter = [NSMutableDictionary new];

	//count the occurences in the array
	NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:flexibleColours];
	for (NSString *item in countedSet) {
	    NSUInteger count = [countedSet countForObject:item];
	    [colourCounter setValue:[NSNumber numberWithInteger:count] forKey:item];
	}

	//sort keys highest occurrence to lowest
	NSArray *orderedKeys = [colourCounter keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2){
	    return [obj2 compare:obj1];
	}];

	//checks if the colour is similar to another one already included
	NSMutableArray * ranges = [NSMutableArray new];
	for (NSString * key in orderedKeys){
	    NSArray * rgb = [key componentsSeparatedByString:@","];
	    int r = [rgb[0] intValue];
	    int g = [rgb[1] intValue];
	    int b = [rgb[2] intValue];
	    bool exclude = false;
	    for (NSString * ranged_key in ranges){
	        NSArray * ranged_rgb = [ranged_key componentsSeparatedByString:@","];

	        int ranged_r = [ranged_rgb[0] intValue];
	        int ranged_g = [ranged_rgb[1] intValue];
	        int ranged_b = [ranged_rgb[2] intValue];

	        if (r>= ranged_r-range && r<= ranged_r+range){
	            if (g>= ranged_g-range && g<= ranged_g+range){
	                if (b>= ranged_b-range && b<= ranged_b+range){
	                    exclude = true;
	                }
	            }
	        }
	    }

	    if (!exclude){ [ranges addObject:key]; }
	}

	//return ranges array here if you just want the ordered colours high to low
	NSMutableArray * colourArray = [NSMutableArray new];
	for (NSString * key in ranges){
	    NSArray * rgb = [key componentsSeparatedByString:@","];
	    float r = [rgb[0] floatValue];
	    float g = [rgb[1] floatValue];
	    float b = [rgb[2] floatValue];
	    UIColor * colour = [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0f];
	    [colourArray addObject:colour];
	}

	//if you just want an array of images of most common to least, return here
	return [NSDictionary dictionaryWithObject:colourArray forKey:@"colours"];
}
*/
%end

static void loadLabelNotifyPrefs()
{
	[prefs release];
	prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:TweakPreferencePath];
	/*
	if (!ColorSettings)
		ColorSettings = [NSDictionary dictionaryWithContentsOfFile:ColorPreferencePath];
	*/
    if(prefs)
    {
        enabled =  ( [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] :enabled );
        enabledText = ( [prefs objectForKey:@"enabled_text"] ? [[prefs objectForKey:@"enabled_text"] boolValue] : enabledText);
        enabledFill = ( [prefs objectForKey:@"enabled_fill"] ? [[prefs objectForKey:@"enabled_fill"] boolValue] : enabledFill);
        enabledBadges = ( [prefs objectForKey:@"enabled_badges"] ? [[prefs objectForKey:@"enabled_badges"] boolValue] : enabledBadges);
        enabledPlural = ([prefs objectForKey:@"enable_plurlizer"] ? [[prefs objectForKey:@"enable_plurlizer"] boolValue] : enabledPlural);
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