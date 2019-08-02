//
//  EnergyProgressLayer.h
//  EnergyBarsDemo
//
//  Created by Bepa on 2019/8/2.
//  Copyright © 2019 Bepa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnergyProgressLayer : CALayer

@property(nonatomic) CGFloat layerHeight;
@property(nonatomic) CGFloat progress;

@end

NS_ASSUME_NONNULL_END
