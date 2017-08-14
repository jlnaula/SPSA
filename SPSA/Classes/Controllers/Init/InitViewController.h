//
//  InitViewController.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/8/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"

@interface InitViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIButton *btnDownload;
@property (nonatomic,weak) IBOutlet UILabel *lblWelcome;

@property (nonatomic,strong) UserEntity *userEntity;
@property (nonatomic,strong) NSArray *teamsArr;
@property (nonatomic,strong) NSArray *questionsArr;

@end

