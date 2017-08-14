//
//  RateDanceViewController.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "GenericPopupView.h"

@interface RateDanceViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,GenericPopupViewDelegate>

@property (nonatomic,weak) IBOutlet UILabel *lblQuestion;
@property (nonatomic,weak) IBOutlet UITableView *tblAnswers;

@property (nonatomic,strong) UserEntity *userEntity;
@property (nonatomic,strong) NSArray *teamsArr;

@end
