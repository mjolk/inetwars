//
//  IndexedNavController.m
//  Netwars
//
//  Created by mjolk on 13/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "IndexedNavController.h"

@interface IndexedNavController ()

@end

@implementation IndexedNavController

- (id)initWithRootViewController:(UIViewController *)rootViewController index:(NSUInteger)index {
	self = [super initWithRootViewController:rootViewController];
	if (self) {
		// Custom initialization
		self.index = index;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
