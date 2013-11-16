//
//  IndexedNavController.h
//  Netwars
//
//  Created by mjolk on 13/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexedNavController : UINavigationController

@property (nonatomic, assign) NSUInteger index;
- (id)initWithRootViewController:(UIViewController *)rootViewController index:(NSUInteger) index;
@end
