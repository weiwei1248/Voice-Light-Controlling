//
//  ConnectionViewController.m
//  IOSClient
//
//  Created by JUNWEI WU on 2017-02-15.
//


#import "ConnectionViewController.h"

@interface ConnectionViewController ()
{
    __weak IBOutlet UITextView *text_Voice;
    __weak IBOutlet UITextView *text_Receive;
    __weak IBOutlet UITextField *text_port;
    __weak IBOutlet UITextField *text_host;
    __weak IBOutlet UIButton *btn_connect;
    
    __weak IBOutlet UILabel *status_label;
    __weak IBOutlet UILabel *result_label;
}
@property (strong, nonatomic)NSInputStream        *inputStream;
@property (strong, nonatomic)NSOutputStream       *outputStream;

@end

@implementation ConnectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.speechToTextObj = [[SpeechToTextModule alloc] initWithCustomDisplay:@"SineWaveViewController"];
    [self.speechToTextObj setDelegate:self];
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scrollTextToBottom) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate distantPast]];
    if([Data sharedInstance].isConnect==YES)
    {
        [btn_connect setEnabled:NO];
        text_host.text=[Data sharedInstance].ip_address;
        text_port.text=[NSString stringWithFormat:@"%d",[Data sharedInstance].port_address];
        [self connect];
    }
    [self setBackgroundmode];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackgroundmode
{
    self.view.backgroundColor=[Data sharedInstance].mainView;
    text_Receive.backgroundColor=[Data sharedInstance].textView;
    text_Voice.textColor=[Data sharedInstance].viewText;
    text_Receive.textColor=[Data sharedInstance].labelText;
    status_label.textColor=[Data sharedInstance].viewText;
    result_label.textColor=[Data sharedInstance].viewText;
    text_Voice.backgroundColor=[Data sharedInstance].voiceView;
}

- (IBAction)connectButtonTapped:(UIButton *)sender
{
    [Data sharedInstance].outputString=@"Searching server...\n";
    [self connect];
}

- (IBAction)recordSpeechButtonTapped:(UIButton *)sender
{
    [self.speechToTextObj beginRecording];
}

-(void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent
{
    switch(streamEvent)
    {
        case NSStreamEventOpenCompleted:
            [Data sharedInstance].outputString=@"Connect successfully.\nYou can speaking now.\n";
            [Data sharedInstance].isConnect=YES;
            [btn_connect setEnabled:NO];
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
            [Data sharedInstance].outputString=@"Cannot connect to the server.\nIP address or PORT address is wrong!";
            break;
        case NSStreamEventEndEncountered:
            [Data sharedInstance].outputString=[[Data sharedInstance].outputString stringByAppendingFormat:@"Connection is closed.\n"];
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream=nil;
            [Data sharedInstance].isConnect=NO;
            break;
        default:
            break;
    }
}

-(void)connect
{
    [Data sharedInstance].ip_address=text_host.text;
    [Data sharedInstance].port_address=[text_port.text intValue];
    
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

- (void)sendMessage:(NSString*)string
{
    NSMutableData *data=[[NSMutableData alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];;
//    switch ([Data sharedInstance].language_select) {
//        case 0:
//            data=[[NSMutableData alloc] initWithData:[string dataUsingEncoding:NSASCIIStringEncoding]];
//            break;
//        case 1:
//            data=[[NSMutableData alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
//            break;
//        default:
//            break;
//    }
    [self.outputStream write:[data bytes] maxLength:[data length]];
    [Data sharedInstance].outputString=[[Data sharedInstance].outputString stringByAppendingFormat:@"Message: (%@) is sending.\n",string];
}

/*VOICE TEXT*/
- (BOOL)didReceiveVoiceResponse:(NSData *)data
{
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"responseString: %@",responseString);
    NSRange range = [responseString rangeOfString:@"\n"];
    NSString *finalSpeech;
    if (range.location != NSNotFound)
    {
        NSString *resultString = [responseString substringFromIndex:range.location];
        NSLog(@"%@",resultString);
        NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        NSArray *arrResult = [dic objectForKey:@"result"];
        NSDictionary *speech = [[[arrResult objectAtIndex:0] valueForKey:@"alternative"]objectAtIndex:0];
        finalSpeech = [speech objectForKey:@"transcript"];
    }
    
    [Data sharedInstance].voiceString=[text_Voice.text stringByAppendingFormat:@"%@\n", finalSpeech];
    
    if([Data sharedInstance].isConnect==YES)
    {
        [self sendMessage:finalSpeech];
    }
    return YES;
}

-(void)scrollTextToBottom
{
    if(text_Receive.text.length>0)
    {
        NSRange bottom=NSMakeRange(text_Receive.text.length-1, 1);
        [text_Receive scrollRangeToVisible:bottom];
    }
    if(text_Voice.text.length>0)
    {
        NSRange bottom=NSMakeRange(text_Voice.text.length-1, 1);
        [text_Voice scrollRangeToVisible:bottom];
    }
    
    text_Voice.text=[Data sharedInstance].voiceString;
    text_Receive.text=[Data sharedInstance].outputString;

}

@end




