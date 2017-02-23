//
//  InputView.m
//  XMLL2
//
//  Created by zzddn on 2017/1/29.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import "InputView.h"

@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        
        self.inputTextView = [[UITextView alloc]initWithFrame:CGRectMake(5+ 20 +5, 5, 230, 30)];
        self.inputTextView.layer.masksToBounds = YES;
        self.inputTextView.font = [UIFont systemFontOfSize:15];
        self.inputTextView.layer.cornerRadius = 5;
        self.inputTextView.layer.borderWidth = 0.5f;
        self.inputTextView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]);
        self.inputTextView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.inputTextView];
}
        return self;
}
@end

