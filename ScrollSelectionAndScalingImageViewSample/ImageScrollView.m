//
//  ImageScrollView.m
//  ScrollSelectionAndScalingImageViewSample
//
//  Created by hirauchi.shinichi on 2016/06/23.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import "ImageScrollView.h"

@interface ImageScrollView () <UIScrollViewDelegate>

// スクロールビューの中に配置するイメージビュー
@property UIImageView *imageView;

@end

@implementation ImageScrollView



- (void)awakeFromNib
{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bouncesZoom = YES; // スクロール外までスクロールしてバウンドして戻る動作
    self.decelerationRate = UIScrollViewDecelerationRateFast; // スクロールのスピード
    self.delegate = self;
}

- (void)setImage:(UIImage *)image
{
    // 新しい画像でビューを再作成する
    [self.imageView removeFromSuperview];
    self.imageView = nil;
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:self.imageView];

    //画像のサイズを倍率にすればスクロールビュー（画面）いっぱいになるかを計算する
    float scale = 0;
    if ( image.size.width < image.size.height){
        // ポートレートの場合は、縦のサイズを基準に縮尺を得る
        scale = self.bounds.size.height / image.size.height;
    } else {
        // ランドスケープの場合は、横のサイズを基準に縮尺を得る
        scale= self.bounds.size.width / image.size.width;
    }
    self.minimumZoomScale = scale; // 現在のサイズが最小とする
    self.maximumZoomScale = scale * 7; // 拡大は7倍まで可能
    self.zoomScale = scale; // 当初画面いっぱいで表示する

    // 画像ビューを中央に配置する
    // 初期値　X=0,Y=0とする
    CGRect newFrame = CGRectMake(0,0,self.imageView.frame.size.width,self.imageView.frame.size.height);
    // 水平方向余白がある場合はX座標をずらす
    if (self.imageView.frame.size.width < self.bounds.size.width)
        newFrame.origin.x = (self.bounds.size.width - self.imageView.frame.size.width) / 2;
    // 垂直方向余白がある場合はY座標をずらす
    if (self.imageView.frame.size.height < self.bounds.size.height)
        newFrame.origin.y = (self.bounds.size.height - self.imageView.frame.size.height) / 2;
    self.imageView.frame = newFrame;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end



