//
//  RateDanceViewController.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "RateDanceViewController.h"
#import "FinishContestViewController.h"
#import "TalentAlternativeTableViewCell.h"
#import "GenericPopupView.h"
#import "UIColor+SPSA.h"
#import "TeamEntity.h"
#import "QueryWebService.h"
#import "ApiConstants.h"
#import "SVProgressHUD.h"

@interface RateDanceViewController () {
    UIButton *btnAlternativeSelected;
}

@end

@implementation RateDanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor spsaBackgroundView]];
    
    
    NSString * subString = @"lo hizo mejor";
    NSString * questionString = [NSString stringWithFormat:@"¿Cual equipo %@?",subString];
    
    [self.lblQuestion setAttributedText:[self attributedText:questionString withBoldText:subString]];
    [self.lblQuestion setTextColor:[UIColor spsaTextColor]];
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

#pragma mark - layout methods

- (NSMutableAttributedString*)attributedText:(NSString*)string withBoldText:(NSString*)boldText {
    
    NSRange boldedRange = [string rangeOfString:boldText];
    
    NSDictionary *dictBoldText = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont boldSystemFontOfSize:23],
                                  NSFontAttributeName, nil];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString setAttributes:dictBoldText range:boldedRange];
    
    return attrString;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _teamsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TalentAlternativeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TalentAlternativeTableViewCellID"];

    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TalentAlternativeTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    TeamEntity *teamEntity = _teamsArr[indexPath.row];
    
    [cell setTeamEntity:teamEntity];
    
    [cell.btnAlternative setTag:indexPath.row];
    [cell.btnAlternative addTarget:self action:@selector(alternativeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

#pragma mark - GenericPopupView Delegate

- (void)confirmAnswer {
    TeamEntity *teamEntity = _teamsArr[btnAlternativeSelected.tag];
    
    [self callVote:teamEntity];
}

- (void)resetAnswer {
    [btnAlternativeSelected setBackgroundColor:[UIColor spsaAlternativeButtonLightGray]];
    [btnAlternativeSelected setTitleColor:[UIColor spsaTextColor] forState:UIControlStateNormal];
}

#pragma mark - GenericPopupView

- (void)showGenericPopupView:(NSDictionary*)data {
    
    GenericPopupView * genericPopupView = [[GenericPopupView alloc] initWithDictionary:data];
    genericPopupView.navigation = [self navigationController];
    genericPopupView.delegate = self;
    [genericPopupView showInWindow:self.view.window];
    
}

#pragma mark - action methods

- (void)alternativeButtonPressed:(UIButton*)sender {
    
    [btnAlternativeSelected setBackgroundColor:[UIColor spsaAlternativeButtonLightGray]];
    [btnAlternativeSelected setTitleColor:[UIColor spsaTextColor] forState:UIControlStateNormal];
    
    btnAlternativeSelected = sender;
    
    switch (sender.tag) {
        case 0:
            [btnAlternativeSelected setBackgroundColor:[UIColor spsaAlternativeButtonSelectedRed]];
            break;
        case 1:
            [btnAlternativeSelected setBackgroundColor:[UIColor spsaAlternativeButtonSelectedGreen]];
            break;
        case 2:
            [btnAlternativeSelected setBackgroundColor:[UIColor spsaAlternativeButtonSelectedYellow]];
            break;
        default:
            break;
    }
    
    [btnAlternativeSelected setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self showGenericPopupView:@{@"title" : @"¿Está seguro de su respuesta?"}];
}

#pragma mark - show VCs

- (void)showFinishContestVC {
    
    FinishContestViewController *finishContestViewController = (FinishContestViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"FinishContestViewControllerID"];
    
    [[self navigationController] pushViewController:finishContestViewController animated:YES];
    
}

#pragma mark - endPoint methods

-(void)callVote:(TeamEntity *)teamEntity{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endVote:) name:@"endVote" object:nil];
    
    NSDictionary *body = @{
                             @"user_id": _userEntity.user_id,
                             @"team_id": teamEntity.idf
                             };
    
    NSDictionary *params = @{
                             API_PARAMS : body
                             };
    
    [[QueryWebService sharedInstance] getDataFromPath:[NSString stringWithFormat:NSLocalizedString(URL_VOTE,nil)] withMethod:POST withParamData:params withNotification:@"endVote"];
    
}

-(void)endVote:(NSNotification*)notification{
    
    [SVProgressHUD dismiss];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notification.name object:nil];
    
    NSDictionary *response = (NSDictionary*)notification.object;
    
    if ([response objectForKey:@"status"] && [[response objectForKey:@"status"] isEqualToString:@"success"]) {
        
        [self showFinishContestVC];
        
    }
    
}

@end
