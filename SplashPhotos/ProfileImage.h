//
//  ProfileImage.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileImage: NSObject

@property (nullable, nonatomic, copy) NSString *small;
@property (nullable, nonatomic, copy) NSString *medium;
@property (nullable, nonatomic, copy) NSString *large;

+(ProfileImage*) fromDictionary: (NSDictionary*) dic;
@end

NS_ASSUME_NONNULL_END

#import "ProfileImage+CoreDataProperties.h"
