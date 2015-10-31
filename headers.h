NSMutableDictionary *prefs;
NSDictionary *ColorSettings;

NSString *numberNotify;
NSString *bundleID;
BOOL enabled = true;
BOOL enabledText = true;
BOOL enabledFill = true;
BOOL enabledBadges = false;
BOOL enabledPlural = true;
BOOL hideLabels = false;
NSString *colorTextString;
NSString *colorFillString;
NSString *defaultLabel;
id newView;

@interface SBIcon : NSObject
- (id)badgeNumberOrString;
- (BOOL)isFolderIcon;
-(id)applicationBundleID;
- (void)reloadIconImagePurgingImageCache:(_Bool) arg1;
- (void)purgeCachedImages;
-(id)leafIdentifier;
- (id)displayNameForLocation:(int)arg1;
@end

@interface SBFolderIcon : SBIcon
@property(copy, nonatomic) NSString *displayName;
- (void)_updateBadgeValue;
- (void)updateLabel;
- (BOOL)doesHaveBadge;
@end

@interface _UILegibilitySettings
@end

@interface SBIconLabelImageParameters : NSObject
@property(copy, nonatomic) NSString *text;
@end

@interface SBIconLabelView 
@property(retain, nonatomic) SBIconLabelImageParameters *imageParameters;

+(void) updateIconLabelView:(SBIconLabelView *)arg1 withSettings:(_UILegibilitySettings *) arg2 imageParameters:(SBIconLabelImageParameters *) arg3;
+ (id)newIconLabelViewWithSettings:(_UILegibilitySettings *)arg1 imageParameters:(SBIconLabelImageParameters *)arg2;

@end


@interface SBIconBadgeView : UIView
@end

@interface SBLeafIcon
- (BOOL)doesHaveBadge;
- (id)badgeNumberOrString;
- (id)applicationBundleID;
-(void)showDebugAlert;
@end

@interface SBIconView : UIView
@property (retain, nonatomic) SBIcon *icon;
@property (retain, nonatomic) SBIconLabelView *labelView;
@property(retain, nonatomic) _UILegibilitySettings *legibilitySettings;
-(void)_updateLabelAccessoryView;
-(void)_updateLabel;
-(SBIconLabelView *)labelView;
-(void)setLabelHidden:(BOOL)arg1;
- (id)_labelImage;
- (BOOL)doesHaveBadge;
-(id)iconImageSnapshot;
-(NSDictionary*)mainColoursInImage:(UIImage *)image detail:(int)detail;
-(void) setPreferenceValue:(id)value key:(NSString *)key;
@end

@interface SBFolderIconView : SBIconView
@property (retain, nonatomic) SBIcon *icon;
- (BOOL)folderHasBadge;
- (BOOL)folderBadge;
@end


