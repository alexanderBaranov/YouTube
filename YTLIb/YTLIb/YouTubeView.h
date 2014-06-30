//
//  YTLIb.h
//  YTLIb
//
//  Created by Alexander Baranov on 22.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YTPlayer : UIViewController
{
    UIWebView *webView;
    UISegmentedControl *segmentQuality;
    UITextView *commentsView;
    UIButton *btnLink;

    NSMutableString *idVideo;
    NSMutableString *strQuality;
    
}

-(void)LoadPlayer:(NSString *)idVideoOfYT;

@end
