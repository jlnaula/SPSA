//
//

#import <UIKit/UIKit.h>

@interface NPopup : UIView <UIGestureRecognizerDelegate>{
    UIWindow *parentWindow_;
    UIView *dialogView_;
    UIView *containerView_;
    UIView *gestureView_;
    CGFloat alphaValue;
    
    id delegate_;
}

@property (nonatomic, retain) UIView *parentWindow;    // The parent view this 'dialog' is attached to
@property (nonatomic, retain) UIView *dialogView;    // Dialog's container view
@property (nonatomic, retain) IBOutlet UIView *containerView; // Container within the dialog (place your ui elements here)
@property (nonatomic, retain) UIView *gestureView; // View for gesture recognizer

@property (nonatomic, assign) CGFloat alphaValue;

@property (nonatomic, retain) id delegate;

- (id)initWithParentWindow: (UIWindow *)parentWindow;

- (void)show;
- (void)close;

- (IBAction)popupClose:(id)sender;
-(void)setCloseGesture;

@end
