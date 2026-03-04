//
//  UIImage+QS.m
//  QsmKit
//
//  Created by Paul on 2024/1/29.
//

#import "UIImage+QS.h"

@implementation UIImage (QS)

+ (UIImage *)imageBundleNamed:(NSString *)bundleName{
    
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"QSToast")];
    
    // 首先尝试从 toastkit bundle 中加载
    NSString *bundlePath = [bundle pathForResource:@"toastkit" ofType:@"bundle"];
    if (bundlePath) {
        NSBundle *toastkitBundle = [NSBundle bundleWithPath:bundlePath];
        if (toastkitBundle) {
            // 移除 .png 扩展名（如果存在）
            NSString *imageName = bundleName;
            if ([imageName hasSuffix:@".png"]) {
                imageName = [imageName stringByDeletingPathExtension];
            }
            UIImage *image = [UIImage imageNamed:imageName inBundle:toastkitBundle compatibleWithTraitCollection:nil];
            if (image) {
                return image;
            }
        }
    }
    
    // 如果 bundle 加载失败，尝试直接使用 imageNamed（兼容性回退）
    return [UIImage imageNamed:bundleName];
}

@end
