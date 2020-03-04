//
//  AFNetDownloadAreaData.m
//  MAF
//
//  Created by joy 尹 on 2019/12/12.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import "AFNetDownloadAreaData.h"
#import "AFNetworking.h"

@implementation AFNetDownloadAreaData



+ (void)judegFileExist{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath = [documents stringByAppendingString:@"/area_data.db"];
    if (![self isExistsAtPath:filePath]) {
        [self downloadAreaData];
    }
    
}

#pragma mark - 判断文件(夹)是否存在
+ (BOOL)isExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


+ (void)downloadAreaData{
    
    /* 创建网络下载对象 */
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSString * urlStr = [NSString stringWithFormat:@"http://222.173.29.165:18899/soft/area_data.db"];
    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    /* 下载路径 */
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    
    NSURLSessionDownloadTask * downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error) {
         NSLog(@"DB下载完成");
    }];

    
    [downloadTask resume];
}

@end
