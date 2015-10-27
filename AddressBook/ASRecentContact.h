//
//  ASRecentContact.h
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const kRecentContact;
extern NSString* const kRecentContacts;

@interface ASRecentContact : UITableViewCell

@property(strong, nonatomic) NSString* fullName;

@property(strong, nonatomic) NSString* timeString;

@property(strong, nonatomic) NSString* dateString;


@end
