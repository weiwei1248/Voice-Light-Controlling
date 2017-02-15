//
//  Data.h
//  IOSClient
//
//  Created by Vian on 2017-02-15.
//  Copyright © 2017 Muhammad Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
{
    int language_select;
}
@property (nonatomic) int language_select;

+(Data *)sharedInstance;
@end
