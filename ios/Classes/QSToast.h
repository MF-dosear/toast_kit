//
//  QSTosat.h
//  QsmKit
//
//  Created by Paul on 2024/1/29.
//

#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSToast : SVProgressHUD

@property (nonatomic, assign) NSTimeInterval delay;

+ (void)show;

+ (void)dismiss;

+ (void)dismiss:(SVProgressHUDDismissCompletion)completion;

+ (void)showProgres:(float)value;

+ (void)showProgres:(float)value text:(NSString *)text;

+ (void)showInfoWithText:(NSString*)text;

+ (void)showWarnWithText:(NSString*)text;

+ (void)showSuccessWithText:(NSString*)text;

+ (void)showErrorWithText:(NSString*)text;

+ (void)showText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion;

+ (void)showWarnWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion;

+ (void)showSuccessWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion;

+ (void)showErrorWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion;

+ (void)dismissDelayWithCompletion:(SVProgressHUDDismissCompletion)completion;

@end

NS_ASSUME_NONNULL_END
