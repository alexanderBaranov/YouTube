//
//  YTLIb.m
//  YTLIb
//
//  Created by Alexander Baranov on 22.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import "YouTubeView.h"
#import "YTRequests.h"

@implementation YTPlayer

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 500, 400)];
    webView.allowsInlineMediaPlayback = YES;
    webView.mediaPlaybackRequiresUserAction = NO;
    //webView.delegate = self;
    
    [self.view addSubview: webView];
    
    segmentQuality = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"240px",@"360px",@"480px",@"720px",@"1080px",@">1080px", nil]];
    
    [segmentQuality addTarget:self action:@selector(setQuality:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview: segmentQuality];
    
    commentsView = [[UITextView alloc] initWithFrame:self.view.frame];
    commentsView.editable = NO;
    commentsView.dataDetectorTypes = UIDataDetectorTypeLink;
    
    [self.view addSubview: commentsView];
    
    btnLink = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [btnLink.titleLabel setTextColor:[UIColor blueColor]];
    [btnLink setBackgroundColor:[UIColor redColor]];
    
    [btnLink setTitle:@"Address" forState:UIControlStateNormal];
    [btnLink addTarget:self action:@selector(pushHyperLink) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btnLink];
    
    CGRect frame = self.view.frame;
    frame.size.height += segmentQuality.frame.size.height;
    self.view.frame = frame;
    
    frame = segmentQuality.frame;
    frame.origin.y = webView.frame.size.height;
    segmentQuality.frame = frame;
    
    frame = btnLink.frame;
    frame.origin.y = segmentQuality.frame.size.height + webView.frame.size.height + 5;
    btnLink.frame = frame;
    
    frame = commentsView.frame;
    frame.origin.y = segmentQuality.frame.size.height + webView.frame.size.height + 25;
    commentsView.frame = frame;
    
    [self LoadPlayer:@""];
    
    idVideo = [NSMutableString new];
    strQuality = [[NSMutableString alloc] initWithString:@"default"];
}

-(void)dealloc
{
    [webView release];
    [segmentQuality release];
    [idVideo release];
    [strQuality release];
    [commentsView release];
    [btnLink release];
    
    [super dealloc];
}

-(void)LoadPlayer:(NSString *)idVideoOfYT
{
    idVideo = (NSMutableString *)idVideoOfYT;

    NSString* embedHTML = [NSString stringWithFormat:
                           @"<html>"
                                @"<body style='margin:0px;padding:0px;'>"
                                @"<script type='text/javascript' src='http://www.youtube.com/iframe_api'>"
                                @"</script>"
                                @"<script type='text/javascript'>"
                                @"function onYouTubeIframeAPIReady()"
                                @"{"
                                    @"ytplayer=new YT.Player('playerId',{events:{'onReady':onPlayerReady, 'onPlaybackQualityChange':onPlayerPlaybackQualityChange, 'onStateChange': onPlayerStateChange}})"
                                @"}"

                                @"function onPlayerReady(a)"
                                @"{"
                                    @"a.target.playVideo();"
//                                    @"a.target.pauseVideo();"
                                @"}"
                                @"function onPlayerPlaybackQualityChange(a)"
                                @"{"
                                    @"a.target.setPlaybackQuality('%@');"
                                @"}"

                                @"function onPlayerStateChange(a)"
                                @"{"
//                                    @"setTimeout(stopVideo, 6000);"
//                                    @"a.target.setPlaybackQuality('large');"
                                @"}"
                           
                                @"</script>"
                                @"<iframe id='playerId' type='text/html' width='500' height='400' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>"
                                @"</body>"
                                @"</html>" , strQuality, idVideoOfYT];
    

    [webView loadHTMLString:embedHTML baseURL:nil];
    
    if(idVideo.length)
    {                
        NSMutableArray *arrComments = [NSMutableArray new];
        [YTRequests getCommentsOfVideo:idVideo OutResult:arrComments];
        
        NSMutableString *strComments = [NSMutableString new];
        int iCountOneComment = 1;
        for(int i = 1; i<arrComments.count; i++)
        {
            [strComments appendString:[arrComments objectAtIndex:i]];

            [strComments appendString:@"\n\r"];
         
            if(iCountOneComment == 3)
            {
                [strComments appendString:@"\n"];
            }
            else
            {
                iCountOneComment++;
            }
        }
        
        commentsView.text = strComments;
    
        [strComments release];
        [arrComments release];
    }
}

#pragma mark - selected segment
-(void)setQuality:(id) sender
{
    switch ([sender selectedSegmentIndex]) {
        case 0:
            strQuality = (NSMutableString *)@"small";
            break;

        case 1:
            strQuality = (NSMutableString *)@"medium";
            break;
        
        case 2:
            strQuality = (NSMutableString *)@"large";
            break;

        case 3:
            strQuality = (NSMutableString *)@"hd720";
            break;

        case 4:
            strQuality = (NSMutableString *)@"hd1080";
            break;

        case 5:
            strQuality = (NSMutableString *)@"highres";
            break;
    }
    
    [self LoadPlayer:idVideo];
}

-(IBAction)pushHyperLink
{
    if(idVideo.length)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@", idVideo]]];
}

@end
