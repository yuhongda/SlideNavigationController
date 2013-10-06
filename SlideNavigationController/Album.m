//
//  Album.m
//  HelloiOS
//
//  Created by Yu Hongda on 13-5-19.
//  Copyright (c) 2013年 Yu Hongda. All rights reserved.
//

#import "Album.h"

@implementation Album

@synthesize albumId, albumName;

-(Album *)initWithName:(NSString *)name andId:(int)_id
{
    self = [super init];
    if (self) {
        albumName = name;
        albumId = _id;
    }
    return self;
}

@end

