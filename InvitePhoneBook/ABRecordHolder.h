//
//  ABRecordHolder.h
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ABRecordHolder : NSObject

@property (nonatomic) ABRecordRef rawData;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastname;

-(id)initWithRawData:(ABRecordRef)record name:(NSString *)name lastname:(NSString *)lastname;

@end