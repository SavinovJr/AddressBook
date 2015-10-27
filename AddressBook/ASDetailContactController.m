//
//  ASDetailContactController.m
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import "ASDetailContactController.h"

@interface ASDetailContactController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *eMailLabel;

@end

@implementation ASDetailContactController


-(void)viewDidLoad{
    
    self.fullNameLabel.text = self.fullName;
    
    self.phoneLabel.text = self.phone;
    
    self.eMailLabel.text = self.eMail;
    
    self.photoView.image= self.photo;
 
}

@end
