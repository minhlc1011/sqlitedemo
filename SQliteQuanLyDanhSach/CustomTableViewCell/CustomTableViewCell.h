//
//  CustomTableViewCell.h
//  SQliteQuanLyDanhSach
//
//  Created by Lê Công Minh on 24/08/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (strong, nonatomic) IBOutlet UIButton *update;
@property (strong, nonatomic) IBOutlet UIButton *delete;
- (IBAction)btnUpdate:(id)sender;
- (IBAction)btnDelete:(id)sender;
@property (nonatomic, copy) void(^deleteButtonTapHandle)(void);
@property (nonatomic, copy) void(^updateButtonTapHandle)(void);
-(void) configUI;

@end

NS_ASSUME_NONNULL_END
