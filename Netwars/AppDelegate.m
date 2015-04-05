//
//  AppDelegate.m
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "StateController.h"
#import "Player.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
	[NSURLCache setSharedURLCache:URLCache];

	[[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

	if ([[Player sharedPlayer] authenticated]) {
		self.navController = [[UINavigationController alloc] initWithRootViewController:[[StateController alloc]initWithStyle:UITableViewStylePlain]];
		[self.navController setNavigationBarHidden:YES];
	}
	else {
		NSLog(@"player not authenticated");
		LoginController *login = [[LoginController alloc] initWithStyle:UITableViewStylePlain];
		self.navController = [[UINavigationController alloc] initWithRootViewController:login];
		[self.navController setNavigationBarHidden:YES];
		[login setDelegate:self];
	}

	//self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	// Override point for customization after application launch.
	self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = self.navController;
	[self.window makeKeyAndVisible];

	return YES;
}

- (void)userCreated:(LoginController *)controller {
	StateController *main = [[StateController alloc]initWithStyle:UITableViewStylePlain];
	[self.navController setViewControllers:@[main] animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	[[Player sharedPlayer] persistKey];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	[[Player sharedPlayer] persistKey];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	[[Player sharedPlayer] persistKey];
}

@end
