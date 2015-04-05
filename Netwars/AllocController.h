//
//  AllocController.h
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

typedef enum AllocType {
	Allocate = 0,
	Deallocate,
} AllocType;

@interface AllocController : UITableViewController

- (id)initWithProgram:(Program *)prog;
- (void)sliderChange:(id)sender;
- (void)allocSelect:(id)sender;


@end
