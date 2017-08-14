//
//  QuestionListViewController.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/11/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "QuestionListViewController.h"
#import "AlternativeListViewController.h"
#import "QuestionTableViewCell.h"
#import "UIColor+SPSA.h"
#import "QuestionEntity.h"
#import "QueryWebService.h"
#import "ApiConstants.h"
#import "SVProgressHUD.h"

@interface QuestionListViewController ()

@end

@implementation QuestionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor spsaBackgroundView]];
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
    
    [self callGetQuestion];
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
    
    return _questionsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionTableViewCellID"];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"QuestionTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [cell setDelegate:self];
    
    QuestionEntity *questionEntity = _questionsArr[indexPath.row];
    
    [cell setQuestionEntity:questionEntity];

    
    if ([_question_id isEqualToString:questionEntity.idf]) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS'Z'"];
        NSDate *date = [dateFormat dateFromString:[_questionActiveTime objectForKey:@"date"]];
        
        NSDate *currentDate = [NSDate new];
        
        if ([date compare:currentDate] == NSOrderedDescending) {
            NSLog(@"date is later than currentDate");
        } else if ([date compare:currentDate] == NSOrderedAscending) {
            NSLog(@"date is earlier than currentDate");
            [cell.imgCheck setImage:[UIImage imageNamed:@"img_x"]];
            [cell.btnQuestion setEnabled:NO];
        } else {
            NSLog(@"dates are the same");
        }
        
    } else {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@",questionEntity.idf];
        NSArray *filteredArray = [_deactivatedQuestionsArr filteredArrayUsingPredicate:predicate];
        
        if (filteredArray.count > 0) {
            [cell.imgCheck setImage:[UIImage imageNamed:@"img_x"]];
            [cell.btnQuestion setEnabled:NO];
        }
        
    }
    
    NSMutableArray *answeredArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"arrAnswered"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"question_id == %@",questionEntity.idf];
    NSArray *filteredArray = [answeredArr filteredArrayUsingPredicate:predicate];
    
    if (filteredArray.count > 0) {
        if ([[filteredArray[0] objectForKey:@"answer_correct"] boolValue]) {
            [cell.imgCheck setImage:[UIImage imageNamed:@"img_check"]];
        } else {
            [cell.imgCheck setImage:[UIImage imageNamed:@"img_x"]];
        }
        [cell.btnQuestion setEnabled:NO];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96;
}

#pragma mark - QuestionTableViewCellDelegate

- (void)showAlternativeListVC:(QuestionEntity *)questionEntity {

    AlternativeListViewController *alternativeListViewController = (AlternativeListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AlternativeListViewControllerID"];
    [alternativeListViewController setUserEntity:_userEntity];
    [alternativeListViewController setQuestionEntity:questionEntity];
    [alternativeListViewController setQuestionActiveTime:_questionActiveTime];
    [[self navigationController] pushViewController:alternativeListViewController animated:YES];
    
}

#pragma mark - endPoint methods

-(void)callGetQuestion{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endGetQuestion:) name:@"endGetQuestion" object:nil];
    
    NSDictionary *params = nil;
    
    [[QueryWebService sharedInstance] getDataFromPath:[NSString stringWithFormat:NSLocalizedString(URL_GET_QUESTION,nil)] withMethod:GET withParamData:params withNotification:@"endGetQuestion"];
    
}

-(void)endGetQuestion:(NSNotification*)notification{
    
    [SVProgressHUD dismiss];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notification.name object:nil];
    
    NSDictionary *response = (NSDictionary*)notification.object;
    
    if ([response objectForKey:@"status"] && [[response objectForKey:@"status"] isEqualToString:@"success"]) {
        
        NSMutableArray *deactivatedQuestionsArr = [[NSMutableArray alloc] init];
        for (NSDictionary *deactivatedQuestion in [response objectForKey:@"deactivated_questions"]) {
            [deactivatedQuestionsArr addObject:[NSString stringWithFormat:@"%@",[deactivatedQuestion objectForKey:@"question_id"]]];
        }
        
        
        _deactivatedQuestionsArr = deactivatedQuestionsArr;
        _questionActiveTime = [response objectForKey:@"question_active_time"];
        _question_id = [NSString stringWithFormat:@"%@",[response objectForKey:@"question_id"]];
        
        [_tblQuestions reloadData];
        
    }
    
}

@end
