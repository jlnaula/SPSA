//
//  GenericPopupView.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/10/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "GenericPopupView.h"
#import "NPopup.h"
#import "UIColor+SPSA.h"

@implementation GenericPopupView

@synthesize navigation = navigation_;
@synthesize view = view_;
@synthesize lblTitle = lblTitle_;
@synthesize btnYes = btnYes_;
@synthesize btnNo = btnNo_;
@synthesize delegate = delegate_;



- (id)initWithDictionary:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"GenericPopupView" owner:self options:nil];
        [self addSubview: self.view];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat viewWidth = screenWidth-30;
        CGFloat viewHeight = viewWidth*CGRectGetHeight(self.view.bounds)/CGRectGetWidth(self.view.bounds);
        
        UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
        if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
            CGFloat tmp = screenWidth;
            screenWidth = screenHeight;
            screenHeight = tmp;
            viewHeight = viewWidth;
            viewWidth = viewHeight*CGRectGetWidth(self.view.bounds)/CGRectGetHeight(self.view.bounds);
        }
        self.frame = CGRectMake(screenWidth/2 - viewWidth/2,
                                screenHeight/2 - viewHeight/2,
                                viewWidth, viewHeight);
        
        CGRect frameAux = self.view.frame;
        frameAux.size.height = self.frame.size.height;
        frameAux.size.width = self.frame.size.width;
        self.view.frame = frameAux;
        
        layoutViews_ = NO;
        
        data_ = data;
        

        [lblTitle_ setText:[data_ objectForKey:@"title"]];
        [lblTitle_ setTextColor:[UIColor spsaTextColor]];

        [btnYes_ setBackgroundColor:[UIColor spsaRed]];
        [btnYes_ setTitle:@"Si" forState:UIControlStateNormal];
        [btnYes_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnYes_.layer setMasksToBounds:YES];
        [btnYes_.layer setCornerRadius:CGRectGetHeight(btnYes_.frame)/2];
        [btnYes_ addTarget:self action:@selector(yesButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

        [btnNo_ setBackgroundColor:[UIColor spsaRed]];
        [btnNo_ setTitle:@"No" forState:UIControlStateNormal];
        [btnNo_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnNo_.layer setMasksToBounds:YES];
        [btnNo_.layer setCornerRadius:CGRectGetHeight(btnYes_.frame)/2];
        [btnNo_ addTarget:self action:@selector(noButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

//pop methods

- (void)yesButtonPressed:(id)sender{
    [self closePopup];
}

- (void)noButtonPressed:(id)sender{
    [self closePopup];
}

-(void)closePopup {
    if(popup_){
        [popup_ close];
    }
}

-(void)showInWindow:(UIWindow*)parentWindow{
    
    
    if(!popup_){
        popup_ = [[NPopup alloc] initWithParentWindow:parentWindow];
        popup_.backgroundColor = [UIColor clearColor];
        popup_.dialogView.backgroundColor = [UIColor clearColor];
        popup_.alphaValue = 0.8;
        popup_.layer.cornerRadius = 4;
        popup_.layer.masksToBounds = YES;
        [popup_ setContainerView:self];
        [popup_ setCloseGesture];
    }
    [popup_ show];
}

@end
