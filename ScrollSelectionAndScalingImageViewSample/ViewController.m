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
@property (weak, nonatomic) IBOutlet ImageScrollView *imageScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{

    // 写真を配置する　元写真の大きさからサイズを決定する
    const NSInteger baseSize = 100;
    const NSInteger space = 10;
    NSInteger offSet = 10;
    for (NSInteger i=0; i<30; i++) {

        NSString *photoName = [NSString stringWithFormat:@"%3.3ld.jpg",i+1];
        UIImage *image = [UIImage imageNamed:photoName];

        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

        CGSize size = image.size;
        if ( size.width < size.height){ // portrait
            NSInteger width = baseSize * (size.width / size.height);
            imageView.frame = CGRectMake(offSet, space, width, baseSize);
            offSet += width + space;
        } else { // landscape
            NSInteger height = baseSize * (size.height / size.width);
            imageView.frame = CGRectMake(offSet ,space + (baseSize - height)/2, baseSize, height);
            offSet += baseSize + space;
        }
        imageView.userInteractionEnabled = YES;//タッチイベントを受け取る
        imageView.tag = i+1;
        [self.selectView addSubview:imageView];

    }
    self.selectScrollView.contentSize = CGRectMake(0, 0, offSet, 100 + space * 2).size;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSLog( @"%ld",touch.view.tag );
    if (touch.view.tag > 0) {
        NSString *photoName = [NSString stringWithFormat:@"%3.3ld.jpg",touch.view.tag];
        [self.imageScrollView setImage:[UIImage imageNamed:photoName]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
