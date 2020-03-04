//
//  RegisterRes.h
//  GAEC
//
//  Created by victor on 13-6-21.
//  Copyright (c) 2013年 GAEC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RegisterRes : NSObject
{
    //
    //标识码
    NSString * return_code;
    
    //
    //返回详情
    NSString * return_res;
}

@property(nonatomic,copy)NSString * return_code;
@property(nonatomic,copy)NSString * return_res;

@end
