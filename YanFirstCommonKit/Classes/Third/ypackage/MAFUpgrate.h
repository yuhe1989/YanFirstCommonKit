//
//  Upgrate.h
//  GAEC
//
//  Created by victor on 13-6-28.
//  Copyright (c) 2013年 GAEC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAFUpgrate : NSObject

@property(nonatomic,copy) NSString* tag;
@property(nonatomic,copy) NSString* version_desc;
@property(nonatomic,copy) NSString* version_name;
@property(nonatomic,copy) NSString* version_num;
@property(nonatomic,copy) NSString* version_url;
@property(nonatomic,copy) NSString* appID;

@end
