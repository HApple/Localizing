//
//  UITextField+XIBLocalizable.m
//  Localizing
//
//  Created by Jn.Huang on 2018/10/15.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "UITextField+XIBLocalizable.h"
#import "NSString+Localize.h"
#import <objc/runtime.h>

@implementation UITextField (XIBLocalizable)

-(void)setXibLocplaceHKey:(NSString *)xibLocplaceHKey{
    self.placeholder = xibLocplaceHKey;
}

-(NSString *)xibLocplaceHKey{
    return nil;
}

@end
