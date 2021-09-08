//
//  ViewController.h
//  SQliteQuanLyDanhSach
//
//  Created by Lê Công Minh on 23/08/2021.
//

#import <UIKit/UIKit.h>
#import <FMDB.h>
#import <FMDatabase.h>
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) FMDatabase *db;
@property (strong, nonatomic) NSMutableArray *listContact;
@end

