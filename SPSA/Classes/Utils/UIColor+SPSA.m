//
//  UIColor+SPSA.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "UIColor+SPSA.h"

@implementation UIColor (SPSA)

+ (UIColor *)spsaBackgroundView{
    return [UIColor colorWithRed:252.0/255.0 green:251.0/255.0 blue:250.0/255.0 alpha:1.0];
}

+ (UIColor *)spsaTextColor{
    return [UIColor colorWithRed:63.0/255.0 green:64.0/255.0 blue:61.0/255.0 alpha:1.0];
}

+ (UIColor *)spsaNavigationBarBackgroundRedColor{
    return [UIColor colorWithRed:179.0/255.0 green:38.0/255.0 blue:47.0/255.0 alpha:1.0];
}

+ (UIColor *)spsaNavigationBarBackgroundGreenColor{
    return [UIColor colorWithRed:35.0/255.0 green:95.0/255.0 blue:53.0/255.0 alpha:1.0];
}

+ (UIColor *)spsaRed{
    return [UIColor colorWithRed:206.0/255.0 green:42.0/255.0 blue:49.0/255.0 alpha:1.0];
}

+ (UIColor *)spsaGreen {
    return [UIColor colorWithRed:38.0/255.0 green:116.0/255.0 blue:63.0/255.0 alpha:1.0];
}

+ (UIColor *)spsaAlternativeButtonLightGray{
    return [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:214.0/255.0 alpha:1.0];
}

+ (UIColor *)spsaAlternativeButtonSelectedYellow{
    return [UIColor colorWithRed:213.0/255.0 green:191.0/255.0 blue:63.0/255.0 alpha:1.0];
}

+ (UIColor *)spsaAlternativeButtonSelectedRed{
    return [UIColor colorWithRed:206.0/255.0 green:42.0/255.0 blue:49.0/255.0 alpha:1.0];
}

+ (UIColor *)spsaAlternativeButtonSelectedGreen{
    return [UIColor colorWithRed:38.0/255.0 green:116.0/255.0 blue:63.0/255.0 alpha:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)colorString withAlpha:(float)alpha {
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if (colorString.length == 3)
        colorString = [NSString stringWithFormat:@"%c%c%c%c%c%c",
                       [colorString characterAtIndex:0], [colorString characterAtIndex:0],
                       [colorString characterAtIndex:1], [colorString characterAtIndex:1],
                       [colorString characterAtIndex:2], [colorString characterAtIndex:2]];
    
    if (colorString.length == 6)
    {
        int r, g, b;
        sscanf([colorString UTF8String], "%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
    }
    return nil;
    
}

@end
