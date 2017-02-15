//
//  ViewController.m
//  SpeechToTextDemo
//
//  Created by Muhammad Zeeshan on 12/15/13.
//  Copyright (c) 2013 Muhammad Zeeshan. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()
{
    __weak IBOutlet UITextView *voiceText;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.speechToTextObj = [[SpeechToTextModule alloc] initWithCustomDisplay:@"SineWaveViewController"];
    [self.speechToTextObj setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [voiceText setText:finalSpeech];
    [self.speechToTextObj CheckList:finalSpeech];
    return YES;
}
- (void)showLoadingView
{
    NSLog(@"show loadingView");
}
- (void)requestFailedWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
}


@end

