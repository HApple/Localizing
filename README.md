# Localizing
轻松搞定StoaryBoard / Xib多语言，App内切换多语言
###本文会用gif详细演示如何支持多语言，如何轻松搞定StroaryBoard / Xib的多语言,以及App内切换多语言。


# 首先让程序支持多语言
- 创建一个 Localizable 名字的文件，注意 L 一定要大写
- 切换到 Project 里，添加需要支持的语言，这里只做支持英文 中文
![Localize1.gif](https://upload-images.jianshu.io/upload_images/949605-a5482b6ec9e61ef8.gif?imageMogr2/auto-orient/strip)

# 上面步骤完后，会出现两个文件Localizable.strings(English) Localizable.strings(Simplified)

以 "key" = "value" 的方式添加多语言,如下图，左边的是英文，右边的是中文
![image.png](https://upload-images.jianshu.io/upload_images/949605-8b07fd50db0ef72c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 代码用NSLocalizedString(@"key", nil)调用
如：  

      self.label.text = NSLocalizedString(@"password", nil);
      [self.button setTitle:NSLocalizedString(@"press", nil) forState:UIControlStateNormal];



![Localize2.gif](https://upload-images.jianshu.io/upload_images/949605-301ab22e025dc454.gif?imageMogr2/auto-orient/strip)


# StoaryBoard/Xib多语言
#####通常如果StoaryBoard / Xib要支持多语言，有两种方法
- 一个是
![image.png](https://upload-images.jianshu.io/upload_images/949605-f92ba3a8bb5a0f72.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)
在Localization里勾选相应的Localizable Strings,这样每个StoaryBoard / Xib 都生成对应的几个Localizable Strings文件，一旦界面有改动，并不会同步到Localizable Strings文件里，很麻烦。

- 第二个办法
就是IBOutlet每个需要多语言的控件，有很多控件的文字就是写死的，这样做也是很麻烦

#####本文给出两个方法是让你在StoaryBoard / Xib界面上直接支持多语言 如 UILabel 控件，为UILable生成一个分类UILabel + XIBLocalizable,同理其他UIButton UITextField UITextVIew等都可以生成对应的分类，这里只举UILable作为例子。
 - 第一个办法利用IBInspectable修饰属性
      ```
      @interface UILabel (XIBLocalizabe)
      @property (nonatomic, copy)IBInspectable NSString *xibLocKey;
      @end

    ```
       @implementation UILabel (XIBLocalizabe)
        - (void)setXibLocKey:(NSString *)xibLocKey{
        self.text = xibLocKey.localized;
        }
        -  (NSString *)xibLocKey{
        return nil;
        }
        @end

这样在界面上会多出一个Label属性，赋值上多语言对应的key值即可

![171540263200_.pic.jpg](https://upload-images.jianshu.io/upload_images/949605-6b0608c3e054efb1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

![Localize3.gif](https://upload-images.jianshu.io/upload_images/949605-5328f5b02a8a0cc8.gif?imageMogr2/auto-orient/strip)


- 第二个办法 其实已经完成了，上面实现了setXibLocKey方法，我们可以在User Defined Runtime Attributes添加xibLocKey这个Key Path
![image.png](https://upload-images.jianshu.io/upload_images/949605-eca48ab2a772b3cd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)
![Localize4.gif](https://upload-images.jianshu.io/upload_images/949605-6ff6b4edd1735a4c.gif?imageMogr2/auto-orient/strip)

# App内切换多语言
这里引用了别人实现的 NSBundle+AppLanguageSwitch
简单讲讲实现过程
 ```
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
 ```
这里用了runtime的object_setClass,意思是将[NSBundle mainBundle]的对象指定到 ZZBundleEx 这个类上
 ```static const char kBundleKey = 0;
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
```
![Localize5.gif](https://upload-images.jianshu.io/upload_images/949605-bedbbaee2e45b7b3.gif?imageMogr2/auto-orient/strip)




# Demo
最后附上 [github Demo](https://github.com/HApple/Localizing)
