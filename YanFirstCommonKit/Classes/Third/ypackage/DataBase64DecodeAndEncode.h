//
//  DataBase64DecodeAndEncode.h
//  ICRM
//
//  Created by zhao ke on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBase64DecodeAndEncode : NSObject
+(NSData *)base64Decode:(NSString *)string;
+(NSString *)base64Encode:(NSData *)data;
@end
