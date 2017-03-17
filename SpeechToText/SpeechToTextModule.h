//
//  VoiceAddModule.h
//  AstridiPhone
//
//  Created by JUNWEI WU on 2017-02-15.
//  Including method of voice recogonization and API key installing

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <speex/speex.h>
#import "SineWaveViewController.h"
#import "Data.h"

#define kNumberBuffers 3
#define kNumVolumeSamples 10
#define kSilenceThresholdDB -30.0

#define kVolumeSamplingInterval 0.05
#define kSilenceTimeThreshold 0.9
#define kSilenceThresholdNumSamples kSilenceTimeThreshold / kVolumeSamplingInterval

// For scaling display
#define kMinVolumeSampleValue 0.01
#define kMaxVolumeSampleValue 1.0
typedef struct AQRecorderState {
    AudioStreamBasicDescription  mDataFormat;                   
    AudioQueueRef                mQueue;                        
    AudioQueueBufferRef          mBuffers[kNumberBuffers];                    
    UInt32                       bufferByteSize;                
    SInt64                       mCurrentPacket;                
    bool                         mIsRunning;
    
    SpeexBits                    speex_bits; 
    void *                       speex_enc_state;
    int                          speex_samples_per_frame;
    __unsafe_unretained NSMutableData *              encodedSpeexData;
    
    __unsafe_unretained id selfRef;
} AQRecorderState;

@protocol SpeechToTextModuleDelegate <NSObject>

// Delegate will need to parse JSON and dismiss loading view if presented
// returns true on success, false on failure
- (BOOL)didReceiveVoiceResponse:(NSData *)data;

@optional
- (void)showSineWaveView:(SineWaveViewController *)view;
- (void)dismissSineWaveView:(SineWaveViewController *)view cancelled:(BOOL)wasCancelled;
- (void)showLoadingView;
- (void)requestFailedWithError:(NSError *)error;
@end

@interface SpeechToTextModule : NSObject <UIAlertViewDelegate, SineWaveViewDelegate> {
    UIAlertView *status;
    
    AQRecorderState aqData;
    
    BOOL detectedSpeech;
    int samplesBelowSilence;
    
    NSTimer *meterTimer;
    BOOL processing;
    
    NSMutableArray *volumeDataPoints;
    SineWaveViewController *sineWave;
    
    NSThread *processingThread;
}

@property (readonly) BOOL recording;
@property (assign) id<SpeechToTextModuleDelegate> delegate;

- (id)initWithCustomDisplay:(NSString *)nibName;

// Begins a voice recording
- (void)beginRecording;

- (void)stopRecording:(BOOL)startProcessing;
-(void)CheckList:(NSString  *)voice;
@end
