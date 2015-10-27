//
//  ASContactsViewController.m
//  AddressBook
//
//  Created by Admin on 21.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import "ASContactsTableViewController.h"
#import "ASDetailContactController.h"

#import "ASAsistant.h"
#import "ASSection.h"
#import "ASRecentContact.h"

#import "ASContactCell.h"


@interface ASContactsTableViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray* students;
@property (strong, nonatomic) NSMutableArray* sectionsArray;
@property (strong, nonatomic) ASAsistant* asistant;

@end

@implementation ASContactsTableViewController

-(void)viewDidLoad{
    
    NSLog(@"viewDidLoad ASContactsTableViewController");
    
    self.tableView.dataSource = self;
    
    self.asistant = [ASAsistant sharedInstance];
    //self.asistant = [[ASAsistant alloc] init];
    
    self.students = [self.asistant loadObjectForKey:kStudentsArray];
    
    if (!self.students) {
        
        self.students = [NSMutableArray array];
        
    }
    
    /////////////////////////////////////////
    [self.asistant saveObject:nil forKey:kStudent];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear ASContactsTableViewController");
}

-(void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    self.student = [self.asistant loadObjectForKey:kStudent];
    
    
    if (self.student) {
        
        [self.students addObject:self.student];
        
    }
    
    self.students = [self sortArray:self.students];
    
    self.sectionsArray = [NSMutableArray array];
    
    NSString* currentLetter = nil;
    
    for (ASStudent* student in self.students) {
        
        if (student.lastName.length<1) {
            continue;
        }
        
        NSString* firstLetter = [student.lastName substringToIndex:1];
        
        ASSection* section = nil;
        
        if (![currentLetter isEqualToString:firstLetter]) {
            
            section = [[ASSection alloc] init];
            
            section.sectionName = firstLetter;
            
            section.items = [NSMutableArray array];
            
            currentLetter = firstLetter;
            
            [self.sectionsArray addObject:section];
            
        } else {
            
            section = [self.sectionsArray lastObject];
            
        }
        
        [section.items addObject:student];
    }
    
    [self.tableView reloadData];
    
    
    ///////////////////////////////////////////////////////////////
    [self.asistant saveObject:self.students forKey:kStudentsArray];
    
    
    NSLog(@"viewDidAppear ASContactsTableViewController");
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.asistant saveObject:nil forKey:kStudent];
    
    NSLog(@"viewWillDisappear ASContactsTableViewController");
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    NSLog(@"viewDidDisappear ASContactsTableViewController");
    
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.sectionsArray count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    ASSection* sectionItem = [self.sectionsArray objectAtIndex:section];
    
    return sectionItem.sectionName;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    ASSection* sectionItem = [self.sectionsArray objectAtIndex:section];
    
    return [sectionItem.items count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ASContactCell* cell = [tableView dequeueReusableCellWithIdentifier:@"StudentsCell" forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[ASContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StudentsCell"];
        
    }
    
    ASSection* sectionItem = [self.sectionsArray objectAtIndex:indexPath.section];
    
    ASStudent* student = [sectionItem.items objectAtIndex:indexPath.row];
    
    NSString* fullName = student.fullName;
    
    cell.fullNameTextLabel.text = fullName;
    
    cell.image.image = [self.asistant.images objectAtIndex:student.curPositionForPhoto];
    
    return cell;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray* sectionIndexTitles = [NSMutableArray array];
    
    for (ASSection* section in self.sectionsArray) {
        
        [sectionIndexTitles addObject:section.sectionName];
        
    }
    
    return sectionIndexTitles;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ASDetailContactController* detailContactController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailContactController"];
    
    ASSection* sectionItem = [self.sectionsArray objectAtIndex:indexPath.section];
    
    ASStudent* student = [sectionItem.items objectAtIndex:indexPath.row];
    
    detailContactController.fullName = student.fullName;
    
    detailContactController.phone = student.phone;
    
    detailContactController.eMail = student.eMail;
    
    detailContactController.photo = [self.asistant.images objectAtIndex:student.curPositionForPhoto];
    
    [self.navigationController pushViewController:detailContactController animated:YES];
}


#pragma mark - Methods

-(NSMutableArray*)sortArray:(NSMutableArray*)array{
    
    NSSortDescriptor* firstNameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    [array sortUsingDescriptors:@[lastNameSortDescriptor,firstNameSortDescriptor]];
    
    return array;
    
}

@end
