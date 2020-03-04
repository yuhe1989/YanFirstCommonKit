//
//  CommonClass.m
//  GAEC
//
//  Created by victor on 13-7-22.
//  Copyright (c) 2013年 GAEC. All rights reserved.
//

#import "MAFCommonClass.h"
#import "XMLReader.h"
#import "MAFExpDate.h"

static MAFCommonClass *commonclass;


@interface MAFCommonClass ()

@end

@implementation MAFCommonClass
@synthesize userSelectIndex = _userSelectIndex;

+(MAFCommonClass *)shareCommonClass{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
         commonclass = [[MAFCommonClass alloc]init];
    });
    return commonclass;
}
-(void)analysisXMLFile:(NSString*)name
{
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    //名称要写全称
    NSString *path00 = [currentBundle pathForResource:name ofType:nil inDirectory:@"YanCommonKit.bundle"];
    NSLog(@"============ bundle path:%@", path00);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *appVwesion = [defaults valueForKey:@"appVersion"];
    NSData *xmlData = [NSData dataWithContentsOfFile:path00];
    NSError *error = nil;
    NSDictionary *xmldic = [XMLReader dictionaryForXMLData:xmlData error:&error];
    if ([appVwesion isEqualToString:[self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"AppVersion"]valueForKey:@"text"] ]]) {
        [self analysisXMLFileOfBasicInfo:name];
    } else {
        [self analysisXMLFileOfBasicInfo:name];
    }
}

-(void)analysisXMLFileOfBasicInfo:(NSString *)name
{
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    //图片名称要写全称
    NSString *path00 = [currentBundle pathForResource:name ofType:nil inDirectory:@"YanCommonKit.bundle"];
    
    NSLog(@"==========dddd== bundle path:%@", path00);
    
    NSData *xmlData = [NSData dataWithContentsOfFile:path00];
    NSError *error = nil;
    NSDictionary *xmldic = [XMLReader dictionaryForXMLData:xmlData error:&error];
    self.appID = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"AppID"]valueForKey:@"text"] ];
    self.layoutID = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"LayoutID"]valueForKey:@"text"] ];
    self.skinID = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"SkinID"]valueForKey:@"text"] ];
    self.departmentName = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"DepartmentName"]valueForKey:@"text"] ];
    self.departmentId = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"DepartmentId"]valueForKey:@"text"] ];
    self.background = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"BackgroundPicture"]valueForKey:@"text"] ];
    self.appVersion = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"AppVersion"]valueForKey:@"text"] ];
    self.PlatCode = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"PlatCode"]valueForKey:@"text"] ];
    self.baiduAppKey = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"]valueForKey:@"BaiduAppKey"]valueForKey:@"text"]];
    self.appNameKey = [self clearAllChar:[[[xmldic valueForKey:@"AppConfig"] valueForKey:@"AppNameKey"] valueForKey:@"text"]];
    self.themeConfig = [[xmldic valueForKey:@"AppConfig"] valueForKey:@"ThemeConfig"];
    self.appNamePath = [self getAppNamePath];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.appVersion forKey:@"appVersion"];
}
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
#pragma mark -
#pragma mark clear all char
-(id)clearAllChar:(NSString*)str
{
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return str;
}
#pragma mark -
#pragma mark 获取适应的屏幕的坐标
-(CGRect)makeRect:(CGRect)rect
{
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >6.1) {
        CGRect newrect = CGRectMake(rect.origin.x, rect.origin.y+64, rect.size.width, rect.size.height);
        return newrect;
    }
    else
    {
        return rect;
    }
}
#pragma mark -
#pragma mark 压缩图片
//本类作用给一个数值根据此数值对图片进行压缩达到最佳效果并根据当前时间得到图片的路径 存储到documents文件目录下面，返回一个dictionary
-(NSDictionary*)scaleToSize:(float)size image:(UIImage*)image
{
    sleep(1);
    CGSize afterScaleSize;
    //压缩成等比例的小图
    if (image.size.height>image.size.width) {
        afterScaleSize.height = size;
        afterScaleSize.width = (size/image.size.height)*image.size.width;
    } else {
        afterScaleSize.width = size;
        afterScaleSize.height = (size/image.size.width)*image.size.height;
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(afterScaleSize);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, afterScaleSize.width, afterScaleSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //小图的路径
    NSString *smallImagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"Library",@"/",@"Caches",@"/",@"small",[MAFExpDate getCurrentDateString:@"yyyyMMddHHmmssfff"],@".jpg"]];
    [UIImageJPEGRepresentation(scaledImage, 0.5) writeToFile:smallImagePath atomically:YES];
    //大图的路径
    NSString *bigImageName = [NSString stringWithFormat:@"%@%@",[MAFExpDate getCurrentDateString:@"yyyyMMddHHmmssfff"],@".jpg"];
    NSString *bigImagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@%@%@",@"Library",@"/",@"Caches",@"/",bigImageName]];
    [UIImageJPEGRepresentation(image, 0.3) writeToFile:bigImagePath atomically:YES];
    //字典
    NSDictionary *imagedictionary = [NSDictionary dictionaryWithObjectsAndKeys:image,@"bigImage",scaledImage,@"smallImage",bigImagePath,@"bigImagePath",smallImagePath,@"smallImagePath",bigImageName,@"bigImageName",nil];
    // 返回所有数据的字典
    return imagedictionary;
}
/**
 获取以app名称为名的文件夹路径
 */
- (NSString *)getAppNamePath {
    NSString *locationPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    if (self.appNameKey != nil || ![self.appNameKey isEqualToString:@""]) {
        locationPath = [locationPath stringByAppendingPathComponent:self.appNameKey];
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:locationPath]) {
        BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:locationPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bo) {
            locationPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        }
    }
    return locationPath;
}

@end
