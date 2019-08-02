//
//  EnergyProgressView.m
//  EnergyBarsDemo
//
//  Created by Bepa on 2019/8/2.
//  Copyright © 2019 Bepa. All rights reserved.
//

#define VIEW_LAYER(VIEW) ((EnergyProgressLayer*)VIEW.layer)

#import "EnergyProgressView.h"
#import "EnergyProgressLayer.h"

@implementation EnergyProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        VIEW_LAYER(self).bounds =
        CGRectMake(0, 0, frame.size.width, frame.size.height);
        VIEW_LAYER(self).layerHeight = 15.f;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    VIEW_LAYER(self).progress = progress;
}
#pragma mark - layer -
+ (Class)layerClass {
    return [EnergyProgressLayer class];
}

@end
