//
//  ASRecentContact.m
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import "ASRecentContact.h"

NSString* const kRecentContact = @"kRecentContact";
NSString* const kRecentContacts = @"kRecentContacts";

@implementation ASRecentContact

- (void)encodeWithCoder:(NSCoder *)coder
{
    
    [coder encodeObject:self.fullName forKey:@"fullName"];
    [coder encodeObject:self.timeString forKey:@"timeString"];
    [coder encodeObject:self.dateString forKey:@"dateString"];

    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        
        self.fullName = [coder decodeObjectForKey:@"fullName"];
        self.timeString = [coder decodeObjectForKey:@"timeString"];
        self.dateString = [coder decodeObjectForKey:@"dateString"];
        
    }
    return self;
}


@end
