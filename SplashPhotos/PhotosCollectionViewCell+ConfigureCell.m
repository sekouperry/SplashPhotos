//
//  PhotosCollectionViewCell+ConfigureCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "PhotosCollectionViewCell+ConfigureCell.h"
#import "Photo.h"
#import "Urls.h"
#import "UIImageView+UIImageViewWithAnimation.h"

@implementation PhotosCollectionViewCell (ConfigureCell)

- (void)configureForPhoto:(Photo *)photo
{
    NSString* url = [[photo urls] small];
    [self.image animateImageWithURL:[NSURL URLWithString: url] placeholderImage: nil];
}

@end
