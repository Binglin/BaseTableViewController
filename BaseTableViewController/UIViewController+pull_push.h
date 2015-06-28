//
//  UIViewController+pull_push.h
//
//
//  Created by Zhenglinqin on 15/3/21.
//  Copyright (c) 2015年 Binglin All rights reserved.
//



@interface UIViewController (pull_push)

/*refresh more*/
- (void)addPullPush;//添加下拉刷新 上拉加载更多
- (void)loadMore:(BOOL)isMore;//网络请求方法
- (void)stopLoading;

@end
