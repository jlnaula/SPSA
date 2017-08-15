//
//  GenericPopupView.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/10/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GenericPopupViewDelegate

- (void)confirmAnswer;
- (void)resetAnswer;

@end

@class NPopup;

@interface GenericPopupView : UIView{

@private
    NPopup * popup_;
    UIView *view_;

    UILabel *lblTitle_;
    
    UIButton *btnNo_;
    UIButton *btnYes_;

    NSDictionary * data_;
    
    BOOL layoutViews_;
    
    id<GenericPopupViewDelegate> delegate_;
    
    UINavigationController *navigation_;
    
}

@property (nonatomic, readwrite, retain) id<GenericPopupViewDelegate> delegate;

@property(nonatomic,strong) UINavigationController *navigation;

@property (nonatomic, retain) IBOutlet UIButton *btnYes;
@property (nonatomic, retain) IBOutlet UIButton *btnNo;
@property (nonatomic, retain) IBOutlet UILabel *lblTitle;

@property (nonatomic, retain) IBOutlet UIView *view;

-(void)showInWindow:(UIWindow*)parentWindow;
-(void)closePopup;

- (id)initWithDictionary:(NSDictionary*)data;

@end
