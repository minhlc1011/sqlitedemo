//
//  AddContactsViewController.h
//  SQliteQuanLyDanhSach
//
//  Created by Lê Công Minh on 23/08/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddContactsViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (strong, nonatomic) IBOutlet UIButton *save;
@property (strong, nonatomic) IBOutlet UIButton *clear;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *idUpdate;
- (IBAction)btnClear:(id)sender;
- (IBAction)btnSave:(id)sender;

@end

NS_ASSUME_NONNULL_END
