//
//  EventCell.m
//  Netwars
//
//  Created by amjolk on 30/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "EventCell.h"
#import "Event.h"

@implementation EventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
	}
	return self;
}

- (void)setEvent:(Event *)event {
	self.textLabel.text = event.eventType;
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *date;
	[dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    date = [dateFormatter dateFromString:event.occurred];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
	self.detailTextLabel.text = [dateFormatter stringFromDate:date];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end
