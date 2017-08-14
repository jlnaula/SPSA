//
//  UIColor+SPSA.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SPSA)
+ (UIColor *)spsaBackgroundView;
+ (UIColor *)spsaTextColor;
+ (UIColor *)spsaNavigationBarBackgroundRedColor;
+ (UIColor *)spsaNavigationBarBackgroundGreenColor;
+ (UIColor *)spsaRed;
+ (UIColor *)spsaGreen;
+ (UIColor *)spsaAlternativeButtonLightGray;
+ (UIColor *)spsaAlternativeButtonSelectedYellow;
+ (UIColor *)spsaAlternativeButtonSelectedRed;
+ (UIColor *)spsaAlternativeButtonSelectedGreen;

+ (UIColor *)colorFromHexString:(NSString *)colorString withAlpha:(float)alpha;
@end

