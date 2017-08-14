//
//  DancingContestViewController.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/8/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"

@interface DancingContestViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIButton *btnVote;

@property (nonatomic,strong) UserEntity *userEntity;
@property (nonatomic,strong) NSArray *teamsArr;

@end
