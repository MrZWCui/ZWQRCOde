//
//  ZWQRCodeViewController.m
//  ZWQRCode
//
//  Created by 崔先生的MacBook Pro on 2023/2/10.
//

#import "ZWQRCodeViewController.h"
#import "ZWQRCodeView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ZWQRCodeViewController ()

@property (nonatomic, strong) ZWQRCodeView *QRCodeView;

@end

@implementation ZWQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:240/255.0 alpha:1.0];
    _QRCodeView = [[ZWQRCodeView alloc] initWithFrame:CGRectMake(0, 80, kWidth, kHeight - 80)];
    [self.view addSubview:_QRCodeView];
    
    __weak typeof(self) weakSelf = self;
    _QRCodeView.toastBlock = ^{
        // 添加提示框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Save QRCode?" message:@"The QRCode will be saved in Camera Roll album." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 保存二维码图像
            [weakSelf saveQRCodeImage];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:saveAction];
        [alertController addAction:cancelAction];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
}

- (void)saveQRCodeImage {
    // 保存图像,需要提前在info.plist文件中写入访问相册的权限,否则会报错
    UIImageWriteToSavedPhotosAlbum(_QRCodeView.QRCodeImage.image, nil, nil, nil);
}

@end
