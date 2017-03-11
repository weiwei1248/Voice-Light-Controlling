//
//  Tool.h
//  IOSClient
//
//  Created by Vian on 2017-03-10.
//  Copyright © 2017 Muhammad Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tool.h"

@interface Tool : NSObject
{

}

+(Tool *)sharedInstance;
-(NSString *)REG_W:(NSString *)voice;

@end

