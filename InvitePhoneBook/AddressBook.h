//
//  AddressBook.h
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBook : NSObject

-(void)requestRecords:(void (^)(NSArray *array, NSError *error))completion;

@end