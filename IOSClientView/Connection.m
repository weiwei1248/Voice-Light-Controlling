//
//  Connection.m
//  IOSClient
//
//  Created by JUNWEI WU on 2017-03-02.
//

#import "Connection.h"
@interface Connection ()

@end

@implementation Connection

-(id)init
{
    if(self=[super init])
    {
       
    }
    return self;
}

-(void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent
{
    switch(streamEvent)
    {
        case NSStreamEventOpenCompleted:
            [Data sharedInstance].outputString=@"Connect successfully.\nYou can speaking now.\n";
            [Data sharedInstance].isConnect=YES;
            break;
        case NSStreamEventHasBytesAvailable:
            if(theStream==self.inputStream)
            {
                while([self.inputStream hasBytesAvailable])
                {
                    uint8_t buffer[1024];
                    unsigned int len=0;
                    len=[self.inputStream read:buffer maxLength:sizeof(buffer)];
                    if(len>0)
                    {
                        NSString *output=[[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        if(nil!=output)
                        {
                            [Data sharedInstance].outputString=[[Data sharedInstance].outputString stringByAppendingFormat:@"Server: %@\n",output];
                        }
                    }
                }
            }
            break;
        case NSStreamEventErrorOccurred:
            [Data sharedInstance].outputString=@"Cannot connect to the server.\nIP address or PORT address is wrong!\n";
            break;
        case NSStreamEventEndEncountered:
            [self close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream=nil;
            break;
        default:
            break;
    }
}

-(void)connect
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(NULL,(__bridge CFStringRef)[Data sharedInstance].ip_address,[Data sharedInstance].port_address,&readStream,&writeStream);
    
    self.inputStream = (__bridge_transfer NSInputStream *)readStream;
    self.outputStream = (__bridge_transfer NSOutputStream*)writeStream;
    
    [self.inputStream setDelegate:self];
    [self.outputStream setDelegate:self];
    
    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.inputStream open];
    [self.outputStream open];
    
}

- (void)close
{
    [Data sharedInstance].outputString=[[Data sharedInstance].outputString stringByAppendingFormat:@"Connection is closed.\n"];
    [self.inputStream close];
    [self.outputStream close];
    [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.inputStream setDelegate:nil];
    [self.outputStream setDelegate:nil];
    self.inputStream = nil;
    self.outputStream = nil;
    [Data sharedInstance].isConnect=NO;
}

- (void)sendMessage:(NSString*)string
{
    NSMutableData *data=[[NSMutableData alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    [self.outputStream write:[data bytes] maxLength:[data length]];
    [Data sharedInstance].outputString=[[Data sharedInstance].outputString stringByAppendingFormat:@"Client: (%@) is sending.\n",string];
}


+(Connection *)sharedInstance
{
    static Connection *_sharedInstace=nil;
    if(_sharedInstace==nil)
    {
        _sharedInstace=[[Connection alloc] init];
    }
    return _sharedInstace;
}


@end
