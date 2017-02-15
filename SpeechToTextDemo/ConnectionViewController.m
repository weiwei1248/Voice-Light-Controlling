//
//  ConnectionViewController.m
//  IOSClient
//
//  Created by Vian on 2017-02-15.
//  Copyright © 2017 Muhammad Zeeshan. All rights reserved.
//


#import "ConnectionViewController.h"

@interface ConnectionViewController ()
{
    __weak IBOutlet UITextView *text_Voice;
    __weak IBOutlet UITextView *text_Receive;
    __weak IBOutlet UITextField *text_port;
    __weak IBOutlet UITextField *text_host;
}


@end
CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;
@implementation ConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectButtonTapped:(UIButton *)sender
{
    NSLog(@"connecting........");
    [self setup];
    
}
- (IBAction)cancelButtonTapped:(UIButton *)sender
{
    NSLog(@"connecting........");
    [self close];
    
}
-(void)setup
{
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"222.222.222.19", 10101, &readStream, &writeStream);
    if(!CFWriteStreamOpen(writeStream)) {
        NSLog(@"Error, writeStream not open");
        return;
    }
    [self connect];
    NSLog(@"Status of outputStream: %i",[outputStream streamStatus]);
    return;
}

-(void)connect
{
    NSLog(@"Connecting streams.");
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
}

-(void)close
{
    NSLog(@"Closing streams.");
    
    [inputStream close];
    [outputStream close];
    
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    
    inputStream=nil;
    outputStream=nil;
    
}

-(void)stream:(id)stream handleEvent:(NSStreamEvent)event
{
    NSLog(@"stream trigged.");
    switch (event) {
        case NSStreamEventHasSpaceAvailable:{
            if(stream==outputStream)
            {
                NSLog(@"outputStream is ready.");
            }
            break;
        }
        case NSStreamEventHasBytesAvailable:{
            if(stream==inputStream)
            {
                NSLog(@"inputStream is ready.");
                
                uint8_t buffer[1024];
                unsigned int len=0;
                len=[inputStream read:buffer maxLength:1024];
                if(len>0)
                {
                    NSMutableData *data=[[NSMutableData alloc]initWithLength:0];
                    [data appendBytes:(const void*)buffer length:len];
                    NSString *s=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
                    [self readin:s];
                    
                }
            }
            break;
        }
        default:{
            NSLog(@"Stream is sending an Event: %i",event);
            break;
        }
    }
}

-(void)readin:(NSString *)s
{
    NSLog(@"Reading in the following:");
    //method
}

-(void)writeOut:(NSString *)s
{
    
}


@end




