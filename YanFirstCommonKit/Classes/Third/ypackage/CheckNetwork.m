//
//  CheckNetwork.m
//  iphone.network1
//
//  Created by wangjun on 10-12-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CheckNetwork.h"
#import "Reachability.h"
@implementation CheckNetwork
+(BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *r = [Reachability reachabilityWithHostname:@"114.114.114.114"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=NO;
            //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            //  NSLog(@"正在使用wifi网络");
            break;
    }
    //	if (!isExistenceNetwork) {
    //		UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请连接wifi或3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    //		[myalert show];
    //		[myalert release];
    //	}
    return isExistenceNetwork;
}


+(BOOL)isExistenceNetworkNoTips
{
    BOOL isExistenceNetwork;
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=NO;
            //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            //  NSLog(@"正在使用wifi网络");
            break;
    }
    return isExistenceNetwork;
}

+(BOOL)isExistenceNetworkTwo
{
    BOOL isExistenceNetworkTwo;
    Reachability *r = [Reachability reachabilityWithHostname:@"114.114.114.114"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetworkTwo=NO;
            //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetworkTwo=YES;
            //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetworkTwo=YES;
            //  NSLog(@"正在使用wifi网络");
            break;
    }
    return isExistenceNetworkTwo;
}

+(BOOL)is4gNetwork {
    BOOL is4g;
    Reachability *r = [Reachability reachabilityWithHostname:@"114.114.114.114"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            is4g=NO;
            //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            is4g=YES;
            //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            is4g=NO;
            //  NSLog(@"正在使用wifi网络");
            break;
    }
    return is4g;
}


@end
