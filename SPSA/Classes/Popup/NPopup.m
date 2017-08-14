//
//

#import "NPopup.h"
#import <QuartzCore/QuartzCore.h>

@implementation NPopup

@synthesize parentWindow = parentWindow_;
@synthesize containerView = containerView_;
@synthesize dialogView = dialogView_;
@synthesize gestureView = gestureView_;
@synthesize alphaValue = alphaValue_;
@synthesize delegate = delegate_;
UITapGestureRecognizer *tapGestureRecognizer;


- (id)initWithParentWindow: (UIWindow *)parentWindow
{
    self = [super initWithFrame:parentWindow.frame];
    
    if (self) {
        
        parentWindow_ = parentWindow;
        delegate_ = self;
        alphaValue_ = 0.4;
    }
    return self;
}

// Create the dialog view, and animate opening the dialog
- (void)show
{
    dialogView_ = [self createContainerView];
    
    dialogView_.layer.opacity = 0.5f;
    dialogView_.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alphaValue_];
    
    [self addSubview:dialogView_];
    [parentWindow_ addSubview:self];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         dialogView_.layer.opacity = 1.0f;
                         dialogView_.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:^(BOOL finished) {
                         
                     }
     ];
}

// Button has touched
- (IBAction)popupClose:(id)sender
{
    [delegate_ popupClose:self clickedButtonAtIndex:[sender tag]];
}

//default
- (void)popupClose: (NPopup *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self close];
}

// Dialog close animation then cleaning and removing the view from the parent
- (void)close
{
    dialogView_.layer.transform = CATransform3DMakeScale(1, 1, 1);
    dialogView_.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         dialogView_.layer.transform = CATransform3DMakeScale(0.6f, 0.6f, 1.0);
                         dialogView_.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
    
}

- (void)setSubView: (UIView *)subView
{
    containerView_ = subView;
}

- (UIView *)createContainerView
{
    
    if (containerView_ == NULL) {
        containerView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 150)];
    }
    
    CGFloat dialogWidth = containerView_.frame.size.width;
    CGFloat dialogHeight = containerView_.frame.size.height;
    
    CGRect frameContainer = containerView_.frame;
    frameContainer.origin.x = -2;
    frameContainer.origin.y = -2;
    containerView_.frame = frameContainer;
    
    dialogWidth = dialogWidth - 4;
    dialogHeight = dialogHeight - 4;
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        CGFloat tmp = screenWidth;
        screenWidth = screenHeight;
        screenHeight = tmp;
    }
    
    [self setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenWidth - dialogWidth) / 2, (screenHeight - dialogHeight) / 2, dialogWidth, dialogHeight)];

    [dialogContainer addSubview:containerView_];
    
    dialogContainer.backgroundColor = [UIColor darkGrayColor];
    
    [self listSubviewsOfView:self.containerView];
    
    return dialogContainer;
}

//para poder visualizar el teclado

- (void)listSubviewsOfView:(UIView *)view {
    NSArray *subviews = [view subviews];
    if ([subviews count] == 0) return;
    
    for (UIView *subview in subviews) {
        if([subview class] == [UITextField class]){
            UITextField * textField = (UITextField*) subview;
            [textField addTarget:self action:@selector(didBegin:) forControlEvents:UIControlEventEditingDidBegin];
            [textField addTarget:self action:@selector(didEnd:) forControlEvents:UIControlEventEditingDidEnd];
        }
        
        // List the subviews of subview
        [self listSubviewsOfView:subview];
    }
}

-(void)didBegin:(UITextField*) textField{
    [self slideFrame:NO];
}
-(void)didEnd:(UITextField*) textField{
    [self slideFrame:YES];
}

-(void) slideFrame:(BOOL) up
{
    const int movementDistance = 95; // adjust
    const float movementDuration = 0.3f; // adjust
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.frame = CGRectOffset(self.frame, 0, -movement);
    [UIView commitAnimations];
}

-(void)setCloseGesture{
    gestureView_ = [[UIView alloc] initWithFrame:self.frame];
    [gestureView_ setBackgroundColor:[UIColor clearColor]];
    [self addSubview:gestureView_];
    [gestureView_ sendSubviewToBack:containerView_];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [tapGestureRecognizer setDelegate:self];
    [gestureView_ addGestureRecognizer:tapGestureRecognizer];
}

-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (tapGestureRecognizer != nil) {
        [gestureView_ removeGestureRecognizer:tapGestureRecognizer];
    }
    [self close];
}

@end
