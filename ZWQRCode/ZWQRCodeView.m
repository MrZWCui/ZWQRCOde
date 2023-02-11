//
//  ZWQRCodeView.m
//  ZWQRCode
//
//  Created by 崔先生的MacBook Pro on 2023/2/11.
//

#import "ZWQRCodeView.h"
#import "ZWGenerateQRCode.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ZWQRCodeView ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UISlider *slider;//控制image大小

@end

@implementation ZWQRCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapOnView:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self];
    NSLog(@"Tap at %1.0f, %1.0f", location.x, location.y);
    [_textField endEditing:YES];
}

- (void)initUI {
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 20, kWidth - 60, 50)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 10;
    _textField.placeholder = @"Please enter the content or website";
    [self addSubview:_textField];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 130, 90, 100, 40)];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    [btn setTitle:@"Generate" forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(generatorQRCode) forControlEvents:UIControlEventTouchUpInside];
    
    _QRCodeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _QRCodeImage.center = CGPointMake(kWidth / 2, 350);
    [self addSubview:_QRCodeImage];
    //打开手势响应
    _QRCodeImage.userInteractionEnabled = YES;
    //设置长按手势,saveImageAction为长按后的操作
    UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveImageAction)];
    //把长按手势添加到按钮
    [_QRCodeImage addGestureRecognizer:tapPress];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, kHeight - 80 - 130, kWidth - 100, 50)];
    _slider.tintColor = [UIColor colorWithRed:66/255.0 green:147/255.0 blue:82/255.0 alpha:1.0];
    //初始值设置为0.5
    [_slider setValue:0.5];
    //默认隐藏,生成二维码后呈现
    _slider.hidden = YES;
    [_slider addTarget:self action:@selector(changeScale) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_slider];
}

/// 修改image的大小
- (void)changeScale {
    _QRCodeImage.transform = CGAffineTransformMakeScale(self.slider.value + 0.5, self.slider.value + 0.5);
}

- (void)saveImageAction {
    if (_toastBlock) {
        self.toastBlock();
    }
    NSLog(@"123");
}

#pragma mark - generate QRCode

- (void)generatorQRCode {
    ZWGenerateQRCode *generateQRCode = [ZWGenerateQRCode new];
    UIImage *qrcodeImg = [generateQRCode getQRCodeWithContentTxt:_textField.text codeWidth:600 picImg:[UIImage imageNamed:@"img"]];
    _QRCodeImage.image = qrcodeImg;
    [_textField endEditing:YES];
    _slider.hidden = NO;
}

@end
