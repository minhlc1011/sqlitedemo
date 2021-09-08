//
//  AddContactsViewController.m
//  SQliteQuanLyDanhSach
//
//  Created by Lê Công Minh on 23/08/2021.
//

#import "AddContactsViewController.h"
#import "ViewController.h"
#import <FMDB.h>
#import <FMDatabase.h>
#import <FMResultSet.h>
#import "Contact.h"
@interface AddContactsViewController () {
    NSString *path;
    FMDatabase *db;
}
@end

@implementation AddContactsViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customUI];
    [self setupTemData];
    [self connectDatabase];
}

#pragma mark - CustomUI

- (void)customUI {
    self.txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{
        NSForegroundColorAttributeName: [UIColor grayColor]
     }];
    UIImageView *nameIcon = UIImageView.new;
    nameIcon.image = [UIImage imageNamed:@"name"];
    UIView *nameView = UIView.new;
    [nameView addSubview:nameIcon];
    nameView.frame = CGRectMake(5, 0, 22,22);
    nameIcon.frame = CGRectMake(5, 0, 22,22);
    self.txtName.leftView = nameView;
    self.txtName.leftViewMode = UITextFieldViewModeAlways;
    //
    self.txtPhoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone number" attributes:@{
        NSForegroundColorAttributeName: [UIColor grayColor]
     }];
    UIImageView *phoneIcon = UIImageView.new;
    phoneIcon.image = [UIImage imageNamed:@"phone"];
    UIView *phoneView = UIView.new;
    [phoneView addSubview:phoneIcon];
    phoneView.frame = CGRectMake(5, 0, 22,22);
    phoneIcon.frame = CGRectMake(5, 0, 22,22);
    self.txtPhoneNumber.leftView = phoneView;
    self.txtPhoneNumber.leftViewMode = UITextFieldViewModeAlways;
    //
    self.save.layer.cornerRadius = 5;
    self.clear.layer.cornerRadius = 5;
    self.txtName.text = self.name;
    self.txtPhoneNumber.text = self.phone;
}

#pragma mark - SetupData

- (void)setupTemData {
    self.txtName.delegate = self;
    self.txtPhoneNumber.delegate = self;
}

#pragma mark - UIButton

- (IBAction)btnSave:(id)sender {
    [self SaveData];
}

- (IBAction)btnClear:(id)sender {
    self.txtName.text = @"";
    self.txtPhoneNumber.text = @"";
}

#pragma mark - UITextfieldelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtName) {
        [self.txtPhoneNumber becomeFirstResponder];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.txtName) {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                return NO;
            }
        }
    } else if (textField == self.txtPhoneNumber) {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789 "];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark - FMDB

- (void)connectDatabase {
    path = @"Users/macbook/Desktop/demosqlite.db";
    db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        db = nil;
        return;
    } else {
        NSLog(@"Connect to database successfully!");
    }
}

- (void)SaveData {
    NSString *name = self.txtName.text;
    NSString *phoneNumber = self.txtPhoneNumber.text;
    if ([self.txtName.text length] == 0 || [self.txtPhoneNumber.text length] == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Name and phone number can't be empty!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:actionYes];
        [self presentViewController:alert animated:YES completion:nil];
    } else if ([self.idUpdate length] == 0) {
        FMResultSet *result = [db executeQuery:@"select * from contacts"];
        while ([result next]) {
            if ( [phoneNumber isEqual:[result stringForColumn:@"phonenumber"]]){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Massage" message:@"The phone number already exists" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:actionOk];
                [self presentViewController:alert animated:YES completion:nil];
                return ;
            }
        }
        BOOL isExecute = [db executeUpdate:@"insert into contacts (name,phonenumber) values(?,?)", name, phoneNumber];
        if (isExecute) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Massage" message:@"Save data successfully!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:actionOk];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Massage" message:@"save data failed!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:actionOk];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } else if ([self.idUpdate length] > 0) {
        BOOL isExecute = [db executeUpdate:@"update contacts set name = ?, phonenumber = ? where idcontact = ?",self.txtName.text,self.txtPhoneNumber.text,self.idUpdate];
        if (isExecute) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Massage" message:@"Update data successfully!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:actionOk];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Massage" message:@"Update data failed!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:actionOk];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

@end
