//
//  PhotoViewController.m
//  PhotosSample
//
//  Created by Hirohisa Kawasaki on 2014/11/11.
//  Copyright (c) 2014年 Hirohisa Kawasaki. All rights reserved.
//

#import "PhotosViewController.h"
#import <BrickView.h>

@interface PhotoBrickViewCell : BrickViewCell

@property (nonatomic, readonly) UIImageView *imageView;

@end

@implementation PhotoBrickViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end

@interface PhotoViewController () <BrickViewDataSource, BrickViewDelegate>

@property (nonatomic, strong) PHFetchResult *result;
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic, strong) BrickView *brickView;

@end

@implementation PhotoViewController

- (instancetype)initWithCollection:(PHAssetCollection *)collection
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.brickView = [[BrickView alloc] initWithFrame:self.view.bounds];
    self.brickView.delegate = self;
    self.brickView.dataSource = self;
    [self.view addSubview:self.brickView];

    NSMutableArray *assets = [@[] mutableCopy];
    [self.result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PHAsset *asset = (PHAsset *)obj;
        if (asset) {
            [assets addObject:asset];
        }

        if (stop) {
            self.assets = [assets copy];
            [self.brickView reloadData];
        }
    }];
}

- (BrickViewCell *)brickView:(BrickView *)brickView cellAtIndex:(NSInteger)index
{
    PhotoBrickViewCell *cell = [brickView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[PhotoBrickViewCell alloc] initWithReuseIdentifier:@"Cell"];
    }

    CGSize size = (CGSize){100, 100};
    PHAsset *asset = self.assets[index];
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:size
                                              contentMode:PHImageContentModeAspectFill
                                                  options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
                                                      cell.imageView.image = result;
                                                  }];

    return cell;
}

- (NSInteger)numberOfCellsInBrickView:(BrickView *)brickView
{
    return [self.assets count];
}

- (NSInteger)numberOfColumnsInBrickView:(BrickView *)brickView
{
    return 3;
}

- (CGFloat)brickView:(BrickView *)brickView heightForCellAtIndex:(NSInteger)index
{
    return 100;
}

@end
