//
//  ASStudent.h
//  AddressBook
//
//  Created by Admin on 21.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

extern NSString* const kStudent;
extern NSString* const kStudentsArray;

@interface ASStudent : NSObject <NSCoding>

@property(strong, nonatomic) NSString* firstName;
@property(strong, nonatomic) NSString* lastName;
@property(strong, nonatomic) NSString* phone;
@property(strong, nonatomic) NSString* eMail;
@property(strong, nonatomic) UIImage* photo;
@property(assign, nonatomic) NSInteger curPositionForPhoto;

-(NSString*)fullName;

@end
