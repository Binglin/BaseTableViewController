//
//  CellIdentifierRegisterController.m
//  BaseTableViewController
//
//  Created by Zhenglinqin on 15/6/13.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "CellIdentifierRegisterController.h"
#import "UIViewController+tableView.m"
#import "ViewControllerCell.h"
#import "TestXibTableViewCell.h"
#import "TestCodeTableViewCell.h"

@interface CellIdentifierRegisterController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CellIdentifierRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self register_cellIdentifiers:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20.f;
}

- (NSArray *)cellsIdentifiersForTable:(UITableView *)tableView{
    return @[@"Cell" ,
             @"UITableView",
            [ViewControllerCell class],
            [TestXibTableViewCell class],
             [TestCodeTableViewCell class]];
}

- (id)cellIdentifierForTableView:(UITableView *)table index:(NSIndexPath *)indexPath{
    if (indexPath.row < 2) {
        return @"Cell";
    }else if (indexPath.row < 3){
        return [ViewControllerCell class];
    }else if (indexPath.row < 4){
        return [TestXibTableViewCell class];
    }else if (indexPath.row < 5){
        return [TestCodeTableViewCell class];
    }
    return @"UITableView";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
