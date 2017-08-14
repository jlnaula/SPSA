//
//  AlternativeListViewController.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/11/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericPopupView.h"
#import "QuestionEntity.h"
#import "UserEntity.h"

@interface AlternativeListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,GenericPopupViewDelegate>

@property (nonatomic,weak) IBOutlet UILabel *lblQuestion;
@property (nonatomic,weak) IBOutlet UILabel *lblTime;
@property (nonatomic,weak) IBOutlet UITableView *tblAnswers;

@property (nonatomic,strong) UserEntity *userEntity;
@property (nonatomic,strong) QuestionEntity *questionEntity;
@property (nonatomic,strong) NSDictionary *questionActiveTime;

@end
