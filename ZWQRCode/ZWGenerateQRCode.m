//
//  ZWGenerateQRCode.m
//  ZWQRCode
//
//  Created by 崔先生的MacBook Pro on 2023/2/11.
//

#import "ZWGenerateQRCode.h"

@implementation ZWGenerateQRCode

#pragma mark - genarate QR code

- (UIImage*)getQRCodeWithContentTxt:(NSString*)urlString codeWidth:(CGFloat)codeWidth picImg:(UIImage*)picImg {
    //使用名为 CIQRCodeGenerator 的过滤器创建一个CIFilter对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    [filter setDefaults];

    NSData *data = [urlString dataUsingEncoding:NSUTF8StringEncoding];

    //通过kvo方式给一个字符串，生成二维码
    [filter setValue:data forKey:@"inputMessage"];

    //含文本信息的二维码已经生成

    CIImage *filterImg = [filter outputImage];

    CIImage *imageOri = [CIImage imageWithCGImage:[self filterQRCodeWithCIImage:filterImg codeWidth:codeWidth].CGImage];

    UIImage *img = [UIImage imageWithCIImage:imageOri];//默认二维码

    //------------------------------------------------------

    //-------对二维码增添颜色，不需要的可以跳过----------

    CIFilter* color_filter = [CIFilter filterWithName:@"CIFalseColor"];

    [color_filter setDefaults];

    [color_filter setValue:imageOri forKey:@"inputImage"];

    //设置二维码的颜色（二维码都是由2个颜色组成，可自行改变尝试效果）

    [color_filter setValue:[CIColor colorWithRed:66/255.0 green:147/255.0 blue:82/255.0] forKey:@"inputColor0"];

    [color_filter setValue:[CIColor clearColor]forKey:@"inputColor1"];

    CIImage *colorImage = [color_filter outputImage];

    img = [UIImage imageWithCIImage:colorImage];//修改颜色的二维码

    //-------对二维码增添颜色，不需要的可以跳过----------

    //------------------------------------------------------

    //开启图形上下文(会变模糊)
    //UIGraphicsBeginImageContext(img.size);
    //开启图形上下文(防止虚化模糊)
    UIGraphicsBeginImageContextWithOptions(img.size,NO,[[UIScreen mainScreen]scale]);
    //将二维码的图片画入
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];

    //------------------------------------------------------

    //-------二维码中间插入小插图，不需要的可以跳过----------

    UIImage *centerImg = picImg;

    CGFloat centerW = img.size.width*0.2;

    CGFloat centerH = centerW;

    CGFloat centerX = (img.size.width-centerW)*0.5;

    CGFloat centerY = (img.size.height-centerH)*0.5;

    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];

    //-------二维码中间插入小插图，不需要的可以跳过----------

    //------------------------------------------------------

    //5.3获取绘制好的图片

    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();

    //5.4关闭图像上下文

    UIGraphicsEndImageContext();

    return finalImg;

}

- (UIImage *)filterQRCodeWithCIImage:(CIImage *)image codeWidth:(CGFloat)codeWidth{
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(codeWidth/CGRectGetWidth(extent), codeWidth/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef =CGBitmapContextCreate(nil, width, height,8,0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext*context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    
    CGImageRef scaledImage =CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}

@end
