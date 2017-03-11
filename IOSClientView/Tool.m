//
//  Tool.m
//  IOSClient
//
//  Created by Junwei Wu on 2017-03-10.
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
    NSMutableArray *shine=[[NSMutableArray alloc]initWithObjects:@"crazy",@"shine",@"shining",@"rock",nil];
    NSMutableArray *open=[[NSMutableArray alloc]initWithObjects:@"open",@"on",@"up", nil];
    NSMutableArray *close=[[NSMutableArray alloc]initWithObjects:@"close",@"off",@"down", nil];
    NSMutableArray *place=[[NSMutableArray alloc]initWithObjects:@"bedroom",@"kitchen",@"all", nil];
    int b_open_count=0;
    int b_close_count=0;
    int k_close_count=0;
    int k_open_count=0;
    
    for(int i=0;i<MAX_LEN;i++)
    {
        if([voice containsString:place[i]])
        {
            switch (i) {
                case 0://bedroom
                    if([voice containsString:open[i]])
                    {
                        result=@"B";
                        b_open_count++;
                    }
                    else if ([voice containsString:close[i]])
                    {
                        result=@"b";
                        b_close_count++;
                    }
                    else if([voice isEqualToString:@"Recogonize failed."])
                    {
                        result=@"2";
                        return result;
                    }
                    break;
                case 1://kitchen
                    if([voice containsString:open[i]])
                    {
                        result=@"A";
                        k_open_count++;
                    }
                    else if ([voice containsString:close[i]])
                    {
                        result=@"a";
                        k_close_count++;
                    }
                    else if([voice isEqualToString:@"Recogonize failed."])
                    {
                        result=@"2";
                        return result;
                    }
                    break;
                case 2://all
                    if([voice containsString:open[i]])
                    {
                        result=@"AB";
                    }
                    else if ([voice containsString:close[i]])
                    {
                        result=@"ab";
                    }
                    else if([voice isEqualToString:@"Recogonize failed."])
                    {
                        result=@"2";
                        return result;
                    }
                    break;
                default:
                    break;
            }
        }
        else
        {
            if([voice containsString:@"enable"])
            {
                result=@"1";
            }
            else if ([voice containsString:@"disable"])
            {
                result=@"0";
            }
            else if ([voice containsString:shine[i]])
            {
                result=@"t";
            }
            else if([voice containsString:@"Recogonize failed."])
            {
                result=@"2";
                return result;
            }
        }
    }
    
    if((k_open_count>1||k_close_count>1||b_open_count>1||b_close_count>1)&&k_open_count!=k_close_count&&b_open_count!=b_close_count)
    {
        if(k_open_count>k_close_count)
        {
            result=@"A";
        }
        else if(k_open_count<k_close_count)
        {
            result=@"a";
        }
        else if(k_open_count<b_open_count)
        {
            result=@"B";
        }
        else if(k_open_count>b_open_count)
        {
            result=@"A";
        }
        else if(b_open_count<b_close_count)
        {
            result=@"b";
        }
        else if(b_open_count>b_close_count)
        {
            result=@"B";
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
