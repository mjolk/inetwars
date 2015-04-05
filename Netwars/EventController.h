//
//  EventController.h
//  Netwars
//
//  Created by amjolk on 30/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventController : UITableViewController

@property (nonatomic, strong) NSDictionary *imgMap;
@property (nonatomic, strong) NSString *cursor;
@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSString *eventType;

- (id)initForEventType:(NSString *)tpe;

@end
