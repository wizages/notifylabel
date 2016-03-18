#define TweakPreferencePath @"/User/Library/Preferences/com.wizages.labelnotify.plist"
#define LabelStuff @"/Library/PreferenceBundles/LabelNotify.bundle/Label.plist"
#define LabelStuffCustom @"/Library/PreferenceBundles/LabelNotify.bundle/Label-custom.plist"
#define LCL(str) [self localizedString:str]

@interface PSListController (fixes)
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
-(id)bundle;
@end

@interface PSSpecifier (getKey)
@property (nonatomic, retain) NSDictionary *titleDictionary;
-(id)propertyForKey:(NSString*)key;
-(id)setProperty:(id)arg1 forKey:(id)arg2;
- (void)setTitleDictionary:(NSDictionary *)arg1;
@end

@interface UIImage (ios7)
+ (UIImage *)imageNamed:(NSString *)named inBundle:(NSBundle *)bundle;
@end

@implementation UIImage (Colored)

- (UIImage *)changeImageColor:(UIColor *)color {
    UIImage *img = self;
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContextWithOptions(img.size, NO, [UIScreen mainScreen].scale);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

@end