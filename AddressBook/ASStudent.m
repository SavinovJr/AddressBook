//
//  ASStudent.m
//  AddressBook
//
//  Created by Admin on 21.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import "ASStudent.h"
#import <UIKit/UIKit.h>

NSString* const kStudent = @"kStudent";
NSString* const kStudentsArray = @"kStudentsArray";

@interface ASStudent () 

@end

@implementation ASStudent

- (void)encodeWithCoder:(NSCoder *)coder
{
    
    [coder encodeObject:self.firstName forKey:@"firstName"];
    [coder encodeObject:self.lastName forKey:@"lastName"];
    [coder encodeObject:self.phone forKey:@"phone"];
    [coder encodeObject:self.eMail forKey:@"eMail"];
    [coder encodeObject:self.photo forKey:@"photo"];
    [coder encodeObject:[NSNumber numberWithInteger:self.curPositionForPhoto ] forKey:@"curPositionForPhoto"];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        
        self.firstName = [coder decodeObjectForKey:@"firstName"];
        self.lastName = [coder decodeObjectForKey:@"lastName"];
        self.phone = [coder decodeObjectForKey:@"phone"];
        self.eMail = [coder decodeObjectForKey:@"eMail"];
        self.photo = [coder decodeObjectForKey:@"photo"];
        self.curPositionForPhoto = [[coder decodeObjectForKey:@"curPositionForPhoto"] integerValue];

    }
    return self;
}

-(NSString*)fullName{
    
    return [NSString stringWithFormat:@"%@ %@",self.firstName, self.lastName];
    
}

@end
