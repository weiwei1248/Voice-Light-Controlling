//
//  Data.m
//  IOSClient
//
//  Created by JUNWEI WU on 2017-02-15.
//

#import "Data.h"

@implementation Data
@synthesize language_select;
@synthesize mode_select;
@synthesize viewText;
@synthesize labelText;
@synthesize mainView;
@synthesize textView;
@synthesize voiceView;
@synthesize ip_address;
@synthesize port_address;
@synthesize isConnect;
@synthesize outputString;
@synthesize voiceString;
-(id)init
{
    if(self=[super init])
    {
        language_select=0;
        mode_select=0;
        textView=[UIColor blackColor];
        viewText=[UIColor blackColor];
        labelText=[UIColor whiteColor];
        mainView=[UIColor whiteColor];
        voiceView=[UIColor whiteColor];
        port_address=0;
        isConnect=NO;
        outputString=@"There is no connection.";
    }
    return self;
}

+(Data *)sharedInstance
{
    static Data *_sharedInstace=nil;
    if(_sharedInstace==nil)
    {
        _sharedInstace=[[Data alloc] init];
    }
    return _sharedInstace;
}

-(void)changeMode:(int)mode
{
    mode_select=mode;
    switch (mode) {
        case 0:                           //day
            textView=[UIColor blackColor];
            viewText=[UIColor blackColor];
            labelText=[UIColor whiteColor];
            mainView=[UIColor whiteColor];
            voiceView=[UIColor blackColor];
            break;
        case 1:                           //night
            textView=[UIColor whiteColor];
            viewText=[UIColor whiteColor];
            labelText=[UIColor blackColor];
            mainView=[UIColor blackColor];
            voiceView=[UIColor blackColor];
            break;
        default:
            break;
    }
}
@end
