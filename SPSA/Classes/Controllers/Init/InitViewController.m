//
//  InitViewController.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/8/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "InitViewController.h"
#import "HomeViewController.h"

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h> 
#import "UIColor+SPSA.h"

@interface InitViewController () {
    BOOL showStatusBar;
}

@end

@implementation InitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.btnDownload setBackgroundColor:[UIColor spsaRed]];
    [self.btnDownload.layer setMasksToBounds:YES];
    [self.btnDownload.layer setCornerRadius:CGRectGetHeight(self.btnDownload.frame)/2];
    [self.btnDownload addTarget:self action:@selector(downloadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString * fullname = [NSString stringWithFormat:@"%@ %@",_userEntity.firstname,_userEntity.lastname];
    NSString * welcomeMessage = [NSString stringWithFormat:@"Bienvenido %@, ésta es una invitación virtual",fullname];
    
    [self.lblWelcome setAttributedText:[self attributedText:welcomeMessage withBoldText:fullname]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    showStatusBar = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(BOOL)prefersStatusBarHidden
{
    if (showStatusBar) {
        return NO;
    }
    return YES;
    
}

#pragma mark - action methods

- (void)downloadButtonPressed:(id)sender {
    
    
    [_btnDownload setHidden:YES];
    showStatusBar = NO;
    [self prefersStatusBarHidden];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate saveImageFlyer];
    
    [_btnDownload setHidden:NO];
    showStatusBar = YES;
    [self prefersStatusBarHidden];
    
    

    HomeViewController *homeViewController = (HomeViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewControllerID"];
    [homeViewController setUserEntity:_userEntity];
    [homeViewController setTeamsArr:_teamsArr];
    [homeViewController setQuestionsArr:_questionsArr];
    [[self navigationController] pushViewController:homeViewController animated:YES];
    
}

#pragma mark - layout methods

- (NSMutableAttributedString*)attributedText:(NSString*)string withBoldText:(NSString*)boldText {

    NSRange boldedRange = [string rangeOfString:boldText];
    
    NSDictionary *dictBoldText = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont boldSystemFontOfSize:16],
                                  NSFontAttributeName, nil];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString setAttributes:dictBoldText range:boldedRange];
    
    return attrString;
}

@end
