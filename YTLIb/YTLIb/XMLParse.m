//
//  XMLParse.m
//  YTLIb
//
//  Created by Alexander Baranov on 25.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import "XMLParse.h"

@implementation XMLParse
@synthesize done=m_done;
@synthesize titles=m_titles;
@synthesize error=m_error;

-(void) dealloc {
    [m_error release];
    [m_titles release];
    [super dealloc];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    m_done = NO;
    m_titles = [NSMutableArray new];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    m_done = YES;
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    m_done = YES;
    m_error = [parseError retain];
}

-(void) parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    m_done = YES;
    m_error = [validationError retain];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

    m_isTitle = NO;
    if([[elementName lowercaseString] isEqualToString:@"content"] ||
       [[elementName lowercaseString] isEqualToString:@"published"]||
       [[elementName lowercaseString] isEqualToString:@"name"])
    {
        m_isTitle = YES;
    }
    
    if ( m_isTitle ) {
        m_title = [NSMutableString new];
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ( m_isTitle ) {
        [m_titles addObject:m_title];
        [m_title release];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ( m_isTitle ) {
        [m_title appendString:string];
    }
}
@end
