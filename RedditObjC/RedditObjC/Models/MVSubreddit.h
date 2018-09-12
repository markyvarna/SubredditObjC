//
//  MVSubreddit.h
//  RedditObjC
//
//  Created by Markus Varner on 9/12/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVSubreddit : NSObject

#pragma - Properties

//note: add copy for strings
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSNumber *likeCount;
@property (nonatomic, readonly) NSNumber *commentCount;
@property (nonatomic, readonly, copy) NSString *imageURLString;
@property (nonatomic, readwrite, nullable) UIImage *photo;

#pragma - Init Method

- (instancetype)initWithDictionary: (NSDictionary *)postDictionary;

@end

NS_ASSUME_NONNULL_END
