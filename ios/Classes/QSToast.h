//
//  QSToast.h
//  toastkit
//

#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSToast : SVProgressHUD

+ (void)showText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion;
+ (void)showWarnWithText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion;
+ (void)showSuccessWithText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion;
+ (void)showErrorWithText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion;

@end

NS_ASSUME_NONNULL_END
