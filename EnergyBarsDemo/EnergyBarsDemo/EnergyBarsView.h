//
//  EnergyBarsView.h
//  EnergyBarsDemo
//
//  Created by Bepa on 2019/8/2.
//  Copyright © 2019 Bepa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnergyBarsView : UIView

@property(nonatomic) CGFloat energyScale;

@property(nonatomic, copy) NSString* leftText;
@property(nonatomic, copy) NSString* rightText;
@property(nonatomic, copy) NSString* centerText;

@end

NS_ASSUME_NONNULL_END
