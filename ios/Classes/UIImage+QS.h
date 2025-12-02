//
//  UIImage+QS.h
//  QsmKit
//
//  Created by Paul on 2024/1/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QS)

/// 获取sdk内图片
/// - Parameter bundleName: 图片名称.png
+ (UIImage *)imageBundleNamed:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
