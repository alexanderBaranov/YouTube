
//
//  Utils.m
//  YTLIb
//
//  Created by Alexander Baranov on 24.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import "Utils.h"
#import "XMLParse.h"

@implementation Utils

+(void)getJsonValues:(NSArray*)findValues json_string:(NSString*)json_string outArray:(NSMutableArray *)mapOfRequests
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[json_string /*componentsSeparatedByString:@"\""]*/componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"{}\""]]];

    [arr removeObject:@":"];
    [arr removeObject:@"\\"];
    [arr removeObject:@","];

    NSMutableArray *arrayObjects = [NSMutableArray array];
    int iCountOfFindObj = 0;
    for(int iCount = 0; iCount < arr.count-1; iCount++ )
    {
        if([[arr objectAtIndex:iCount] isEqual:[findValues objectAtIndex:iCountOfFindObj]])
        {
            [arrayObjects addObject:[arr objectAtIndex:++iCount]];
            
            if(iCountOfFindObj == (findValues.count-1))
            {
                iCountOfFindObj = 0;
                NSArray * data = [NSMutableArray arrayWithArray:arrayObjects];
                [arrayObjects removeAllObjects];
                [mapOfRequests addObject:data];
            }
            else
            {
                iCountOfFindObj++;
            }
        }
    }    
}

+(void) getDataOfXMLFromURL:(NSURL *)url OutResult:(NSMutableArray*)arrOutObjects
{
    XMLParse* delegate = [XMLParse new];

    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:delegate];
    [parser parse];
    
    while ( ! delegate.done )
        sleep(1);

    if ( delegate.error == nil ) {
        // если нет то выводим результат
        NSLog(@"%@",delegate.titles);
        [arrOutObjects addObjectsFromArray:delegate.titles];
    } else {
        // если была - выводим ошибку
        NSLog(@"Error: %@", delegate.error);
    }
    
    [delegate release];
    [parser release];
}

@end
