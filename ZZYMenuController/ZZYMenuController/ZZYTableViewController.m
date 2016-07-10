//
//  ZZYTableViewController.m
//  ZZYMenuController
//
//  Created by admin on 16/7/9.
//  Copyright © 2016年 断剑. All rights reserved.
//

#import "ZZYTableViewController.h"
#import "ZZYTableViewCell.h"

@interface ZZYTableViewController ()

@property (nonatomic, weak) ZZYTableViewCell * selectCell;

@end

@implementation ZZYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当menucontroller显示，点击不同的cell时为什么会显示。
//    menuController的显示依赖于第一响应者，当点击另外的cell时，当前cell取消第一响应者状态，menucontroller自动消失
    UIMenuController * menu = [UIMenuController sharedMenuController];
    NSLog(@"%d",menu.isMenuVisible);
    //防止点击多次创建
    if (menu.isMenuVisible)
    {
        [menu setMenuVisible:NO animated:YES];
    }
    else
    {
    
    ZZYTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        self.selectCell = cell;

    [cell becomeFirstResponder];
    
    UIMenuItem * item0 = [[UIMenuItem alloc]initWithTitle:@"分享" action:@selector(share:)];
    UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"评论" action:@selector(comment:)];
    UIMenuItem * item2 = [[UIMenuItem alloc]initWithTitle:@"点赞" action:@selector(praise:)];
    menu.menuItems = @[item0,item1,item2];
    
    [menu setTargetRect:CGRectMake(0, cell.frame.size.height * 0.5, cell.frame.size.width, cell.frame.size.height) inView:cell];
    
    [menu setMenuVisible:YES animated:YES];
    }
}


- (void)share:(UIMenuController *)menu
{
    NSLog(@"%@",self.selectCell.textLabel.text);
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:self.selectCell.textLabel.text delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)comment:(UIMenuController *)menu
{
    
}

- (void)praise:(UIMenuController *)menu
{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
}

@end
