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

#define macro_head_(FIRST,...) FIRST
#define macro_head(...) macro_head_(__VA_ARGS__,0)

#define macro_at(N,...) macro_concate(macro_at,N)(__VA_ARGS__)
#define macro_argcount(...) macro_at(4,__VA_ARGS__,4, 3, 2, 1)





#define macro_weakify(to_weakify)   \
__weak typeof(to_weakify)     macro_concat_(to_weakify,__weak) = (to_weakify);


#define macro_strongify(to_strongify) \
__strong typeof(to_strongify)  self = macro_concat_(to_strongify,__weak);



#define weakify(to_weakify)      macro_keywordify  macro_weakify(to_weakify)
#define strongify(to_strongify)  macro_keywordify  macro_strongify(to_strongify)



#define macro_at1(_0,...)   macro_head(__VA_ARGS__)
#define macro_at2(_0,_1, ...)   macro_head(__VA_ARGS__)
#define macro_at3(_0,_1,_2,...) macro_head(__VA_ARGS__)
#define macro_at4(_0,_1,_2,_3,...) macro_head(__VA_ARGS__)

// metamacro_foreach_cxt expansions
#define metamacro_foreach_cxt0(MACRO, SEP, CONTEXT)
#define metamacro_foreach_cxt1(MACRO, SEP, CONTEXT, _0) MACRO(0, CONTEXT, _0)

#define metamacro_foreach_cxt2(MACRO, SEP, CONTEXT, _0, _1) \
metamacro_foreach_cxt1(MACRO, SEP, CONTEXT, _0) \
SEP \
MACRO(1, CONTEXT, _1)

#define metamacro_foreach_cxt3(MACRO, SEP, CONTEXT, _0, _1, _2) \
metamacro_foreach_cxt2(MACRO, SEP, CONTEXT, _0, _1) \
SEP \
MACRO(2, CONTEXT, _2)


#define metamacro_foreach_cxt(MACRO, SEP, CONTEXT, ...) \
macro_concate(metamacro_foreach_cxt, macro_argcount(__VA_ARGS__))(MACRO, SEP, CONTEXT, __VA_ARGS__)

@interface TestCodeCellController  ()
{
//    const char *testString;
}
//

@property (nonatomic, copy  ) TestStrongBlock StrongBlock;
@property (nonatomic, copy  ) NSString * testString;
@property (nonatomic, strong  ) TestCodeCellController * vc;

@end

@implementation TestCodeCellController

- (void)dealloc{
    NSLog(@"%s %@",__func__,NSStringFromClass([self class]));
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)loadMore:(BOOL)more{
    
    
    @weakify(self);

//    int macro_at1(self,testString) = 2;
//    int macro_at2(self, vc, testString);
//    int macro_concate(a, macro_argcount(_0,_1));
//    
//    int FIRST;
//    int macro_at1(vcT,vc);
//    
//    metamacro_foreach_cxt3(<#MACRO#>, <#SEP#>, <#CONTEXT#>, <#_0#>, <#_1#>, <#_2#>)
    
//    int count = macro_argcount(self,testString);
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
