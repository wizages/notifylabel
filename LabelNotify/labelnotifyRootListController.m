#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import <Applist/Applist.h>
#include "Generic.h"

#ifndef kCFCoreFoundationVersionNumber_iOS_8_0
#define kCFCoreFoundationVersionNumber_iOS_8_0 1140.10
#endif

@interface labelnotifyRootListController : PSListController

@end

@implementation labelnotifyRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)loadView {
	[super loadView];
    UIImage* image;
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
	    image = [UIImage imageNamed:@"Icons/heart.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    }
    else {
        image = [UIImage imageNamed:@"Icons/heart.png" inBundle:[NSBundle bundleForClass:self.class]];
    }
	image = [image changeImageColor:[UIColor colorWithRed:26.0f/255.0f green:178.0f/255.0f blue:63.0f/255.0f alpha:1.0]];
	CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
     
    [someButton addTarget:self action:@selector(heartWasTouched) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *heartButton = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    ((UINavigationItem*)self.navigationItem).rightBarButtonItem = heartButton;
}

-(void)heartWasTouched
{
    SLComposeViewController *composeController = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
    [composeController setInitialText:@"I mustache you a question, why you not using #CleanSheets by @Wizages because dirty was so yesterday."];
    
    [self presentViewController:composeController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupHeader];
}

-(void)setupHeader {
    UIView *header = nil;
    header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    UIImage *headerImage;
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
        headerImage = [UIImage imageNamed:@"Icons/Banner.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    }
    else {
        headerImage = [UIImage imageNamed:@"Icons/Banner.png" inBundle:[NSBundle bundleForClass:self.class]];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:headerImage];
    header.frame = (CGRect){ header.frame.origin, headerImage.size };
    imageView.frame = CGRectMake(imageView.frame.origin.x, 10, imageView.frame.size.width, headerImage.size.height);    
    [header addSubview:imageView];
    [self.table setTableHeaderView:header];
}

-(void)respring
{
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Respring?" message:@"Are you sure you want to respring?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                        #pragma clang diagnostic push
                        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                        system("killall -9 SpringBoard");
                        #pragma clang diagnostic pop
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        system("killall -9 SpringBoard");
        #pragma clang diagnostic pop
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self setupHeader];
}

@end

