//
//  DownloadTableViewCell.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadTableViewCell : UITableViewCell

-(void)setThumbUrl: (NSString*)url;
-(void)setProgress: (float) value;

@end