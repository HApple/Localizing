//
//  UIButton+XIBLocalizable.m
//  Localizing
//
//  Created by Jn.Huang on 2018/10/15.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "UIButton+XIBLocalizable.h"
#import "NSString+Localize.h"
#import <objc/runtime.h>

@implementation UIButton (XIBLocalizable)
-(void)setXibLocKey:(NSString *)xibLocKey{
    [self setTitle:xibLocKey.localized forState:UIControlStateNormal];
}

-(NSString *)xibLocKey{
    return nil;
}

@end
