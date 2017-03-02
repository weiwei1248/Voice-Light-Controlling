//
//  Connect.m
//  IOSClient
//
//  Created by Vian on 2017-03-02.
//  Copyright © 2017 Muhammad Zeeshan. All rights reserved.
//

#import "Connect.h"

@implementation Connect

-(id)init
{
    if(self=[super init])
    {

    }
    return self;
}

+(Connect *)sharedInstance
{
    static Connect *_sharedInstace=nil;
    if(_sharedInstace==nil)
    {
        _sharedInstace=[[Connect alloc] init];
    }
    return _sharedInstace;
}

@end
