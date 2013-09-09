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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    routeNames = @[@"Brown", @"Gold", @"Oakland", @"Parkview I", @"Parkview II"];
    routeNumbers = @[@9, @7, @1, @5, @8];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"routeMenu"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"routeMenu"];
    }
    
    cell.textLabel.text = routeNames[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *nav = (UINavigationController *)self.sidePanelController.centerPanel;
    BTViewController *mapController = (BTViewController *)nav.visibleViewController;
    
    [mapController switchRoute:routeNumbers[indexPath.row] withName:routeNames[indexPath.row]];
    [self.sidePanelController showCenterPanelAnimated:YES];
}

@end
