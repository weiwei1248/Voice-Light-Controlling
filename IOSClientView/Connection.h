//
//  Connection.h
//  IOSClient
//
//  Created by Vian on 2017-03-02.
//  Copyright © 2017 Muhammad Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"
#import "Tool.h"

@interface Connection : NSObject <NSStreamDelegate>
{
    @public
}
+(Connection *)sharedInstance;
-(void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent;
- (void)sendMessage:(NSString*)string;
- (void)close;
-(void)connect;

@property (strong, nonatomic)NSInputStream        *inputStream;
@property (strong, nonatomic)NSOutputStream       *outputStream;
@end
