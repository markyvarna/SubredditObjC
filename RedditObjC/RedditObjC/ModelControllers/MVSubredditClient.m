//
//  MVSubredditClient.m
//  RedditObjC
//
//  Created by Markus Varner on 9/12/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

#import "MVSubredditClient.h"

@implementation MVSubredditClient

#pragma Fetch Methods

+ (void)fetchAllSubredditsForTitle: (NSString *)title withBlock: (void (^)(NSArray<MVSubreddit *> * _Nullable posts))block
{
#pragma Base URL
    //1) Construct URL
    NSURL *baseURL = [NSURL URLWithString: @"https://www.reddit.com/r/"];
    NSURL *url = [baseURL URLByAppendingPathComponent:title];
    url = [url URLByAppendingPathExtension:@"json"];
    
    NSLog(@"%@", [url absoluteString]);
    
    //2) DataTask, Serializing JSON,  completing, and resume
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
#pragma DataTask
        
        if (error)
        {
            NSLog(@"Error fetching all subreddits for the title %@ %@", error, error.localizedDescription);
            block(nil);
            return;
        }
        
        //optional print out of response
        NSLog(@"%@", response);
        
        //check if there is NOT data, if there is serialize it into json, else complete and return
        if (!data)
        {
            NSLog(@"No Data Returned");
            block(nil);
            return;
        }
        
#pragma Serialize Data
        
#pragma Top Level - JSONDictionary
        //define new dictionary for the top level, jsonDictionary
        //Note: &error - takes an error handler from above and modifies it for this case
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:&error];
#pragma Next Level - DataDictionary
        //init another dictionary named data, within the jsonDictionary
        NSDictionary *dataDictionary = jsonDictionary[@"data"];
#pragma Next Level - ChildrenArray
        //init children array within the dataDictionary, each child is a subreddit post
        NSArray *childrenArray = dataDictionary[@"children"];
#pragma Create new NSMutable Array of Post Dictionaries, using the Children Array
        //create a new subreddits array, must ALLOCATE  and init it
        NSMutableArray *subreddits = [[NSMutableArray alloc] init];
        //init each post dictionary from the childrenArray of dictionaries
        for (NSDictionary *postDictionary in childrenArray)
        {
            MVSubreddit *post = [[MVSubreddit alloc] initWithDictionary:postDictionary];
            //add initialized post dictionary obj to the subreddites array
            [subreddits addObject:post];
        }
        //complete with subbredits array
        block(subreddits);
#pragma Resume
    }] resume];
    
}


#pragma Fetch Image Method

+ (void)fetchImageDataForURL: (NSString *)imageURLString withBlock: (void(^)(NSData  *_Nullable imageData))block
{
    NSURL *url = [NSURL URLWithString:imageURLString];
    NSLog(@"%@", [url absoluteString]);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //1.) Construct URL
        if (error)
        {
            NSLog(@"Error fetching image %@ %@", error, error.localizedDescription);
            block(nil);
            return;
        }
        
        NSLog(@"%@", response);
        
        //2.) DataTask, Serialize, Complete and Resume
        if (!data)
        {
            NSLog(@"No Image Data Returned");
            block(nil);
            return;
        }
        
        block(data);
    }] resume];
}

@end
