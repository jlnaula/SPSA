//
//  AlternativeListViewController.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/11/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "AlternativeListViewController.h"
#import "RightAnswerViewController.h"
#import "WrongAnswerViewController.h"
#import "HMYKAlternativeTableViewCell.h"
#import "UIColor+SPSA.h"
#import "AnswerEntity.h"
#import "QueryWebService.h"
#import "ApiConstants.h"
#import "SVProgressHUD.h"

@interface AlternativeListViewController () {
    GenericPopupView * genericPopupView;
    
    UIButton *btnAlternativeSelected;
    
    NSTimer *timer;
    int currMinute;
    int currSeconds;
}

@end

@implementation AlternativeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor spsaBackgroundView]];
    
    NSString * subString = @"Supermercados Peruanos";
    NSString * questionString = [NSString stringWithFormat:@"¿%@?",_questionEntity.questionDescription];
    
    [self.lblQuestion setAttributedText:[self attributedText:questionString withBoldText:subString]];
    [self.lblQuestion setTextColor:[UIColor spsaTextColor]];
    
    [self timingLabel];
    [self.lblTime setTextColor:[UIColor spsaRed]];
    
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _questionEntity.answersArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMYKAlternativeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMYKAlternativeTableViewCellID"];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HMYKAlternativeTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    AnswerEntity *answerEntity = _questionEntity.answersArr[indexPath.row];
    
    
    [cell setAnswerEntity:answerEntity];
    [cell.btnAlternative setTag:indexPath.row];
    [cell.btnAlternative addTarget:self action:@selector(alternativeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - GenericPopupView Delegate

- (void)confirmAnswer {
    
    [timer invalidate];
    AnswerEntity *answerEntity = _questionEntity.answersArr[btnAlternativeSelected.tag];
    [self sendAnswer:answerEntity withConfirmation:YES];
    
}

- (void)resetAnswer {
    [btnAlternativeSelected setBackgroundColor:[UIColor spsaAlternativeButtonLightGray]];
    [btnAlternativeSelected setTitleColor:[UIColor spsaTextColor] forState:UIControlStateNormal];
}

#pragma mark - GenericPopupView

- (void)showGenericPopupView:(NSDictionary*)data {
    
    genericPopupView = [[GenericPopupView alloc] initWithDictionary:data];
    genericPopupView.navigation = [self navigationController];
    genericPopupView.delegate = self;
    [genericPopupView showInWindow:self.view.window];
    
}

#pragma mark - Class methods

- (void)sendAnswer:(AnswerEntity *)answerEntity withConfirmation:(BOOL)confirmation{
    
    NSMutableArray *answeredArr = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"arrAnswered"]];
    
    if (answeredArr == nil) {
        answeredArr = [[NSMutableArray alloc] init];
    }
    
    [answeredArr addObject:@{@"question_id":_questionEntity.idf,
                             @"answer_correct":((answerEntity.answerCorrect && confirmation)?@"1":@"0")}];
    
    if (answerEntity.answerCorrect && confirmation) {
        [self callSendAnswer];
    } else {
        [self showWrongAnswerVC];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:answeredArr forKey:@"arrAnswered"];
    
}

#pragma mark - action methods

- (void)alternativeButtonPressed:(UIButton*)sender {
    
    [btnAlternativeSelected setBackgroundColor:[UIColor spsaAlternativeButtonLightGray]];
    [btnAlternativeSelected setTitleColor:[UIColor spsaTextColor] forState:UIControlStateNormal];
    
    btnAlternativeSelected = sender;
    
    [btnAlternativeSelected setBackgroundColor:[UIColor spsaAlternativeButtonSelectedRed]];
    [btnAlternativeSelected setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self showGenericPopupView:@{@"title" : @"¿Está seguro de su respuesta?"}];
}

#pragma mark - layout methods

- (NSMutableAttributedString*)attributedText:(NSString*)string withBoldText:(NSString*)boldText {
    
    NSRange boldedRange = [string rangeOfString:boldText];
    
    NSDictionary *dictBoldText = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont boldSystemFontOfSize:21],
                                  NSFontAttributeName, nil];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString setAttributes:dictBoldText range:boldedRange];
    
    return attrString;
}

- (void) timingLabel{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormat dateFromString:[_questionActiveTime objectForKey:@"date"]];
    
    NSDate *currentDate = [NSDate new];
    
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:currentDate];
    
    int interval = (int)timeInterval;
    
    currSeconds = interval % 60;
    currMinute = (interval / 60) % 60;

    [_lblTime setText:[NSString stringWithFormat:@"%@%02d%@%02d",@"",currMinute,@":",currSeconds]];
    
    
    [self start];
}

-(void)start
{
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
}
-(void)timerFired
{
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if(currMinute>-1)
            [_lblTime setText:[NSString stringWithFormat:@"%@%02d%@%02d",@"",currMinute,@":",currSeconds]];
    }
    else
    {
        [timer invalidate];

        if (genericPopupView) {
            [genericPopupView closePopup];
        }
        AnswerEntity *answerEntity = _questionEntity.answersArr[btnAlternativeSelected.tag];
        [self sendAnswer:answerEntity withConfirmation:NO];
    }
}

#pragma mark - show VCs

- (void)showRightAnswerVC {
    
    RightAnswerViewController *rightAnswerViewController = (RightAnswerViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RightAnswerViewControllerID"];
    
    [[self navigationController] pushViewController:rightAnswerViewController animated:YES];
    
}

- (void)showWrongAnswerVC {
    
    WrongAnswerViewController *wrongAnswerViewController = (WrongAnswerViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"WrongAnswerViewControllerID"];
    
    [[self navigationController] pushViewController:wrongAnswerViewController animated:YES];
    
}

#pragma mark - endPoint methods

-(void)callSendAnswer{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endSendAnswer:) name:@"endSendAnswer" object:nil];
    
    NSDictionary *body = @{
                           @"user_id": _userEntity.user_id,
                           @"question_id": _questionEntity.idf
                           };
    
    NSDictionary *params = @{
                             API_PARAMS : body
                             };
    
    [[QueryWebService sharedInstance] getDataFromPath:[NSString stringWithFormat:NSLocalizedString(URL_SEND_ANSWER,nil)] withMethod:POST withParamData:params withNotification:@"endSendAnswer"];
    
}

-(void)endSendAnswer:(NSNotification*)notification{
    
    [SVProgressHUD dismiss];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notification.name object:nil];
    
    NSDictionary *response = (NSDictionary*)notification.object;
    
    if ([response objectForKey:@"status"] && [[response objectForKey:@"status"] isEqualToString:@"success"]) {
        
        [self showRightAnswerVC];
        
    }
    
}

@end
