//
//  TestCodeCellController.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/15.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "TestCodeCellController.h"
#import "TestCodeTableViewCell.h"

typedef void(^TestStrongBlock)(NSString *string);

#define macro_keywordify try {} @catch (...) {} @finally {}

#define macro_stringify_(A) #A
#define macro_stringify(A)  macro_stringify_(A)

#define macro_concat_(A,B)  A ## B
#define macro_concate(A,B)  macro_concat_(A,B)



#define macro_weakify(to_weakify)   \
__weak typeof(to_weakify)     macro_concat_(to_weakify,__weak) = (to_weakify);


#define macro_strongify(to_strongify) \
__strong typeof(to_strongify)  self = macro_concat_(to_strongify,__weak);



#define weakify(to_weakify)      macro_keywordify  macro_weakify(to_weakify)
#define strongify(to_strongify)  macro_keywordify  macro_strongify(to_strongify)

@interface TestCodeCellController  ()
{
    const char *testString;
}
//

@property (nonatomic, copy  ) TestStrongBlock StrongBlock;
@property (nonatomic, copy  ) NSString * testString;

@end

@implementation TestCodeCellController

- (void)dealloc{
    NSLog(@"%s %@",__func__,NSStringFromClass([self class]));
}

- (void)viewDidLoad{
    [super viewDidLoad];

}

- (void)loadMore:(BOOL)more{
    [self.dataSources addObjectsFromArray:@[@"代码写的cell显示",@"代码写的cell显示",@"代码写的cell显示",
                                            @"代码写的cell显示",@"代码写的cell显示",@"代码写的cell显示",
                                            @"代码写的cell显示",@"代码写的cell显示",@"代码写的cell显示"]];
}

- (Class)cellClassForTable:(UITableView *)table index:(NSIndexPath *)indexPath{
    return [TestCodeTableViewCell class];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.StrongBlock) {
        self.StrongBlock(_testString);
    }
    
}

@end
