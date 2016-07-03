//
//  YWSpritesLoadingView.m
//  YYW
//
//  Created by xingyong on 12/11/14.
//  Copyright (c) 2014 YYW. All rights reserved.
//

#import "YWSpritesLoadingView.h"

@implementation YWSpritesLoadingView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _loadingImageView=[[UIImageView alloc] initWithFrame:self.bounds];
 
        _loadingImageView.layer.zPosition = MAXFLOAT;
        NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
        
        for (int i =1; i<19; i++) {
            
            [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"SCGifImage%d.png",i]]];

        }
        
        _loadingImageView.animationImages = imageArray;
        _loadingImageView.animationDuration = 1;
        [_loadingImageView startAnimating];

        [self addSubview:_loadingImageView];
        
        
    }
    return self;
}

- (void)dealloc{
    [_loadingImageView stopAnimating];
    [_loadingImageView removeFromSuperview];
    _loadingImageView = nil;

}

 
@end
