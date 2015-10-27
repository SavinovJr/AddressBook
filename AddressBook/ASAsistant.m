//
//  ASAsistant.m
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import "ASAsistant.h"
#import <UIKit/UIKit.h>

@implementation ASAsistant

+(id)sharedInstance{
    
    static ASAsistant* sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        sharedInstance = [[self alloc] init];
        
        sharedInstance.images = [NSMutableArray array];
        
        [sharedInstance.images addObject:[UIImage imageNamed:@"0.png"]];
        [sharedInstance.images addObject:[UIImage imageNamed:@"1.png"]];
        [sharedInstance.images addObject:[UIImage imageNamed:@"2.png"]];
        [sharedInstance.images addObject:[UIImage imageNamed:@"3.png"]];
        [sharedInstance.images addObject:[UIImage imageNamed:@"4.png"]];
        [sharedInstance.images addObject:[UIImage imageNamed:@"5.png"]];
        [sharedInstance.images addObject:[UIImage imageNamed:@"6.png"]];
        [sharedInstance.images addObject:[UIImage imageNamed:@"7.png"]];
        [sharedInstance.images addObject:[UIImage imageNamed:@"8.png"]];
        [sharedInstance.images addObject:[UIImage imageNamed:@"9.png"]];
        
    });
    
    return sharedInstance;
}

-(void)saveObject:(id)object forKey:(NSString*)key{
    
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:data forKey:key];
    
}

-(id)loadObjectForKey:(NSString*)key{
    
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
