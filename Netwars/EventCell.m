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
	NSDateFormatter *rfc3339DateFormatter = [[NSDateFormatter alloc] init];

	/*  NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
	   for (NSString *zoneName in timeZoneNames) {
	      NSLog(@"timezone: %@ \n", zoneName);
	   }*/
	//[rfc3339DateFormatter setDateFormat:@"yyyy-MM-dd 'T' HH:mm:ss.SSSSSSZ"];
	//[rfc3339DateFormatter setTimeZone:<#(NSTimeZone *)#>]
	NSDate *date;
	NSError *error;
	//[rfc3339DateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"nl_BE"]];
	[rfc3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
	[rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Europe/Brussels"]];
	[rfc3339DateFormatter getObjectValue:&date forString:event.occurred range:nil error:&error];
	NSLog(@"occurred time : %@  and date : %@\n error: %@", event.occurred, date, error);
	self.detailTextLabel.text = [rfc3339DateFormatter stringFromDate:date];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end
