//
//  ViewController.h
//  SpeechToTextDemo
//
//  Created by JUNWEI WU on 2017-02-15.
//  For testing

#import <UIKit/UIKit.h>
#import "SpeechToTextModule.h"

@interface ViewController : UIViewController <SpeechToTextModuleDelegate>
{
    
}
@property(nonatomic, strong)SpeechToTextModule *speechToTextObj;
@end
