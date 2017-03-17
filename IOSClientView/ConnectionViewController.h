//
//  ConnectionViewController.h
//  IOSClient
//
//  Created by JUNWEI WU on 2017-02-15.
//  Including TCP connection and voice recording

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SpeechToTextModule.h"
#import "Data.h"
#import "Connection.h"
@interface ConnectionViewController : UIViewController  <SpeechToTextModuleDelegate>

@property(nonatomic, strong)SpeechToTextModule *speechToTextObj;

-(void)scrollTextToBottom;
-(void)setBackgroundmode;

@end

