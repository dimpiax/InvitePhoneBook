//
//  AddressBook.m
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

#import "AddressBook.h"
#import <AddressBookUI/AddressBookUI.h>
#import "ABRecordHolder.h"

@implementation AddressBook

-(void)requestRecords:(void (^)(NSArray *array, NSError *error))completion {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if(granted) {
            completion([self processContacts: addressBook], nil);
        }
        else {
            completion(nil, (__bridge NSError *)(error));
        }
    });
}

-(NSArray *)processContacts:(ABAddressBookRef)addressBook {
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    int count = (int)CFArrayGetCount(people);
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < count; i++) {
        ABRecordRef record = CFArrayGetValueAtIndex(people, i);
        
        NSString *name = (__bridge NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty);
        NSString *lastname = (__bridge NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
        
        name = [self getValue:name orDefault:@""];
        lastname = [self getValue:lastname orDefault:@""];
        
        ABRecordHolder *recordHolder = [[ABRecordHolder alloc] initWithRawData:record name:name lastname:lastname];
        
        [arr addObject: recordHolder];
    }
    
    return (NSArray *)[arr copy];
}

-(NSString *)getValue:(NSString *)value orDefault:(NSString *)defaultValue {
    BOOL isExist = !(value == (id)[NSNull null] || value.length == 0);
    if(isExist) return value;
    return defaultValue;
}

@end
