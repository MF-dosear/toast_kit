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
    
    NSString *path = [bundle pathForResource:@"toastkit" ofType:@"bundle"];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.png", path, bundleName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

@end
