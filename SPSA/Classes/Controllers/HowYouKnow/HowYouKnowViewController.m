//
//  HowYouKnowViewController.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/8/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "HowYouKnowViewController.h"
#import "QuestionListViewController.h"
#import "UIColor+SPSA.h"
#import "QueryWebService.h"
#import "ApiConstants.h"
#import "SVProgressHUD.h"

@interface HowYouKnowViewController ()

@end

@implementation HowYouKnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor spsaBackgroundView]];
    
    [self.btnStart setBackgroundColor:[UIColor spsaRed]];
    [self.btnStart.layer setMasksToBounds:YES];
    [self.btnStart.layer setCornerRadius:CGRectGetHeight(self.btnStart.frame)/2];
    [self.btnStart addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
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
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_menu_white"]]];
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

- (void)startButtonPressed:(id)sender {
    
    [self showQuestionListVC];
    
}

#pragma mark - show VCs

- (void)showQuestionListVC {
    
    QuestionListViewController *questionListViewController = (QuestionListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"QuestionListViewControllerID"];
    [questionListViewController setUserEntity:_userEntity];
    [questionListViewController setQuestionsArr:_questionsArr];
    [[self navigationController] pushViewController:questionListViewController animated:YES];

}


@end
