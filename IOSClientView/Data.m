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
@synthesize labelText;
@synthesize mainView;
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
        labelText=[UIColor blackColor];
        mainView=[UIColor whiteColor];
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
            labelText=[UIColor blackColor];
            mainView=[UIColor whiteColor];
            break;
        case 1:                           //night
            labelText=[UIColor whiteColor];
            mainView=[UIColor blackColor];
            break;
        default:
            break;
    }
}
@end
