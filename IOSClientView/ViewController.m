//
//  ViewController.m
//  SpeechToTextDemo
//
//  Created by JUNWEI WU on 2017-02-15.
//
#import "ViewController.h"

@interface ViewController ()
{
    __weak IBOutlet UITextView *voiceText;
    __weak IBOutlet UITextView *outputText;
    
    __weak IBOutlet UILabel *process_label;
    __weak IBOutlet UILabel *result_label;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.speechToTextObj = [[SpeechToTextModule alloc] initWithCustomDisplay:@"SineWaveViewController"];
    [self.speechToTextObj setDelegate:self];
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollTextToBottom) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate distantPast]];
    [self setBackgroundmode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackgroundmode
{
    self.view.backgroundColor=[Data sharedInstance].mainView;
    process_label.textColor=[Data sharedInstance].labelText;
    result_label.textColor=[Data sharedInstance].labelText;
}

#pragma mark - My IBActions -
- (IBAction)recordSpeechButtonTapped:(UIButton *)sender
{
    [self.speechToTextObj beginRecording];
}
#pragma mark - SpeechToTextModule Delegate -
- (BOOL)didReceiveVoiceResponse:(NSData *)data
{
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"responseString: %@",responseString);
    outputText.text=[outputText.text stringByAppendingFormat:@"%@\n",responseString];
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
    voiceText.text=[voiceText.text stringByAppendingFormat:@"%@\n",finalSpeech];
    return YES;
}

-(void)scrollTextToBottom
{
    if(outputText.text.length>0)
    {
        NSRange bottom=NSMakeRange(outputText.text.length-1, 1);
        [outputText scrollRangeToVisible:bottom];
    }
    if(voiceText.text.length>0)
    {
        NSRange bottom=NSMakeRange(voiceText.text.length-1, 1);
        [voiceText scrollRangeToVisible:bottom];
    }
}


@end

