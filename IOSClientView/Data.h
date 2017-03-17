//
//  Data.h
//  IOSClient
//
//  Created by JUNWEI WU on 2017-02-15.
//  This is for statistics saving 

#import <Foundation/Foundation.h>

@interface Data : NSObject
{
    int language_select;            //language status
    int mode_select;                //interface mode status
    UIColor *mainView;
    UIColor *labelText;
    
    NSString *ip_address;           //for tcp Connection
    int port_address;
    BOOL isConnect;                 //connection status
    
    NSString *outputString;
    NSString *voiceString;
}
@property (nonatomic) int language_select;
@property (nonatomic) int mode_select;
@property (strong,nonatomic) UIColor *mainView;
@property (strong,nonatomic) UIColor *labelText;
@property (strong,nonatomic) NSString *ip_address;
@property (strong,nonatomic) NSString *outputString;
@property (strong,nonatomic) NSString *voiceString;
@property (nonatomic) int port_address;
@property (nonatomic) BOOL isConnect;
+(Data *)sharedInstance;
-(void)changeMode:(int)mode;
@end
