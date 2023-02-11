//
//  AppDelegate.m
//  ZWQRCode
//
//  Created by 崔先生的MacBook Pro on 2023/2/10.
//

#import "AppDelegate.h"
#import "ZWQRCodeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ZWQRCodeViewController *vc = [ZWQRCodeViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
