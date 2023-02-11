//
//  ZWGenerateQRCode.h
//  ZWQRCode
//
//  Created by 崔先生的MacBook Pro on 2023/2/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWGenerateQRCode : NSObject

- (UIImage*)getQRCodeWithContentTxt:(NSString*)urlString codeWidth:(CGFloat)codeWidth picImg:(UIImage*)picImg;

@end

NS_ASSUME_NONNULL_END
