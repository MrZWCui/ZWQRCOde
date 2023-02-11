//
//  ZWQRCodeView.h
//  ZWQRCode
//
//  Created by 崔先生的MacBook Pro on 2023/2/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWQRCodeView : UIView

@property (nonatomic, copy) void(^toastBlock)(void);
@property (nonatomic, strong) UIImageView *QRCodeImage;//二维码图片

@end

NS_ASSUME_NONNULL_END
