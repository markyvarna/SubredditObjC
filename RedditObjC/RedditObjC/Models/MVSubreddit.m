//
//  MVSubreddit.m
//  RedditObjC
//
//  Created by Markus Varner on 9/12/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

#import "MVSubreddit.h"

@implementation MVSubreddit

#pragma - Init Dictionary

- (instancetype)initWithDictionary: (NSDictionary *)postDictionary
{
    //1) Pull all the values out of the dictionary, make sure they are the right type
    NSString *title = postDictionary[@"data"][@"title"];
    NSNumber *likeCount = postDictionary[@"data"][@"ups"];
    NSNumber *commentCount = postDictionary[@"data"][@"num_comments"];
    NSString *imageURLString = postDictionary[@"data"][@"thumbnail"];
    
    //2) Make sure the optional properties arent null, and are the expected type
    if (![title isKindOfClass:[NSString class]] || !(title) || ![likeCount isKindOfClass:[NSNumber class]] || ![commentCount isKindOfClass:[NSNumber class]])
    {
        return nil;
    }
    
    //3) Init a model object from the values pulled out of the dictionary
    self = [super init];
    if (self)
    {
        _title = title;
        _likeCount = likeCount;
        _commentCount = commentCount;
        _imageURLString = imageURLString;
    }
    return self;
}

@end
