//
//  ViewController.m
//  Localizing
//
//  Created by Jn.Huang on 2018/10/15.
//  Copyright © 2018年 huang. All rights reserved.
//

/*

 */


#import "ViewController.h"
#import "NSBundle+AppLanguageSwitch.h"
#import "LanguageLoadingViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, copy)NSString *curLanguage;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthLabel;

@property (nonatomic, assign)NSInteger number;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.label.text = NSLocalizedString(@"password", nil);
    [self.button setTitle:NSLocalizedString(@"press", nil) forState:UIControlStateNormal];
    

    self.curLanguage = [NSBundle getCusLanguage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChange:) name:ZZAppLanguageDidChangeNotification object:nil];
    
    
    //带参数的 NSLocalizedString
    self.birthLabel.text = [NSString stringWithFormat:NSLocalizedString(@"birth", nil),@"shenzhen"];
    
    //带参数 并且可以指定顺序的 NSLocalizedString
    self.fromLabel.text = [NSString stringWithFormat:NSLocalizedString(@"from", nil),@"shenzhen",@"hjn"];
}



- (IBAction)buttonPress:(id)sender {
    

    LanguageLoadingViewController *vc = [[LanguageLoadingViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{

        if ([self.curLanguage isEqualToString:@"en"]) {
            [NSBundle setCusLanguage:@"zh-Hans"];
        }else{
            [NSBundle setCusLanguage:@"en"];
        }
        
    }];
    
    
}

- (void)languageChange:(id)sender {
    
    if (self.isViewLoaded && !self.view.window) {
        //这里置为nil，当视图再次显示的时候会重新走viewDidLoad方法
        self.view = nil;
    }
    
}


@end
