//
//  EventViewCell.m
//  Netwars
//
//  Created by amjolk on 15/06/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import "EventViewCell.h"
#import "Event.h"
#import "Common.h"

@implementation EventViewCell

- (id) init
{
    self = [super init];
    if (self) {
        
        self.result = [Common createLabel:self.contentView fontSize:16.0f];
        self.eventType = [Common createLabel:self.contentView fontSize:12.0f];
        self.action = [Common createLabel:self.contentView fontSize:12.0f];
        self.direction = [Common createLabel:self.contentView fontSize:12.0f];
        self.subject = [Common createLabel:self.contentView fontSize:12.0f];
        self.expires = [Common createLabel:self.contentView fontSize:12.0f];
        self.memory = [Common createLabel:self.contentView fontSize:12.0f];
        self.bwLost = [Common createLabel:self.contentView fontSize:12.0f];
        self.programsLost = [Common createLabel:self.contentView fontSize:12.0f];
        self.programsKilled = [Common createLabel:self.contentView fontSize:12.0f];
        self.bwKilled = [Common createLabel:self.contentView fontSize:12.0f];
        self.yieldLost = [Common createLabel:self.contentView fontSize:12.0f];
        self.apsGained = [Common createLabel:self.contentView fontSize:12.0f];
        self.cpsGained = [Common createLabel:self.contentView fontSize:12.0f];
        self.cycles = [Common createLabel:self.contentView fontSize:12.0f];
        
        
    }
    return self;
}

- (void) load:(Event *) event
{
    NSLog(@"evnet cell set %@", event);
    self.event = event;
    [self.result setText:[self.event result] ? @"Success!" : @"Failure."];
    [self.eventType setText:[self.event eventType]];
    [self.action setText:[self.event action]];
    [self.direction setText:[self.event direction] ? @"Incoming" : @"Outgoing"];
    if ([[self.event eventType] isEqualToString:@"Clan"]) {
        [self.subject setText:[[self.event targetClan] name]];
    } else {
        [self.subject setText:[[self.event targetPlayer] nick]];
    }
    [self.bwKilled setText:[[NSNumber numberWithFloat:[self.event bandwidthKilled]] stringValue]];
    [self.bwLost setText:[[NSNumber numberWithFloat:[self.event bandwidthLost]] stringValue]];
    [self.programsLost setText:[[NSNumber numberWithUnsignedInteger:[self.event programsLost]] stringValue]];
    [self.programsKilled setText:[[NSNumber numberWithUnsignedInteger:[self.event programsKilled]] stringValue]];
    [self.apsGained setText:[[NSNumber numberWithUnsignedInteger:[self.event apsGained]] stringValue]];
    [self.cpsGained setText:[[NSNumber numberWithUnsignedInteger:[self.event cpsGained]] stringValue]];
    
    
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.result autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView];
        [self.result autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
        [self.result autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
        [self.eventType autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.result];
        [self.eventType autoSetDimension:ALDimensionWidth toSize:self.contentView.bounds.size.width/2];
        [self.action autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.result];
        [self.action autoSetDimension:ALDimensionWidth toSize:self.contentView.bounds.size.width/2];
        [self.cpsGained autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
        [self.cpsGained autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.eventType];
        [self.cpsGained autoSetDimension:ALDimensionWidth toSize:self.contentView.bounds.size.width/2];
        [self.apsGained autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
        [self.apsGained autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.programsLost];
        [self.apsGained autoSetDimension:ALDimensionWidth toSize:self.contentView.bounds.size.width/2];
        [self.subject autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
        [self.subject autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.action];
        [self.programsKilled autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
        [self.programsKilled autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.subject];
        [self.programsKilled autoSetDimension:ALDimensionWidth toSize:self.contentView.bounds.size.width/2];
        [self.programsLost autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
        [self.programsLost autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.subject];
        [self.programsLost autoSetDimension:ALDimensionWidth toSize:self.contentView.bounds.size.width/2];
        [self.bwKilled autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
        [self.bwKilled autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.programsKilled];
        [self.bwKilled autoSetDimension:ALDimensionWidth toSize:self.contentView.bounds.size.width/2];
        [self.bwLost autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
        [self.bwLost autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.programsLost];
        [self.bwLost autoSetDimension:ALDimensionWidth toSize:self.contentView.bounds.size.width/2];
    }
    [super updateConstraints];
}

@end
