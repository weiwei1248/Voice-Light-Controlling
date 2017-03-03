//
//  SettingViewController.m
//  IOSClient
//
//  Created by JUNWEI WU on 2017-02-15.
//


#import "SettingViewController.h"

@interface SettingViewController ()
{
    __weak IBOutlet UISegmentedControl *btn_language;
    __weak IBOutlet UISegmentedControl *btn_mode;
    __weak IBOutlet UILabel *languge_label;
    __weak IBOutlet UILabel *mode_label;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    btn_language.selectedSegmentIndex=[Data sharedInstance].language_select;
    btn_mode.selectedSegmentIndex=[Data sharedInstance].mode_select;
    [self setBackgroundmode];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackgroundmode
{
    self.view.backgroundColor=[Data sharedInstance].mainView;
    languge_label.textColor=[Data sharedInstance].labelText;
    mode_label.textColor=[Data sharedInstance].labelText;
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

-(IBAction) changeMode{
    switch (btn_mode.selectedSegmentIndex) {
        case 0:
            [[Data sharedInstance]changeMode:0];
            break;
        case 1:
            [[Data sharedInstance]changeMode:1];
            break;
        default:
            break;
    }
    [self setBackgroundmode];
}
@end
