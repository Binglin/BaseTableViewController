//
//  ViewControllerCell.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/5/15.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "ViewControllerCell.h"

@implementation ViewControllerCell

- (void)setItem:(id)item{
    self.textLabel.text = item;
}

//+ (CGFloat)heightForItem:(id)object{
//    return 60;
//}

@end
