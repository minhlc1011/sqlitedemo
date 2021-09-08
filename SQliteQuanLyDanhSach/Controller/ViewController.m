//
//  ViewController.m
//  SQliteQuanLyDanhSach
//
//  Created by Lê Công Minh on 23/08/2021.
//

#import "ViewController.h"
#import <FMDB.h>
#import <FMDatabase.h>
#import <FMResultSet.h>
#import "CustomTableViewCell.h"
#import "Contact.h"
#import "AddContactsViewController.h"
@interface ViewController ()

@end

@implementation ViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connectDatabase];
    [self configUI];
    [self setupTempData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.listContact removeAllObjects];
    [self queryContact];
    [self.myTable reloadData];
}

#pragma mark - FMDB

- (void)connectDatabase {
    self.path = @"Users/macbook/Desktop/demosqlite.db";
    self.db = [FMDatabase databaseWithPath:self.path];
    if (![self.db open]) {
        self.db = nil;
        return;
    } else {
        NSLog(@"Connect to database successfully!");
    }
}

- (void)queryContact {
    FMResultSet *result = [self.db executeQuery:@"select * from contacts"];
    while ([result next]) {
        Contact *contact = Contact.new;
        contact.idContact = [result stringForColumn:@"idcontact"];
        contact.name = [result stringForColumn:@"name"];
        contact.phoneNumber = [result stringForColumn:@"phonenumber"];
        [self.listContact addObject:contact];
    }
}

#pragma mark - ConfigUI

- (void)configUI {
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTable.separatorColor = [UIColor clearColor];
}

#pragma mark - SetupData

- (void)setupTempData {
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.listContact = NSMutableArray.new;
}

#pragma mark - UITableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listContact.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

#pragma mark - UITableviewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [self.myTable dequeueReusableCellWithIdentifier:@"cell"];
    [cell configUI];
    cell.lblName.text = [self.listContact[indexPath.row] valueForKey:@"name"];
    cell.lblPhoneNumber.text = [self.listContact[indexPath.row] valueForKey:@"phoneNumber"];
    cell.deleteButtonTapHandle = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message" message:@"Are you sure to delete?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [self.db executeUpdate:[NSString stringWithFormat:@"%@%@",@"delete from contacts where idcontact = ",[self.listContact[indexPath.row] valueForKey:@"idContact"]]];
            [self.listContact removeObjectAtIndex:indexPath.row];
            [self.myTable reloadData];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:actionYes];
        [alert addAction:actionNo];
        [self presentViewController:alert animated:YES completion:nil];
    };
    cell.updateButtonTapHandle = ^{
        AddContactsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
        view.idUpdate = [self.listContact[indexPath.row] valueForKey:@"idContact"];
        view.name = [self.listContact[indexPath.row] valueForKey:@"name"];
        view.phone = [self.listContact[indexPath.row] valueForKey:@"phoneNumber"];
        [self.navigationController pushViewController:view animated:YES];
    };
    
    return cell;
}

@end
