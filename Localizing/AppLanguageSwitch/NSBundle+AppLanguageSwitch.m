//
//  NSBundle+AppLanguageSwitch.m
//  https://github.com/zengqingf/iOSAppLanguageSwitch
//
//  Created by zengqingfu on 2017/6/13.
//  Copyright © 2017年 zengqingfu. All rights reserved.
//

#import "NSBundle+AppLanguageSwitch.h"
#import <objc/runtime.h>


NSString * const ZZAppLanguageDidChangeNotification = @"cc.devfu.languagedidchange";

static const char kBundleKey = 0;
@interface ZZBundleEx : NSBundle
@end

@implementation ZZBundleEx

/*ZZBundleEx继承自NSBundle
并重写了 - (NSString *)localizedStringForKey:(NSString *)key value:(nullable NSString *)value table:(nullable NSString *)tableName 方法
 从NSBundle+AppLanguageSwitch的分类里取出关联属性 NSBundle值 ，这个值（即xxx.lproj的一个文件）是我们在分类里设定的对应语言的值，所以能达到在APP内切换语言的效果
 bundle :  .../Localizing.app/zh-Hans.lproj  中文
 bundle :  .../Localizing.app/en.lproj  英文
*/
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &kBundleKey);
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    } else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}
@end


static NSString *AppLanguageSwitchKey = @"App_Language_Switch_Key";
@implementation NSBundle (AppLanguageSwitch)
+ (void)setCusLanguage:(NSString *)language {
    id value = nil;
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    if (language) {
        value = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]];
        NSAssert(value != nil, @"value不能为空,请检查参数是否正确");
        [df setObject:language forKey:AppLanguageSwitchKey];
        [df synchronize];
    } else {
        [df removeObjectForKey:AppLanguageSwitchKey];
        [df synchronize];
    }
    objc_setAssociatedObject([NSBundle mainBundle], &kBundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[NSNotificationCenter defaultCenter] postNotificationName:ZZAppLanguageDidChangeNotification object:nil];
}

+ (NSString *)getCusLanguage {
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *language = [df objectForKey:AppLanguageSwitchKey];
    return language;
}

+ (void)restoreSysLanguage {
    [self setCusLanguage:nil];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle],[ZZBundleEx class]);
        NSString *language = [self getCusLanguage];
        if (language) {
            [self setCusLanguage:language];
        }
    });
}
@end
