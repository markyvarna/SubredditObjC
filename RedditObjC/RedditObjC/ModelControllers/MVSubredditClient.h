//
//  MVSubredditClient.h
//  RedditObjC
//
//  Created by Markus Varner on 9/12/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVSubreddit.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVSubredditClient : NSObject

#pragma Define FetchSubreddits Method

//Swift: static func fetchAllSubreddits(forTitle: String, completion: @escaping ([Subreddit]?) -> ())
+ (void)fetchAllSubredditsForTitle: (NSString *)title withBlock: (void (^)(NSArray<MVSubreddit *> * _Nullable posts))block;

#pragma Fetch Image Data Method

//Swift: static func fetchImageData(for url: String, completion: @escaping (Data?)-> ())
+ (void)fetchImageDataForURL: (NSString *)imageURLString withBlock: (void(^)(NSData  *_Nullable imageData))block;

@end

NS_ASSUME_NONNULL_END
