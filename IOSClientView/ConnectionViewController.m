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
    __weak IBOutlet UIButton *btn_close;
    
    __weak IBOutlet UILabel *status_label;
    __weak IBOutlet UILabel *result_label;
}

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
       // [self connect];
    }
    [self setBackgroundmode];
    [btn_close setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackgroundmode
{
    self.view.backgroundColor=[Data sharedInstance].mainView;
    status_label.textColor=[Data sharedInstance].labelText;
    result_label.textColor=[Data sharedInstance].labelText;
}

- (IBAction)connectButtonTapped:(UIButton *)sender
{
    [Data sharedInstance].outputString=@"Searching server...\n";
    [Data sharedInstance].ip_address=text_host.text;
    [Data sharedInstance].port_address=[text_port.text intValue];
    [[Connection sharedInstance] connect];
}

- (IBAction)recordSpeechButtonTapped:(UIButton *)sender
{
    [self.speechToTextObj beginRecording];
}

- (IBAction)closeButtonTapped:(UIButton *)sender
{
    [[Connection sharedInstance] close];
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
        if([finalSpeech length]==0)
        {
            [[Connection sharedInstance] sendMessage:@"Recogonize failed."];
        }
        else
        {
            [[Connection sharedInstance] sendMessage:finalSpeech];
        }
        
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
    
    if([Data sharedInstance].isConnect==YES)
    {
        [btn_connect setEnabled:NO];
        [btn_close setEnabled:YES];
    }
    else
    {
        [btn_connect setEnabled:YES];
        [btn_close setEnabled:NO];
    }
}

@end




