//
//  MasterViewController.h
//  YT
//
//  Created by Alexander Baranov on 22.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController<UISearchBarDelegate>
{
    NSMutableArray * mapOfRequests;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
