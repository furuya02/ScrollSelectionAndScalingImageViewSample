//
//  ViewController.m
//  ScrollSelectionAndScalingImageViewSample
//
//  Created by hirauchi.shinichi on 2016/06/23.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+TouchEvent.h"
#import "ImageScrollView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIScrollView *selectScrollView;
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (weak, nonatomic) IBOutlet UIScrollView *imageScroolView;
@property (weak, nonatomic) IBOutlet ImageScrollView *imageScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //_imageScroolView.delegate = self;

    //_imageScroolView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //_imageScroolView.pagingEnabled = NO;
    //_imageScroolView.bouncesZoom = NO;
    //_imageScroolView.showsHorizontalScrollIndicator = NO;
    //_imageScroolView.showsVerticalScrollIndicator = NO;
//
//
//    _imageScroolView.minimumZoomScale = 4.0f;

    //_imageScroolView.minimumZoomScale = 1.0;
    //_imageScroolView.maximumZoomScale = 4.0;

}

- (void)viewDidAppear:(BOOL)animated{

    //UIScrollView.contentSizeは、表示する写真の数に応じて変化させる

    // 写真を配置する　元写真の大きさからサイズを決定する
    const int baseSize = 100;
    const int space = 10;
    int offSet = 10;
    for(int i=0; i<30; i++) {

        NSString *photoName = [NSString stringWithFormat:@"%3.3d.jpg",i+1];
        UIImage *image = [UIImage imageNamed:photoName];


        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];


        CGSize size = image.size;
        if ( size.width < size.height){ // portrait
            int width = baseSize * (size.width / size.height);
            imageView.frame = CGRectMake(offSet, space, width, baseSize);
            offSet += width + space;
        } else { // landscape
            int height = baseSize * (size.height / size.width);
            imageView.frame = CGRectMake(offSet ,space + (baseSize - height)/2, baseSize, height);
            offSet += baseSize + space;
        }
        imageView.userInteractionEnabled = YES;//タッチイベントを受け取る
        imageView.tag = i+1;
        [_selectView addSubview:imageView];

    }
    _selectScrollView.contentSize = CGRectMake(0, 0, offSet, 100 + space * 2).size;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSLog( @"%ld",touch.view.tag );
    if (touch.view.tag > 0) {
        NSString *photoName = [NSString stringWithFormat:@"%3.3ld.jpg",touch.view.tag];
        [_imageScrollView setImage:[UIImage imageNamed:photoName]];

//        CGSize size = _imageView.image.size;
//        // imageViewのサイズがscrollView内に収まるように調整
//        float wrate = _imageScroolView.frame.size.width / size.width;
//        float hrate = _imageScroolView.frame.size.height / size.height;
//        float rate = MIN(wrate,hrate);
//
//
//        _imageView.frame = CGRectMake(0, 0, size.width * rate, size.height * rate);
//        _imageScroolView.contentSize = _imageView.frame.size;
//        [self updateScrollInset];
    }
}

//- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView
//{
//    return _imageView;
//}
//
//- (void)scrollViewDidZoom:(UIScrollView*)scrollView
//{
//    [self updateScrollInset];
//}

//- (void) updateScrollInset {
//    // imageViewの大きさからcontentInsetを再計算
//    // なお、0を下回らないようにする
////    _imageScroolView.contentInset = UIEdgeInsetsMake(
////                                               max((scrollView.frame.height - imageView.frame.height)/2, 0),
////                                               max((scrollView.frame.width - imageView.frame.width)/2, 0),
////                                               0,
////                                               0
////                                               );
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
