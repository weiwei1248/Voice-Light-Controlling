//
//  Tool.m
//  IOSClient
//
//  Created by Vian on 2017-03-10.
//  Copyright © 2017 Muhammad Zeeshan. All rights reserved.
//

#import "Tool.h"

@implementation Tool
#define MAX_LEN 3
-(id)init
{
    if(self==[super init])
    {
        
    }
    return self;
}


-(NSString *)REG_W:(NSString *)voice;
{
    NSString *result=@"2";
    NSMutableArray *open=[[NSMutableArray alloc]initWithObjects:@"open",@"on",@"up", nil];
    NSMutableArray *close=[[NSMutableArray alloc]initWithObjects:@"close",@"off",@"down", nil];
    NSMutableArray *place=[[NSMutableArray alloc]initWithObjects:@"bedroom",@"kitchen", nil];
    int open_count=0;
    int close_count=0;
    
//    for(int i=0;i<2;i++)
//    {
//        if([voice containsString:place[i]])
//        {
//            switch (i) {
//                case 0://bedroom
//                    if([voice containsString:open[i]])
//                    {
//                        result=@"B";
//                        open_count++;
//                    }
//                    else if ([voice containsString:close[i]])
//                    {
//                        result=@"b";
//                        close_count++;
//                    }
//                    else if([voice isEqualToString:@"Recogonize failed."])
//                    {
//                        result=@"2";
//                    }
//                    break;
//                case 1://kitchen
//                    if([voice containsString:open[i]])
//                    {
//                        result=@"A";
//                        open_count++;
//                    }
//                    else if ([voice containsString:close[i]])
//                    {
//                        result=@"a";
//                        close_count++;
//                    }
//                    else if([voice isEqualToString:@"Recogonize failed."])
//                    {
//                        result=@"2";
//                    }
//                    break;
//                default:
//                    break;
//            }
//        }
//    }
    
    for(int i=0;i<MAX_LEN;i++)
    {
        if([voice containsString:open[i]])
        {
            result=@"1";
            open_count++;
        }
        else if ([voice containsString:close[i]])
        {
            result=@"0";
            close_count++;
        }
        else if([voice isEqualToString:@"Recogonize failed."])
        {
            result=@"2";
        }
    }
    
    if((open_count>1||close_count>1)&&open_count!=close_count)
    {
        if(open_count>close_count)
        {
            result=@"1";
        }
        else if(open_count<close_count)
        {
            result=@"0";
        }
    }
    NSLog(@"result = %@",result);
    return result;
}

+(Tool *)sharedInstance
{
    static Tool *_sharedInstace=nil;
    if(_sharedInstace==nil)
    {
        _sharedInstace=[[Tool alloc] init];
    }
    return _sharedInstace;
}
@end
