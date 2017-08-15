//
//  HomeViewController.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/8/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "HomeViewController.h"
#import "DancingContestViewController.h"
#import "HowYouKnowViewController.h"
#import "UIColor+SPSA.h"
#import "QueryWebService.h"
#import "ApiConstants.h"
#import "SVProgressHUD.h"

@interface HomeViewController () {
    
    UIRefreshControl *refreshControl;
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view setBackgroundColor:[UIColor spsaBackgroundView]];
    
    [self.btnDancingContest addTarget:self action:@selector(dancingContestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnHowYouKnow addTarget:self action:@selector(howYouKnowButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(didPullToRefresh) forControlEvents:UIControlEventValueChanged];
    
    [self.scrollView setContentSize:self.view.frame.size];
    [self.scrollView addSubview:refreshControl];
    
    [self callVoteStatus];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UIView*)getTopView{
    
    UIView*content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 64)];
    return content;
    
}

#pragma mark - action methods

- (void)didPullToRefresh {
    NSLog(@"didPullToRefresh");
    [self callVoteStatus];
}

#pragma mark - action methods

- (void)dancingContestButtonPressed:(id)sender {
    DancingContestViewController *dancingContestViewController = (DancingContestViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DancingContestViewControllerID"];
    [dancingContestViewController setUserEntity:_userEntity];
    [dancingContestViewController setTeamsArr:_teamsArr];
    [[self navigationController] pushViewController:dancingContestViewController animated:YES];
}

- (void)howYouKnowButtonPressed:(id)sender {
    HowYouKnowViewController *howYouKnowViewController = (HowYouKnowViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"HowYouKnowViewControllerID"];
    [howYouKnowViewController setUserEntity:_userEntity];
    [howYouKnowViewController setQuestionsArr:_questionsArr];
    [[self navigationController] pushViewController:howYouKnowViewController animated:YES];
}

#pragma mark - endPoint methods

-(void)callVoteStatus{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endVoteStatus:) name:@"endVoteStatus" object:nil];
    
    NSDictionary *params = nil;
    
    [[QueryWebService sharedInstance] getDataFromPath:[NSString stringWithFormat:NSLocalizedString(URL_VOTE, nil)] withMethod:GET withParamData:params withNotification:@"endVoteStatus"];
    
}

-(void)endVoteStatus:(NSNotification*)notification{
    
    [SVProgressHUD dismiss];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notification.name object:nil];
    
    NSDictionary *response = (NSDictionary*)notification.object;
    
    if ([response objectForKey:@"status"] && [[response objectForKey:@"status"] isEqualToString:@"success"]) {
        
        BOOL hasVoted = [[[NSUserDefaults standardUserDefaults] objectForKey:@"has_voted"] boolValue];
        BOOL isVotingEnabled = [[response objectForKey:@"vote_status"] boolValue];
        BOOL enableVoting = isVotingEnabled && !hasVoted;
        
        [self.btnDancingContest setEnabled:enableVoting];
        
    }
    
    [refreshControl endRefreshing];
    
}

@end
