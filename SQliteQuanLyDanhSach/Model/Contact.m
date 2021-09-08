//
//  Contact.m
//  SQliteQuanLyDanhSach
//
//  Created by Lê Công Minh on 24/08/2021.
//

#import "Contact.h"

@implementation Contact
- (id)initContactWithName: (NSString*)name phoneNumber:(NSString*)phoneNumber {
    self.name = name;
    self.phoneNumber = phoneNumber;
    return self;
}
@end
