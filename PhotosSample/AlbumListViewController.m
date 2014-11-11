//
//  AlbumListViewController.m
//  PhotosSample
//
//  Created by Hirohisa Kawasaki on 2014/11/11.
//  Copyright (c) 2014年 Hirohisa Kawasaki. All rights reserved.
//

@import Photos;
#import "AlbumListViewController.h"
#import "PhotosViewController.h"

@interface AlbumListViewController ()

@property (nonatomic, strong) NSArray *collections;

@end

@implementation AlbumListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    PHFetchResult *result = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];

    NSMutableArray *collections = [@[] mutableCopy];
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PHAssetCollection *collection = (PHAssetCollection *)obj;
        [collections addObject:collection];
        if (stop) {
            self.collections = collections;
            [self.tableView reloadData];
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    PHAssetCollection *collection = self.collections[indexPath.row];

    cell.textLabel.text = collection.localizedTitle;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PHAssetCollection *collection = self.collections[indexPath.row];
    PhotoViewController *viewController = [[PhotoViewController alloc] initWithCollection:collection];

    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.collections count];
}

@end
