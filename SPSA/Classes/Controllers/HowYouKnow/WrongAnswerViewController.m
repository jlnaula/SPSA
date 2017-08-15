//
//  WrongAnswerViewController.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/11/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "WrongAnswerViewController.h"
#import "UIColor+SPSA.h"

@interface WrongAnswerViewController ()

@end

@implementation WrongAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor spsaRed]];
    
    [self.lblTitle setText:@":( Incorrecto"];
    
    [self.btnFinish setBackgroundColor:[UIColor whiteColor]];
    [self.btnFinish.layer setMasksToBounds:YES];
    [self.btnFinish.layer setCornerRadius:CGRectGetHeight(self.btnFinish.frame)/2];
    [self.btnFinish setTintColor:[UIColor spsaRed]];
    [self.btnFinish setTitleColor:[UIColor spsaRed] forState:UIControlStateNormal];
    [self.btnFinish addTarget:self action:@selector(finishButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor spsaNavigationBarBackgroundRedColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIImageView *titleImageView = [[UIImageView alloc] init];
    [titleImageView setFrame:CGRectMake(0, 0, 150, 18)];
    [titleImageView setContentMode:UIViewContentModeScaleAspectFit];
    [titleImageView setImage:[UIImage imageNamed:@"img_navigation_title"]];
    [titleImageView setClipsToBounds:YES];
    [self.navigationItem setTitleView:titleImageView];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_back_button"]]];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
    [self.navigationItem setHidesBackButton:YES];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]]];
    [self.navigationItem setRightBarButtonItem:menuButtonItem];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - action methods

- (void)finishButtonPressed:(id)sender {
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:3] animated:YES];
}

@end
