//
//  ASRecentViewController.m
//  AddressBook
//
//  Created by Admin on 22.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import "ASRecentTableViewController.h"

#import "ASStudent.h"
#import "ASAsistant.h"
#import "ASRecentContact.h"

#import "ASRecentCell.h"

@interface ASRecentTableViewController () <UITableViewDataSource>

@property (strong, nonatomic) ASAsistant* asistant;

@property (strong, nonatomic) NSMutableArray* recentContacts;

@end

@implementation ASRecentTableViewController

-(void)viewDidLoad{
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.asistant = [ASAsistant sharedInstance];
    
    //[self.asistant saveObject:nil forKey:kRecentContact];
 
    self.recentContacts = [[self.asistant loadObjectForKey:kRecentContacts] mutableCopy];
    
    if (!self.recentContacts) {
        
        self.recentContacts = [NSMutableArray array];

    }
    
    NSLog(@"viewDidLoad ASRecentTableViewController");
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"viewWillAppear ASRecentTableViewController");
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    ASRecentContact* recentContact = [self.asistant loadObjectForKey:kRecentContact];
    
    if (recentContact) {
        [self.recentContacts insertObject:recentContact atIndex:0];
    }
    
    [self.asistant saveObject:self.recentContacts forKey:kRecentContacts];
    
    [self.tableView reloadData];
    
    
    NSLog(@"viewDidAppear ASRecentTableViewController");
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.asistant saveObject:nil forKey:kStudent];
    
    [self.asistant saveObject:nil forKey:kRecentContact];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.recentContacts count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ASRecentCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RecentCell" forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[ASRecentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecentCell"];
        
    }
    
    cell.fullNameTextLabel.text = [[self.recentContacts objectAtIndex:indexPath.row] fullName];
    
    cell.dateTextLabel.text = [[self.recentContacts objectAtIndex:indexPath.row] dateString];
    
    cell.timeTextLabel.text = [[self.recentContacts objectAtIndex:indexPath.row] timeString];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
