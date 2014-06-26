//
//  Utils.h
//  YTLIb
//
//  Created by Alexander Baranov on 24.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(void) getJsonValues:(NSArray*)findValues json_string:(NSString*)json_string outArray:(NSMutableArray *)mapOfRequests;
+(void) getDataOfXMLFromURL:(NSURL *)url OutResult:(NSMutableArray*)arrOutObjects;

@end
