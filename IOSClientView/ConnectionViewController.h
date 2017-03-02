//
//  ConnectionViewController.h
//  IOSClient
//
//  Created by JUNWEI WU on 2017-02-15.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SpeechToTextModule.h"
#import "Data.h"
@interface ConnectionViewController : UIViewController  <NSStreamDelegate,SpeechToTextModuleDelegate>
{
    @public
}
-(void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent;
@property(nonatomic, strong)SpeechToTextModule *speechToTextObj;

-(void)scrollTextToBottom;
-(void)setBackgroundmode;

@end

