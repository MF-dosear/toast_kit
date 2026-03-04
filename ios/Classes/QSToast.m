//
//  QSTosat.m
//  QsmKit
//
//  Created by Paul on 2024/1/29.
//

#import "QSToast.h"
#import "UIImage+QS.h"

static double const delay = 1.6;

@implementation QSToast

+ (void)showText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion{
    UIImage *image = nil;
    [SVProgressHUD showImage:image status:text];
    [SVProgressHUD dismissWithDelay:delay completion:completion];
}

+ (void)showWarnWithText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion{

    UIImage *image = [UIImage imageBundleNamed:@"icon_toast_info"];
    [SVProgressHUD showImage:image status:text];
    [SVProgressHUD dismissWithDelay:delay completion:completion];
}

+ (void)showSuccessWithText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion{
    
    UIImage *image = [UIImage imageBundleNamed:@"icon_toast_success"];
    [SVProgressHUD showImage:image status:text];
    [SVProgressHUD dismissWithDelay:delay completion:completion];
}

+ (void)showErrorWithText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion{
    
    UIImage *image = [UIImage imageBundleNamed:@"icon_toast_fail"];
    [SVProgressHUD showImage:image status:text];
    [SVProgressHUD dismissWithDelay:delay completion:completion];
}

@end
