//
//  Contact.h
//  SQliteQuanLyDanhSach
//
//  Created by Lê Công Minh on 24/08/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject
@property (strong,nonatomic) NSString *idContact;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *phoneNumber;
- (id)initContactWithName: (NSString*)name phoneNumber:(NSString*)phoneNumber;
@end

NS_ASSUME_NONNULL_END
