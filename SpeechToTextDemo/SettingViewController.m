//
//  SettingViewController.m
//  IOSClient
//
//  Created by Vian on 2017-02-15.
//  Copyright © 2017 Muhammad Zeeshan. All rights reserved.
//


#import "SettingViewController.h"

@interface SettingViewController ()
{
    __weak IBOutlet UISegmentedControl *btn_language;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    btn_language.selectedSegmentIndex=[Data sharedInstance].language_select;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) changeLanguage{
    
    switch (btn_language.selectedSegmentIndex) {
        case 0:
            [Data sharedInstance].language_select=0;
            break;
        case 1:
            [Data sharedInstance].language_select=1;
            break;
        default:
            break;
    }
    
}

@end
