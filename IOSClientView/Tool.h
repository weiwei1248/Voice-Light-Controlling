//
//  Tool.h
//  IOSClient
//
//  Created by Junwei Wu on 2017-03-10.
//  This is to translate voice to commands

#import <Foundation/Foundation.h>
#import "Tool.h"

@interface Tool : NSObject
{

}

+(Tool *)sharedInstance;
-(NSString *)REG_W:(NSString *)voice;

@end

