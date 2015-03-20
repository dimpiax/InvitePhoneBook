//
//  ABRecordHolder.m
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

#import "ABRecordHolder.h"

@implementation ABRecordHolder

-(id)initWithRawData:(ABRecordRef)record name:(NSString *)name lastname:(NSString *)lastname {
    self = [super self];
    
    self.rawData = record;
    self.name = name;
    self.lastname = lastname;
    
    return self;
}

@end