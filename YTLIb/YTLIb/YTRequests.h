//
//  YTRequests.h
//  YTLIb
//
//  Created by Alexander Baranov on 24.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTRequests : NSObject

+(void) FindVideos:(NSString *)titleVideo outArray:(NSMutableArray *)mapOfRequests;
+(void) getCommentsOfVideo:(NSString *)idVideo OutResult:(NSMutableArray*)arrComments;

@end
