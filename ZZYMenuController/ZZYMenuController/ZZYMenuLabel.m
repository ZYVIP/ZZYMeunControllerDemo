//
//  ZZYMenuLabel.m
//  ZZYMenuController
//
//  Created by admin on 16/7/9.
//  Copyright © 2016年 断剑. All rights reserved.
//

#import "ZZYMenuLabel.h"

@implementation ZZYMenuLabel

/**
 *  xib创建label时调用
 */
- (void)awakeFromNib
{
    [self setUp];
}

/**
 *  代码创建label时调用
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
         [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)]];
}

- (void)longPress
{
    NSLog(@"%s",__func__);
    
    //1.设置label为第一响应者
    //通过设置第一响应者UIMenuController可以获得支持哪些操作的信息,操作怎么处理
    [self becomeFirstResponder];
    
    //2.设置UIMenuController
    UIMenuController * menu = [UIMenuController sharedMenuController];
    
    //自定义 UIMenuController
    
    UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"剪切" action:@selector(myCut:)];
    UIMenuItem * item2 = [[UIMenuItem alloc]initWithTitle:@"粘贴" action:@selector(myPaste:)];
    menu.menuItems = @[item1,item2];
    
    NSLog(@"%d",menu.isMenuVisible);
    //当长按label的时候，这个方法会不断调用，menu就会出现一闪一闪不断显示，需要在此处进行判断
    if (menu.isMenuVisible)return;
    /**
     *  设置UIMenuController的显示相关信息
     *
     *  @param targetRect UIMenuController 需要指向的矩形框
     *  @param targetView targetRect会以targetView的左上角为坐标原点进行显示
     */
//    - (void)setTargetRect:(CGRect)targetRect inView:(UIView *)targetView;
    [menu setTargetRect:self.bounds inView:self];
//    [menu setTargetRect:self.frame inView:self.superview];
    
    [menu setMenuVisible:YES animated:YES];
    
}

#pragma mark - 对控件权限进行设置
/**
 *  设置label可以成为第一响应者
 *
 *  @注意：不是每个控件都有资格成为第一响应者
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
/**
 *  设置label能够执行那些具体操作
 *
 *  @param action 具体操作
 *
 *  @return YES:支持该操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
//    NSLog(@"%@",NSStringFromSelector(action));
    
    if(action == @selector(cut:) || action == @selector(copy:) || action == @selector(myCut:)|| action == @selector(myPaste:)) return YES;
    return NO;
}

/**  系统默认方法：
 
 *  cut:
    copy:
    select:
    selectAll:
    paste:
    delete:
    _promptForReplace:
   _transliterateChinese:
   _showTextStyleOptions:
   _define:
   _addShortcut:
   _accessibilitySpeak:
   _accessibilitySpeakLanguageSelection:
   _accessibilityPauseSpeaking:
   _share:
   makeTextWritingDirectionRightToLeft:
   makeTextWritingDirectionLeftToRight:
 */

#pragma mark - 方法的实现
//- (void)cut:(id)sender
//{
//    
//    NSLog(@"%@",sender);
//    
//}

- (void)myCut:(UIMenuController *) menu
{
    NSLog(@"%s---%@",__func__,menu);
    //复制文字到剪切板
    [self copy:menu];
    //清空文字
    self.text = nil;
    
}

- (void)cut:(UIMenuController *)menu
{
    NSLog(@"%s---%@",__func__,menu);

    //复制文字到剪切板
    [self copy:menu];
    //清空文字
    self.text = nil;
    
}

- (void)copy:(UIMenuController *)menu
{
    //当没有文字的时候调用这个方法会崩溃
     if (!self.text) return;
    //复制文字到剪切板
    UIPasteboard * paste = [UIPasteboard generalPasteboard];
    paste.string = self.text;

}

- (void)myPaste:(UIMenuController *)menu
{
    //将剪切板文字赋值给label
    UIPasteboard * paste = [UIPasteboard generalPasteboard];
    self.text = paste.string;
}

@end
