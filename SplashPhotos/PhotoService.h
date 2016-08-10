//
//  PhotoService.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/7.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface PhotoService : NSObject


-(NSMutableArray*)getDataSource;
-(NSMutableArray*)getDownloadDataSource;

-(void)loadMoreDataWithCallback:(void(^) (NSString* errormsg)) success;
-(void)requestDownload: (Photo*) photo;

-(int)getCurrentPageNum;


@end