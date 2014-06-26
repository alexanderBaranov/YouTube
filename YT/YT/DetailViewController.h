//
//  DetailViewController.h
//  YT
//
//  Created by Alexander Baranov on 22.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouTubeView.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (assign, nonatomic) YTPlayer *ytPlayer;

@end
