//
//  YTRequests.m
//  YTLIb
//
//  Created by Alexander Baranov on 24.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import "YTRequests.h"
#import "Utils.h"

@implementation YTRequests

-(void)dealloc
{
    [super dealloc];
}

+(void) FindVideos:(NSString *)titleVideo outArray:(NSMutableArray *)mapOfRequests
{
    NSString *resultStr = [titleVideo stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlString = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?q=%@&orderby=published&start-index=1&max-results=50&v=2&alt=jsonc", resultStr ];

    @try
    {
        [Utils getJsonValues:@[@"id", @"title", @"sqDefault"] json_string:[self sendRequest:urlString] outArray:mapOfRequests];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception.reason);
    }
}

+(void) getCommentsOfVideo:(NSString *)idVideo OutResult:(NSMutableArray*)arrComments
{
    NSString *urlString = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos/%@/comments", idVideo];
    NSURL *url = [NSURL URLWithString:urlString];

    @try
    {
        [Utils getDataOfXMLFromURL:url OutResult:arrComments];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception.reason);
    }
}

+(NSString *) sendRequest:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableData *responseData;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:20.0f];
    
    NSURLResponse* response = nil;
    responseData = [NSMutableData dataWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
    if(!responseData.length)
    {
        @throw [NSException exceptionWithName:nil reason:@"The request failed. Perhaps there is no Internet connection." userInfo:nil];
    }

    NSString *json_string = [[[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    
    return json_string;    
}

@end
