//
//  QSTosat.m
//  QsmKit
//
//  Created by Paul on 2024/1/29.
//

#import "QSToast.h"
#import "UIImage+QS.h"

@implementation QSToast

+ (void)show{
    [SVProgressHUD show];
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

+ (void)dismiss:(SVProgressHUDDismissCompletion)completion{
    [SVProgressHUD dismissWithCompletion:completion];
}

+ (void)showProgres:(float)value{
    [SVProgressHUD showProgress:value];
}

+ (void)showProgres:(float)value text:(NSString *)text{
    [SVProgressHUD showProgress:value status:text];
}

+ (void)showInfoWithText:(NSString *)text{
    [QSToast showText:text completion:^{
        
    }];
}

+ (void)showWarnWithText:(NSString *)text{
    [QSToast showWarnWithText:text completion:^{
        
    }];
}

+ (void)showSuccessWithText:(NSString *)text{
    [QSToast showSuccessWithText:text completion:^{
        
    }];
}

+ (void)showErrorWithText:(NSString *)text{
    [QSToast showErrorWithText:text completion:^{
        
    }];
}

+ (void)showText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion{
    
    UIImage *image;
    [SVProgressHUD showImage:image status:text];
    [QSToast dismissDelayWithCompletion:completion];
}

+ (void)showWarnWithText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion{

    UIImage *image = [UIImage imageBundleNamed:@"icon_toast_info"];
    [SVProgressHUD showImage:image status:text];
    [QSToast dismissDelayWithCompletion:completion];
}

+ (void)showSuccessWithText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion{
    
    UIImage *image = [UIImage imageBundleNamed:@"icon_toast_success"];
    [SVProgressHUD showImage:image status:text];
    [QSToast dismissDelayWithCompletion:completion];
}

+ (void)showErrorWithText:(NSString *)text completion:(SVProgressHUDDismissCompletion)completion{
    
    UIImage *image = [UIImage imageBundleNamed:@"icon_toast_fail"];
    [SVProgressHUD showImage:image status:text];
    [QSToast dismissDelayWithCompletion:completion];
}

+ (void)dismissDelayWithCompletion:(SVProgressHUDDismissCompletion)completion{
    
    [SVProgressHUD dismissWithDelay:1.6 completion:completion];
}

@end
