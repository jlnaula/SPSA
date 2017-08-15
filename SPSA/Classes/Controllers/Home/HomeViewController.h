//
//  HomeViewController.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/8/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UIButton *btnDancingContest;
@property (nonatomic,weak) IBOutlet UIButton *btnHowYouKnow;

@property (nonatomic,strong) UserEntity *userEntity;
@property (nonatomic,strong) NSArray *teamsArr;
@property (nonatomic,strong) NSArray *questionsArr;

@end
