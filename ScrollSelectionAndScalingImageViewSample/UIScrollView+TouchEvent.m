//
//  UIScrollView+TouchEvent.m
//  ScrollSelectionAndScalingImageViewSample
//
//  Created by hirauchi.shinichi on 2016/06/23.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//


#import "UIScrollView+TouchEvent.h"

@implementation UIScrollView(TouchEvent)
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self nextResponder] touchesBegan:touches withEvent:event];
}
@end



