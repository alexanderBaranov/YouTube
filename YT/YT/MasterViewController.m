//
//  MasterViewController.m
//  YT
//
//  Created by Alexander Baranov on 22.06.14.
//  Copyright (c) 2014 Alexander Baranov. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "YTRequests.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
//        self.clearsSelectionOnViewWillAppear = NO;
//        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [mapOfRequests release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapOfRequests = [NSMutableArray new];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (mapOfRequests && mapOfRequests.count) ? mapOfRequests.count : 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    if(mapOfRequests && mapOfRequests.count)
    {
        NSArray * dataOfVideo = [mapOfRequests objectAtIndex:indexPath.row];
        cell.textLabel.text = [dataOfVideo objectAtIndex:1];
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[dataOfVideo objectAtIndex:2]]];
        cell.imageView.image = [UIImage imageWithData: imageData];
        [imageData release];        
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * dataOfVideo = [mapOfRequests objectAtIndex:indexPath.row];
    [self.detailViewController.ytPlayer LoadPlayer:[dataOfVideo objectAtIndex:0]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UISearchBar *searchBar = [[UISearchBar new]autorelease];
    searchBar.showsSearchResultsButton = YES;
    searchBar.delegate = self;
    
    return searchBar;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(mapOfRequests.count)
    {
        [mapOfRequests removeAllObjects];
    }
    
    [YTRequests FindVideos:searchBar.text outArray:mapOfRequests];
    
    [self.tableView reloadData];
}
@end
