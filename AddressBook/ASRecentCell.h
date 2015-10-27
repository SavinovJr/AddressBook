//
//  ASRecentCell.h
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASRecentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fullNameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeTextLabel;

@end
