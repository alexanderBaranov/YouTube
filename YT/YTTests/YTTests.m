//
//  YTTests.m
//  YTTests
//
//  Created by Alexander Baranov on 22.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import "YTTests.h"
#import "YTRequests.h"

@implementation YTTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
//    STFail(@"Unit tests are not implemented yet in YTTests");
}

- (void)testFindVideos
{
    NSMutableArray *arrData;
    
    STAssertNoThrow([YTRequests FindVideos:@"nice cat" outArray:arrData], @"Not connect");
    STAssertEquals(0, arrData.count, @"Not return videos");
    [arrData release];
}

- (void)testGetCommentsOfVideo
{
    NSMutableArray *arrData;
    
    STAssertNoThrow([YTRequests getCommentsOfVideo:@"asdasd" OutResult:arrData], @"Not connect");
    STAssertEquals(0, arrData.count, @"Not return comments");
    [arrData release];
}


@end
