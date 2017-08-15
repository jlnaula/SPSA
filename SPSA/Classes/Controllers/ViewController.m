//
//  ViewController.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "ViewController.h"
#import "QueryWebService.h"
#import "ApiConstants.h"
#import "SVProgressHUD.h"
#import "InitViewController.h"
#import "HomeViewController.h"
#import "UserEntity.h"
#import "TeamEntity.h"
#import "QuestionEntity.h"

@interface ViewController () {
    
    UserEntity *userEntity;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.btnPress addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - action methods

- (void)buttonPressed:(id)sender {
    
    [self callGetUser];
    
}

#pragma mark - endPoint methods

-(void)callGetUser{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endGetUser:) name:@"endGetUser" object:nil];
    
    NSDictionary *params = nil;
    
    [[QueryWebService sharedInstance] getDataFromPath2:[NSString stringWithFormat:@"%@",@"spsagames/user/getUser"] withMethod:GET withParamData:params withNotification:@"endGetUser"];
    
}

-(void)endGetUser:(NSNotification*)notification{
    
    [SVProgressHUD dismiss];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notification.name object:nil];
    
    NSDictionary *response = (NSDictionary*)notification.object;

    if ([response objectForKey:@"user"]) {
        userEntity = [[UserEntity alloc] init];
        [userEntity loadWithDictionary:[response objectForKey:@"user"]];
        
        [self callHome];
    }

}

-(void)callHome{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endHome:) name:@"endHome" object:nil];
    
    NSDictionary *params = nil;
    
    [[QueryWebService sharedInstance] getDataFromPath:[NSString stringWithFormat:NSLocalizedString(URL_HOME, nil),userEntity.dni,userEntity.firstname,userEntity.lastname] withMethod:GET withParamData:params withNotification:@"endHome"];
    
}

-(void)endHome:(NSNotification*)notification{
    
    [SVProgressHUD dismiss];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notification.name object:nil];
    
    NSDictionary *response = (NSDictionary*)notification.object;
    
    if ([response objectForKey:@"status"] && [[response objectForKey:@"status"] isEqualToString:@"success"]) {
        
        NSArray *teamsArr = [self teamsList:[response objectForKey:@"teams"]];
        NSArray *questionsArr = [self questionList:[response objectForKey:@"questions"]];
        userEntity.user_id = [NSString stringWithFormat:@"%@",[response objectForKey:@"user_id"]];
        
        NSDate *currentDate = [NSDate new];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        NSString *currentDateStr = [formatter stringFromDate:currentDate];
        
        if ([currentDateStr isEqualToString:@"08-14"]) {
            InitViewController *initViewController = (InitViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"InitViewControllerID"];
            [initViewController setUserEntity:userEntity];
            [initViewController setTeamsArr:teamsArr];
            [initViewController setQuestionsArr:questionsArr];
            [[self navigationController] pushViewController:initViewController animated:YES];
        } else {
            HomeViewController *homeViewController = (HomeViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewControllerID"];
            [homeViewController setUserEntity:userEntity];
            [homeViewController setTeamsArr:teamsArr];
            [homeViewController setQuestionsArr:questionsArr];
            [[self navigationController] pushViewController:homeViewController animated:YES];
        }
        
    }
    
}

#pragma mark - Class methods

- (NSMutableArray *)teamsList:(NSDictionary *)teamsDict{
    NSMutableArray *teamsArray = [NSMutableArray array];
    for (NSDictionary *teambean in teamsDict) {
        TeamEntity *teamEntity = [[TeamEntity alloc] init];
        [teamEntity loadWithDictionary:teambean];
        [teamsArray addObject:teamEntity];
    }
    return teamsArray;
}

- (NSMutableArray *)questionList:(NSDictionary *)questionsDict{
    NSMutableArray *questionsArray = [NSMutableArray array];
    for (NSDictionary *questionbean in questionsDict) {
        QuestionEntity *questionEntity = [[QuestionEntity alloc] init];
        [questionEntity loadWithDictionary:questionbean];
        [questionsArray addObject:questionEntity];
    }
    return questionsArray;
}

@end
