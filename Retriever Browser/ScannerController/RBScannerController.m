//
//  RBScannerController.m
//  Retriever Browser
//
//  Created by Mark on 15/11/30.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBScannerController.h"
#import <ZXingObjC/ZXingObjC.h>
#import "RBWebViewController.h"

@interface RBScannerController () <ZXCaptureDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, strong) UIView *scanRectView;
@property (nonatomic, strong) NSString *content;
@end

static CGFloat const RBScanRectViewWM = 300;
@implementation RBScannerController

- (void)dealloc {
    [self.capture.layer removeFromSuperlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
    
    self.scanRectView = [[UIView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH - RBScanRectViewWM)/2, 120, RBScanRectViewWM, RBScanRectViewWM)];
    self.scanRectView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.scanRectView.layer.borderWidth = 1.0;
    [self.view addSubview:self.scanRectView];
    [self.view bringSubviewToFront:self.scanRectView];
    
    UILabel *indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scanRectView.bottom + 50, UI_SCREEN_WIDTH, 50)];
    indicatorLabel.text = @"二维码对准放入上面的框中";
    indicatorLabel.textAlignment = NSTextAlignmentCenter;
    indicatorLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    indicatorLabel.textColor = RGBCOLOR(243, 79, 74);
    [self.view addSubview:indicatorLabel];
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 84)];
    [back setImage:[UIImage imageNamed:@"icon_footer_0"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.capture.delegate = self;
    self.capture.layer.frame = self.view.bounds;
    
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    self.capture.scanRect = CGRectApplyAffineTransform(self.scanRectView.frame, captureSizeTransform);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}
#pragma mark - Private Methods

- (void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;
    // We got a result. Display information about the result onscreen.
    NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
    self.content = result.text;
    NSString *display = [NSString stringWithFormat:@"Scanned!\n\nFormat: %@\n\nContents:\n%@", formatString, self.content];
    
    NSLog(@"%@ %@", formatString, display);
    // Vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [self.capture stop];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.capture start];
    });
    
    if ([self.content containsString:@"http://"] || [self.content containsString:@"https://"]) {
        NSString *show = [NSString stringWithFormat:@"是否跳转到\n %@", self.content];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:show delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:formatString message:display delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        RBWebViewController *webViewController = [[RBWebViewController alloc] initWithStrURL:self.content];
        self.content = nil;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

@end
