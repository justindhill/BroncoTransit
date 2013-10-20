//
//  BTLeftMenuViewController.m
//  BroncoTransit
//
//  Created by Justin Hill on 9/8/13.
//  Copyright (c) 2013 Justin Hill. All rights reserved.
//

#import "BTLeftMenuViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "BTViewController.h"

@interface BTLeftMenuViewController () {
    NSArray *routeNames;
    NSArray *routeNumbers;
}

@end

@implementation BTLeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (NSArray *)routes {
    BTAppDelegate *d = (BTAppDelegate *)[[UIApplication sharedApplication] delegate];
    return d.routes;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    
    self.tableView.tableHeaderView = self.headerView;
}

- (UIView *)headerView
{
    CGRect f = self.view.frame;
    f.size.height = 64.;
    
    UIView *header = [[UIView alloc] initWithFrame:f];
    
    // the label needs to be centered in 80% the width of the frame because
    // of the cutoff from the center panel
    f.size.width *= .8f;
    
    UILabel *label = [[UILabel alloc] initWithFrame:f];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Routes";
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0];
    [header addSubview:label];
    
    return header;
}

#pragma mark - TableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.routes.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"routeMenu"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"routeMenu"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSDictionary *route = self.routes[indexPath.row];
    cell.textLabel.text = route[@"title"];
    return cell;
}

#pragma mark - TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *nav = (UINavigationController *)self.sidePanelController.centerPanel;
    BTViewController *mapController = (BTViewController *)nav.visibleViewController;
    
    [mapController switchRoute:@(indexPath.row)];
    [self.sidePanelController showCenterPanelAnimated:YES];
}

@end
