//
//  PhotoViewController.h
//  PhotosSample
//
//  Created by Hirohisa Kawasaki on 2014/11/11.
//  Copyright (c) 2014年 Hirohisa Kawasaki. All rights reserved.
//

@import Photos;
#import "ViewController.h"

@interface PhotoViewController : ViewController

- (instancetype)initWithCollection:(PHAssetCollection *)collection;

@end
