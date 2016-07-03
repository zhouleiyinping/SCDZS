/*
 *  UIViewController+MBProgressHUD.h
 *
 *  Created by Adam Duke on 10/20/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
 

@interface UIViewController (MBProgressHUD) <MBProgressHUDDelegate>
 

typedef void (^HUDFinishedHandler)();


/*
 * Shows an MBProgressHUD with the default spinner
 * The HUD is added as a subview to this view
 * controller's parentViewController.view.
 */
- (void)showHUD;

/*
 * Shows an MBProgressHUD with the default spinner
 * The HUD is added as a subview to this view
 * controller's parentViewController.view.
 * cover: YES-cover the navBar NO-not cover the navBar
 */
- (void)showHUDWithCoverFlag:(BOOL)cover;

/*
 * Shows an MBProgressHUD with the default spinner
 * and sets the label text beneath the spinner
 * to the given message. The HUD is added as a subview
 * to this view controller's parentViewController.view.
 */
- (void)showHUDWithMessage:(NSString *)message;

/*
 * Dismisses the currently displayed HUD.
 */
- (void)hideHUD;

/*
 * Changes the currently displayed HUD's label text to
 * the given message and then dismisses the HUD after a
 * short delay.
 */
- (void)hideHUDWithCompletionMessage:(NSString *)message;

/*
 *  仅显示文字
 *  xiexu add 20150108
 *
 */
- (void)hideHUDWithOnlyMessage:(NSString *)message;

/**
 *  这个是仅仅显示文字，用于提示作用
 *
 *  @param words 提示文字
 */
- (void)showOnlyWords:(NSString *)words;

/*!
 @brief 显示错误提示
 
 @param message 错误提示文字
 */
- (void)showErrorHUDWithMessage:(NSString *)message;

/*
 * Changes the currently displayed HUD's label text to
 * the given message and then dismisses the HUD after a
 * short delay. Additionally, runs the given completion
 * block after the HUD hides.
 */

- (void)hideHUDWithCompletionFailMessage:(NSString *)message;

- (void)hideHUDWithCompletionMessage:(NSString *)message finishedHandler:(HUDFinishedHandler)finishedHandler;

- (void)hideHUDWithFailMessage:(NSString *)message finishedHandler:(HUDFinishedHandler)finishedHandler;
- (void)showHUDwithTime;
 
@end
