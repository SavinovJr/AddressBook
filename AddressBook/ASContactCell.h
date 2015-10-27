//
//  ASContactCell.h
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *fullNameTextLabel;

- (IBAction)callButtonAction:(UIButton *)sender;


@end
