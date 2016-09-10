//
//  CitysData.m
//  area
//
//  Created by C on 16/4/15.
//  Copyright © 2016年 YoungKook. All rights reserved.
//

#import "CitiesData.h"

@interface CitiesData ()
{
    NSArray *_array;
}
@property (nonatomic, strong)NSMutableArray *provinceDicts;
@property (nonatomic, strong)NSMutableArray *citysDicts;
@property (nonatomic, strong)NSMutableArray *citysName;
@property (nonatomic, strong)NSMutableArray *areasName;
@end
@implementation CitiesData

- (NSMutableArray *)provinceDicts {
    if (!_provinceDicts) {
        _provinceDicts = [NSMutableArray array];
    }
    return _provinceDicts;
}

- (NSMutableArray *)citysDicts {
    if (!_citysDicts) {
        _citysDicts = [NSMutableArray array];
    }
    return _citysDicts;
}

- (NSMutableArray *)citysName {
    if (!_citysName) {
        _citysName = [NSMutableArray array];
    }
    return _citysName;
}

- (NSMutableArray *)areasName {
    if (!_areasName) {
        _areasName = [NSMutableArray array];
    }
    return _areasName;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _array = [NSArray arrayWithContentsOfFile:filePath];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static CitiesData *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[CitiesData alloc] init];
    });
    return data;
}

- (NSArray *)allProvince {
    return _array;
}

- (NSArray *)provinceTitle {
    NSMutableArray *array = [NSMutableArray array];
    [self.provinceDicts removeAllObjects];
    for (NSDictionary *provinceDict in _array) {
        [self.provinceDicts addObject:provinceDict];
        for (NSString *province in provinceDict) {
            [array addObject:province];
        }
    }
    return array;
}

- (NSArray *)citiesWithProvinceName:(NSString *)province {
    [self.citysName removeAllObjects];
    for (NSDictionary *provinceDict in self.provinceDicts) {
        if (provinceDict[province]) {
            for (NSDictionary *cityDict in provinceDict[province]) {
                for (NSString *cityName in cityDict) {
                    [self.citysName addObject:cityName];
                }
            }
        }
    }
    return self.citysName;
}

- (NSArray *)areaWithCity:(NSString *)city province:(NSString *)province {
    [self.areasName removeAllObjects];
    for (NSDictionary *provinceDict in self.provinceDicts) {
        if (provinceDict[province]) {
            for (NSDictionary *cityDict in provinceDict[province]) {
                [self.areasName addObjectsFromArray:cityDict[city]];
            }
        }
    }
    return self.areasName;
}
@end

/*
 //
 //  CitiesData.m
 //  MobileHotel
 //
 //  Created by youmingtaizi on 3/3/16.
 //  Copyright © 2016 ethank. All rights reserved.
 //
 
 #import "CitiesData.h"
 
 @interface CitiesData () {
 NSArray *_citiesData;
 NSArray *_provinces;
 NSDictionary *_cities;
 NSDictionary *_districts;
 }
 @end
 
 @implementation CitiesData
 
 #pragma mark - Life Cycle
 
 - (instancetype)init {
 if (self = [super init]) {
 NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CitiesData" ofType:@"plist"];
 _citiesData = [NSArray arrayWithContentsOfFile:filePath];
 }
 return self;
 }
 
 #pragma mark - Public Methods
 
 + (instancetype)sharedInstance {
 static CitiesData *data = nil;
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 data = [[CitiesData alloc] init];
 });
 return data;
 }
 
 - (NSArray *)provincesForAlphabet:(NSString *)alphabet {
 NSMutableArray *result = [NSMutableArray array];
 NSArray *provinceDicts = [self provinceDictsForAlphabet:alphabet];
 for (NSDictionary *provinceDict in provinceDicts) {
 [result addObject:[provinceDict allKeys][0]];
 }
 return result;
 }
 
 - (NSArray *)allProvinces {
 NSMutableArray *result = [NSMutableArray array];
 for (int i = 0; i < 26; ++i) {
 NSString *alphabet = [NSString stringWithFormat:@"%c", 'A' + i];
 [result addObjectsFromArray:[self provincesForAlphabet:alphabet]];
 }
 return result;
 }
 
 - (NSArray *)citiesForProvince:(NSString *)province {
 NSArray *cityDicts = [self citieDictsForProvince:province];
 // 找出该省份对应的城市
 NSMutableArray *result = [NSMutableArray array];
 for (NSDictionary *cityDict in cityDicts) {
 [result addObject:[cityDict allKeys][0]];
 }
 return result;
 }
 
 - (NSArray *)districtsForCity:(NSString *)city province:(NSString *)province {
 NSArray *result;
 NSArray *citieDictsForProvince = [self citieDictsForProvince:province];
 NSInteger index;
 if ([self isCity:city containsInDicts:citieDictsForProvince index:&index]) {
 NSDictionary *cityDict = citieDictsForProvince[index];
 result = cityDict[[cityDict allKeys][0]];
 }
 return result;
 }
 
 #pragma mark - Private Methods
 
 - (NSArray *)provinceDictsForAlphabet:(NSString *)alphabet {
 // 如果没有该字母对应的省份，则直接会反空
 NSInteger index;
 if ([self hasDataForAlphabet:alphabet index:&index]) {
 return [_citiesData[index] objectForKey:alphabet];
 }
 return nil;
 }
 
 - (NSArray *)citieDictsForProvince:(NSString *)province {
 NSDictionary *provinceDict;
 for (int i = 0; i < 26; ++i) {
 NSString *alphabet = [NSString stringWithFormat:@"%c", 'A' + i];
 // 如果该字母没有对应的省份，则不处理
 NSArray *provinceDicts = [self provinceDictsForAlphabet:alphabet];
 if (provinceDicts.count > 0) {
 NSInteger index;
 if ([self isProvince:province containsInDicts:provinceDicts index:&index]) {
 // 找到了省份的数据
 provinceDict = provinceDicts[index];
 return provinceDict[province];
 }
 }
 }
 return nil;
 }
 
 - (BOOL)hasDataForAlphabet:(NSString *)alphabet index:(NSInteger *)index {
 int targetIndex = 0;
 for (NSDictionary *alphabetDict in _citiesData) {
 if ([[alphabetDict allKeys] containsObject:alphabet]) {
 *index = targetIndex;
 return YES;
 }
 ++ targetIndex;
 }
 return NO;
 }
 
 - (BOOL)isProvince:(NSString *)province containsInDicts:(NSArray *)dicts index:(NSInteger *)index {
 int targetIndex = 0;
 for (NSDictionary *dict in dicts) {
 if ([[dict allKeys] containsObject:province]) {
 *index = targetIndex;
 return YES;
 }
 ++targetIndex;
 }
 return NO;
 }
 
 - (BOOL)isCity:(NSString *)city containsInDicts:(NSArray *)dicts index:(NSInteger *)index {
 int targetIndex = 0;
 for (NSDictionary *dict in dicts) {
 if ([[dict allKeys] containsObject:city]) {
 *index = targetIndex;
 return YES;
 }
 ++targetIndex;
 }
 return NO;
 }
 
 @end
 */
