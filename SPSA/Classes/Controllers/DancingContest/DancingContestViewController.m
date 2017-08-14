//
//  DancingContestViewController.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/8/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "DancingContestViewController.h"
#import "RateDanceViewController.h"
#import "UIColor+SPSA.h"

@interface DancingContestViewController ()

@end

@implementation DancingContestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor spsaBackgroundView]];
    
    [self.btnVote setBackgroundColor:[UIColor spsaRed]];
    [self.btnVote.layer setMasksToBounds:YES];
    [self.btnVote.layer setCornerRadius:CGRectGetHeight(self.btnVote.frame)/2];
    [self.btnVote addTarget:self action:@selector(voteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)voteButtonPressed:(id)sender {
    
    RateDanceViewController *rateDanceViewController = (RateDanceViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RateDanceViewControllerID"];
    [rateDanceViewController setUserEntity:_userEntity];
    [rateDanceViewController setTeamsArr:_teamsArr];
    [[self navigationController] pushViewController:rateDanceViewController animated:YES];
}


@end
