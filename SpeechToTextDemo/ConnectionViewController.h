//
//  ConnectionViewController.h
//  IOSClient
//
//  Created by Vian on 2017-02-15.
//  Copyright © 2017 Muhammad Zeeshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SpeechToTextModule.h"
@interface ConnectionViewController : UIViewController  <NSStreamDelegate,SpeechToTextModuleDelegate>
{
@public
}
-(void)setup;
-(void)connect;
-(void)close;
-(void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event;
-(void)readin:(NSString *)s;
-(void)writeOut:(NSString *)s;
@property(nonatomic, strong)SpeechToTextModule *speechToTextObj;
@end

