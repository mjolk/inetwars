//
//  PageController.m
//  Netwars
//
//  Created by mjolk on 13/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "PageController.h"
#import "ClanController.h"
#import "StateController.h"
#import "IndexedNavController.h"

@interface PageController ()

-(IndexedNavController *) viewControllerAtIndex:(NSUInteger) index;

@end

@implementation PageController

- (id) initWithDefaults {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        // Custom initialization
        self.dataSource = self;
        [self setViewControllers:@[[self viewControllerAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(IndexedNavController *) viewController index];
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(IndexedNavController *)viewController index];
    
    
    index++;
    
    if (index == 2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

-(IndexedNavController *) viewControllerAtIndex:(NSUInteger) index {
    IndexedNavController *currentNav;
    StateController *stateController;
    ClanController *clanController;
    NSLog(@"index requested %d", index);
    switch (index) {
        case 0:
            stateController = [[StateController alloc] initWithStyle:UITableViewStylePlain];
            currentNav = [[IndexedNavController alloc] initWithRootViewController:stateController index:index];
            break;
        case 1:
            clanController = [[ClanController alloc] initWithStyle:UITableViewStylePlain];
            currentNav = [[IndexedNavController alloc] initWithRootViewController:clanController index:index];
            break;
        default:
            currentNav = nil;
            break;
    }
    
    
    return currentNav;
}


@end
