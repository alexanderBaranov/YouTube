//
//  YTLIbTests.m
//  YTLIbTests
//
//  Created by Alexander Baranov on 22.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import "YTLIbTests.h"
#import "YTRequests.h"

@implementation YTLIbTests

- (void)setUp
{
    [super setUp];
    
    player = [YTPlayer new];
    STAssertNotNil(player, @"Could not create player subject.");
}

- (void)tearDown
{
    [player release];
    [super tearDown];
}

- (void)testExample
{
//    STFail(@"Unit tests are not implemented yet in YTLIbTests");
}

- (void)testFindVideos
{
    NSMutableArray *arrData;

    STAssertNoThrow([YTRequests FindVideos:@"nice cat" outArray:arrData], @"Not connect");
    STAssertEquals(nil, arrData, @"Not return videos");
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
