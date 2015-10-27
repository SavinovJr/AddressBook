//
//  ASAddContactViewController.m
//  AddressBook
//
//  Created by Admin on 21.10.15.
//  Copyright (c) 2015 Savinov_Jr. All rights reserved.
//

#import "ASAddContactViewController.h"

#import "ASStudent.h"
#import "ASAsistant.h"

@interface ASAddContactViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *arrayWithTextFields;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) ASAsistant* asistant;

@property (strong, nonatomic) NSMutableArray* images;

@property (assign, nonatomic) NSInteger curImageIndex;

@end

@implementation ASAddContactViewController

-(void)awakeFromNib{
    
}

-(void)viewDidLoad{
    
    /*Index textField in arrays:
     0 - firstName
     1 - lastName
     2 - phone
     3 - eMail
     */
    
    for (UITextField *textField in self.arrayWithTextFields) {
        
        textField.keyboardAppearance = UIKeyboardAppearanceDark;
        
        textField.clearButtonMode = UITextFieldViewModeAlways;
        
        textField.delegate = self;
        
    }
    
    UIBarButtonItem* backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonSystemItemCancel target:self action:@selector(backButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    self.asistant = [ASAsistant sharedInstance];
    
    self.imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedImage:)];
    [self.imageView addGestureRecognizer:tap];
    
    self.images = self.asistant.images;
    
    self.curImageIndex = 0;
    
    //self.scrollView.delegate = self;
    
    //self.scrollView.frame = self.view.bounds;
    /*UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];*/
    
    //[self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height*3)];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    for (NSInteger i = 0; i<[self.arrayWithTextFields count]-1; i++) {
        
        if ([textField isEqual:self.arrayWithTextFields[i]]) {
            
            [self.arrayWithTextFields[i+1] becomeFirstResponder];
            
        } else {
            
            [textField resignFirstResponder];
            
        }
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual:self.arrayWithTextFields[2]]) {
        
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count]>1) {
            return NO;
        }
        
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        //+XX (XXX) XXX-XXXX
        
        NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        newString = [validComponents componentsJoinedByString:@""];
        
        //XXXXXXXXXXXX
        
        static const int localNumberMaxLenght =     7;
        static const int areaNumberMaxLenght =      3;
        static const int countryNumberMaxLenght =   3;
        
        if ([newString length]>localNumberMaxLenght + areaNumberMaxLenght + countryNumberMaxLenght) {
            return NO;
        }
        
        NSMutableString* resultString = [NSMutableString string];
        
        /*
         XXXXXXXXXXXX -> +XXX (XXX) XXX-XXXX
         */
        
        NSInteger localNumberLength = MIN([newString length], localNumberMaxLenght);
        
        if (localNumberLength>0) {
            NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
            [resultString appendString:number];
            
            if ([resultString length]>3) {
                [resultString insertString:@"-" atIndex:3];
            }
        }
        
        if ([newString length]>localNumberMaxLenght) {
            
            NSInteger areaCodeLength = MIN([newString length] - localNumberMaxLenght, areaNumberMaxLenght);
            
            NSRange areaRange = NSMakeRange([newString length] - localNumberMaxLenght - areaCodeLength, areaCodeLength);
            
            NSString* area = [newString substringWithRange:areaRange];
            
            area = [NSString stringWithFormat:@"(%@) ",area];
            
            [resultString insertString:area atIndex:0];
            
        }
        
        if ([newString length]>localNumberMaxLenght + areaNumberMaxLenght) {
            
            NSInteger countryCodeLength = MIN([newString length] - localNumberMaxLenght - areaNumberMaxLenght,countryNumberMaxLenght);
            NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
            
            NSString* countryCode = [newString substringWithRange:countryCodeRange];
            
            countryCode = [NSString stringWithFormat:@"+%@ ",countryCode];
            
            [resultString insertString:countryCode atIndex:0];
        }
        
        textField.text = resultString;
        
        return NO;
    }
    
    if ([textField isEqual:self.arrayWithTextFields[3]]) {
        
        NSCharacterSet *validationSet = [NSCharacterSet characterSetWithCharactersInString:@" ,~?!#$%^&*()/]\[{}><"];
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count]>1) {
            return NO;
        }
        
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@"];
        NSArray * componentsInString = [newString componentsSeparatedByCharactersInSet:set];
        
        if ([componentsInString count]>2) {
            return NO;
        } else{
            return [newString length]<=256;
        }
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate

/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGRect rectFrameView = self.view.frame;
    
    NSLog(@"%@", NSStringFromCGRect(rectFrameView));
    
    NSLog(@"%@", NSStringFromCGSize(self.scrollView.contentSize));

    NSLog(@"scrollViewDidScroll");
}*/

#pragma mark - Touches

- (void)touchedImage:(UITapGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        self.curImageIndex++;
        
        self.imageView.image = [self.images objectAtIndex:self.curImageIndex];
        
        if (self.curImageIndex == [self.images count]) {
            
            self.curImageIndex = 0;
            
        }
        
    }
}

#pragma mark - Action

- (IBAction)addContactAction:(UIButton *)sender {
    
    ASStudent* student = [[ASStudent alloc] init];
    
    
    if ([[self.arrayWithTextFields[0] text] length] < 1) {
        
        student.firstName = @" ";
        
    } else {
        
        student.firstName = [self.arrayWithTextFields[0] text];
        
    }
    
    if ([[self.arrayWithTextFields[1] text] length] < 1) {
        
        student.lastName = @" ";
        
    } else {
        
        student.lastName = [self.arrayWithTextFields[1] text];
        
    }
    
    //student.lastName = [self.arrayWithTextFields[1] text];
    
    student.phone = [self.arrayWithTextFields[2] text];
    student.eMail = [self.arrayWithTextFields[3] text];
    
    student.photo = [self.images objectAtIndex:self.curImageIndex];
    
    student.curPositionForPhoto = self.curImageIndex;
    
    [self.asistant saveObject:student forKey:kStudent];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)backButtonAction:(UIBarButtonItem*)sender{
    
    [self.asistant saveObject:nil forKey:kStudent];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
