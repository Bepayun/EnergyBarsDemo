//
//  EnergyProgressLayer.m
//  EnergyBarsDemo
//
//  Created by Bepa on 2019/8/2.
//  Copyright © 2019 Bepa. All rights reserved.
//

#import "EnergyProgressLayer.h"

static CALayer* hand_layer(CGFloat contentsScale) {
    CALayer* layer = [CALayer layer];
    layer.contentsScale = contentsScale;
    layer.shouldRasterize = YES;
    layer.opaque = YES;
    return layer;
}

@interface EnergyProgressLayer () {
    CALayer* _topBlueLayer;
    CALayer* _bottomBlueLayer;
    CALayer* _topRedLayer;
    CALayer* _bottomRedLayer;
    
    CGFloat _offsetWidth;
    
    
    UIBezierPath* _bluePath;
    UIBezierPath* _redPath;
}
@property(nonatomic) CGFloat layerWidth;

@end

@implementation EnergyProgressLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        CGFloat scale = ScreenScale;
        _progress = 0.5;
        _offsetWidth = 4.f;
        _layerHeight = 15.f;
        _layerWidth = ScreenWidth;
        
        self.masksToBounds = YES;
        
        _topRedLayer = hand_layer(scale);
        _bottomRedLayer = hand_layer(scale);
        _topBlueLayer = hand_layer(scale);
        _bottomBlueLayer = hand_layer(scale);
        
        _topBlueLayer.backgroundColor = [UIColor colorWithRed:124 / 255.0f
                                                        green:171 / 255.0f
                                                         blue:255 / 255.0f
                                                        alpha:1]
        .CGColor;
        _bottomBlueLayer.backgroundColor = [UIColor colorWithRed:76 / 255.0f
                                                           green:139 / 255.0f
                                                            blue:253 / 255.0f
                                                           alpha:1]
        .CGColor;
        
        _topRedLayer.backgroundColor = [UIColor colorWithRed:252 / 255.0f
                                                       green:108 / 255.0f
                                                        blue:132 / 255.0f
                                                       alpha:1]
        .CGColor;
        _bottomRedLayer.backgroundColor = [UIColor colorWithRed:247 / 255.0f
                                                          green:74 / 255.0f
                                                           blue:103 / 255.0f
                                                          alpha:1]
        .CGColor;
        
        [_topRedLayer addSublayer:_bottomRedLayer];
        [_topBlueLayer addSublayer:_bottomBlueLayer];
        
        [self addSublayer:_topRedLayer];
        [self addSublayer:_topBlueLayer];
        
        CGFloat halfHeight = _layerHeight / 2.f;
        CGFloat layerWidth = _offsetWidth + _layerWidth;
        _topRedLayer.bounds = CGRectMake(0, 0, layerWidth, _layerHeight);
        _bottomRedLayer.frame = CGRectMake(0, halfHeight, layerWidth, halfHeight);
        
        _topBlueLayer.bounds = CGRectMake(0, 0, layerWidth, _layerHeight);
        _bottomBlueLayer.frame = CGRectMake(0, halfHeight, layerWidth, halfHeight);
        
        _bluePath = [UIBezierPath bezierPath];
        _redPath = [UIBezierPath bezierPath];
        
        CALayer* blueMasklayer = _topBlueLayer.mask;
        CAShapeLayer* blueLayer =
        blueMasklayer ? (CAShapeLayer*)blueMasklayer : [CAShapeLayer layer];
        
        [_bluePath moveToPoint:CGPointMake(0, 0)];
        [_bluePath addLineToPoint:CGPointMake(layerWidth, 0)];
        [_bluePath
         addLineToPoint:CGPointMake(layerWidth - _offsetWidth, _layerHeight)];
        [_bluePath addLineToPoint:CGPointMake(0, _layerHeight)];
        [_bluePath closePath];
        
        blueLayer.path = _bluePath.CGPath;
        if (!blueMasklayer) {
            _topBlueLayer.mask = blueLayer;
        }
        
        CALayer* redMasklayer = _topRedLayer.mask;
        CAShapeLayer* redLayer =
        redMasklayer ? (CAShapeLayer*)redMasklayer : [CAShapeLayer layer];
        
        [_redPath moveToPoint:CGPointMake(_offsetWidth, 0)];
        [_redPath addLineToPoint:CGPointMake(layerWidth, 0)];
        [_redPath addLineToPoint:CGPointMake(layerWidth, _layerHeight)];
        [_redPath addLineToPoint:CGPointMake(0, _layerHeight)];
        [_redPath closePath];
        
        redLayer.path = _redPath.CGPath;
        if (!redMasklayer) {
            _topRedLayer.mask = redLayer;
        }
        
        _topRedLayer.anchorPoint = CGPointMake(0, 0);
        _topBlueLayer.anchorPoint = CGPointMake(1, 0);
    }
    return self;
}
#pragma mark - Overides
- (void)layoutSublayers {
    [super layoutSublayers];
    
    if (_progress <= 0) {
        _topBlueLayer.position = CGPointMake(0, 0);
        _topRedLayer.position = CGPointMake(-_offsetWidth, 0);
        return;
    }
    
    CGFloat offset = (_progress >= 1) ? _offsetWidth : _offsetWidth / 2.f;
    CGFloat x = _layerWidth * _progress;
    
    _topBlueLayer.position = CGPointMake(x + offset, 0);
    _topRedLayer.position = CGPointMake(x - offset, 0);
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsLayout];
}

@end
