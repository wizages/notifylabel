#import <Cephei/HBPreferences.h>

@interface NotifyManager : NSObject

@property (nonatomic, readonly) BOOL enabled;
@property (nonatomic, readonly) BOOL enableText;
@property (nonatomic, readonly) BOOL enabledFill;
@property (nonatomic, readonly) BOOL enabledBadges;
@property (nonatomic, readonly) BOOL enabledPlural;
@property (nonatomic, readonly) BOOL hideLabels;
@property (nonatomic, readonly) NSString* defaultLabel;

+ (instancetype)sharedInstance;
- (UIColor *)colorForPreference:(NSString *)string fallback:(NSString *)fallback;
- (NSString *)customLabel:(NSString *)string;
- (BOOL)customLabelIsAvailable:(NSString *)bundleID;

@end
