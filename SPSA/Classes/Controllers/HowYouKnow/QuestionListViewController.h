//
//  QuestionListViewController.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/11/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "QuestionTableViewCell.h"

@interface QuestionListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,QuestionTableViewCellDelegate>

@property (nonatomic,weak) IBOutlet UITableView *tblQuestions;

@property (nonatomic,strong) UserEntity *userEntity;
@property (nonatomic,strong) NSArray *questionsArr;
@property (nonatomic,strong) NSArray *deactivatedQuestionsArr;
@property (nonatomic,strong) NSDictionary *questionActiveTime;
@property (nonatomic,strong) NSString *question_id;

@end
