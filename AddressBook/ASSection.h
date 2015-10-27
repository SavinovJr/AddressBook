//
//  ASSection.h
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSection : NSObject

@property (strong, nonatomic) NSString* sectionName;

@property (strong, nonatomic) NSMutableArray* items;

@end
