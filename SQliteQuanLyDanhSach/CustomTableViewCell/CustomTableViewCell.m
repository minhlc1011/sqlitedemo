//
//  CustomTableViewCell.m
//  SQliteQuanLyDanhSach
//
//  Created by Lê Công Minh on 24/08/2021.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI {
    self.viewContent.layer.cornerRadius = 10;
    self.update.layer.cornerRadius = 5;
    self.delete.layer.cornerRadius = 5;
}

- (IBAction)btnDelete:(id)sender {
    self.deleteButtonTapHandle();
}

- (IBAction)btnUpdate:(id)sender {
    self.updateButtonTapHandle();
}



@end
