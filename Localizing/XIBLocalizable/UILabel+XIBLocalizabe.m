//
//  UILabel+XIBLocalizabe.m
//  Localizing
//
//  Created by Jn.Huang on 2018/10/15.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "UILabel+XIBLocalizabe.h"
#import "NSString+Localize.h"
#import <objc/runtime.h>

@implementation UILabel (XIBLocalizabe)

-(void)setXibLocKey:(NSString *)xibLocKey{
    self.text = xibLocKey.localized;
}

-(NSString *)xibLocKey{
    return nil;
}

@end
