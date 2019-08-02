//
//  ViewController.m
//  EnergyBarsDemo
//
//  Created by Bepa on 2019/8/2.
//  Copyright © 2019 Bepa. All rights reserved.
//

#import "ViewController.h"
#import "EnergyBarsView.h"
#import "Masonry.h"

@interface ViewController ()

@property(nonatomic, strong) EnergyBarsView* energyBarsView;

@end

@implementation ViewController

- (EnergyBarsView*)energyBarsView {
    if (_energyBarsView == nil) {
        _energyBarsView = [[EnergyBarsView alloc] init];
        _energyBarsView.energyScale = 0.3;
    }
    return _energyBarsView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self energyBarsWithDataWithAttackerDouScore:20000 defenderDouScore:5000];
    [self initUI];
    [self initLayouts];
}
- (void)energyBarsWithDataWithAttackerDouScore:(long long)attackerDouScore defenderDouScore:(long long)defenderDouScore {
    
    CGFloat averageDouScore;    if (attackerDouScore == defenderDouScore) {
        averageDouScore = 0.5;
    } else if (attackerDouScore > 0 && defenderDouScore > 0) {
        averageDouScore =
        ((CGFloat)attackerDouScore / (attackerDouScore + defenderDouScore));
        
    } else if (attackerDouScore < 0 && defenderDouScore < 0) {
        averageDouScore = 1.0 - ((CGFloat)attackerDouScore /
                                 (attackerDouScore + defenderDouScore));
        
    } else if ((attackerDouScore <= 0 && defenderDouScore > 0) ||
               (attackerDouScore < 0 && defenderDouScore == 0)) {
        averageDouScore = 0;
    } else {
        averageDouScore = 1;
    }
    
    // 1是蓝色[我方]占满 0是红色[敌方]占满
    _energyBarsView.energyScale = averageDouScore;
    _energyBarsView.leftText = [NSString stringWithFormat:@"我方 %@", @(attackerDouScore)];
    _energyBarsView.rightText = [NSString stringWithFormat:@"%@ 敌方", @(defenderDouScore)];
}
- (void)initUI {
    [self.view addSubview:self.energyBarsView];
}
- (void)initLayouts {
    __weak typeof(&*self) weakSelf = self;
    CGFloat energyH = 15;
    // 能量条View
    [_energyBarsView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerY.mas_equalTo(weakSelf.view.mas_centerY);
        make.left.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(@(energyH));
    }];
}

@end
