//
//  Album.h
//  HelloiOS
//
//  Created by Yu Hongda on 13-5-19.
//  Copyright (c) 2013年 Yu Hongda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject
{
    int albumId;
    NSString* albumName;
}


@property (nonatomic) int albumId;
@property (nonatomic, retain) NSString* albumName;

-(Album*)initWithName:(NSString*)name andId:(int) _id;

@end
