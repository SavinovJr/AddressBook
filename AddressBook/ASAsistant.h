//
//  ASAsistant.h
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAsistant : NSObject

@property(strong, nonatomic) NSMutableArray* images;

+(id)sharedInstance;

-(void)saveObject:(id)object forKey:(NSString*)key;

-(id)loadObjectForKey:(NSString*)key;

@end
