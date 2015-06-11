//
//  BITableViewSectionsData.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/11.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BITableViewSectionsData.h"

@implementation BITableViewSectionsData

- (instancetype)init{
    if (self = [super init]) {
        self.sectionHeaderHeight = 0.001f;
        self.sectionFooterHeight = 0.001f;
    }
    return self;
}

+ (instancetype)sectionWithRowDatas:(NSArray *)rowDatas{
    BITableViewSectionsData *sectionData = [BITableViewSectionsData new];
    sectionData.rowDatas = rowDatas.mutableCopy;
    return sectionData;
}
@end
