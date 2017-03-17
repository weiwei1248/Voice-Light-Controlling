//
//  Connection.h
//  IOSClient
//
//  Created by Junwei Wu on 2017-03-02.
//  This is for TCP connection

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
