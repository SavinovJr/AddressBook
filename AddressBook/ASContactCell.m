//
//  ASContactCell.m
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import "ASContactCell.h"
#import "ASAsistant.h"
#import "ASRecentContact.h"

@implementation ASContactCell

- (IBAction)callButtonAction:(UIButton *)sender {
    
    ASRecentContact* recentContact = [[ASRecentContact alloc] init];
    
    recentContact.fullName = self.fullNameTextLabel.text;
    
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* dateComponents = [[NSDateComponents alloc] init];
    
    
    dateComponents.day = [calendar component:NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponents.month = [calendar component:NSCalendarUnitMonth fromDate:[NSDate date]];
    dateComponents.year = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    dateComponents.hour = [calendar component:NSCalendarUnitHour fromDate:[NSDate date]];
    dateComponents.minute = [calendar component:NSCalendarUnitMinute fromDate:[NSDate date]];
    
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    NSDate* date = [calendar dateFromComponents:dateComponents];
    
    recentContact.dateString = [dateFormatter stringFromDate:date];
    
    dateFormatter.dateFormat = @"HH:mm";
    
    recentContact.timeString = [dateFormatter stringFromDate:date];
    
    
    ASAsistant* asistant = [ASAsistant sharedInstance];
    
    [asistant saveObject:recentContact forKey:kRecentContact];
    
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Вы вызвали данный контакт" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     
     [alertView show];
    
}
@end
