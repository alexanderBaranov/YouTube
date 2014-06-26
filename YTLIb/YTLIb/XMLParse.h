//
//  XMLParse.h
//  YTLIb
//
//  Created by Alexander Baranov on 25.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLParse : NSObject<NSXMLParserDelegate>
{
    BOOL m_done;
    BOOL m_isTitle;
    NSError* m_error;
    NSMutableArray* m_titles;
    NSMutableString* m_title;
}

@property (readonly) BOOL done;
@property (readonly) NSError* error;
@property (readonly) NSArray* titles;

@end
