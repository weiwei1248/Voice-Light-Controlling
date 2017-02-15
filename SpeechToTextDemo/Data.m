//
//  Data.m
//  IOSClient
//
//  Created by Vian on 2017-02-15.
//  Copyright © 2017 Muhammad Zeeshan. All rights reserved.
//

#import "Data.h"

@implementation Data
@synthesize language_select;

-(id)init
{
    if(self=[super init])
    {
        language_select=0;
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
@end
