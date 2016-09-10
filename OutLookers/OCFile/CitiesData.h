//
//  CitiesData.h
//  MobileHotel
//
//  Created by youmingtaizi on 3/3/16.
//  Copyright © 2016 ethank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitiesData : NSObject
+ (instancetype)sharedInstance;

- (NSArray *)allProvince;

- (NSArray *)provinceTitle;

- (NSArray *)citiesWithProvinceName:(NSString *)province;

- (NSArray *)areaWithCity:(NSString *)city province:(NSString *)province;
@end
