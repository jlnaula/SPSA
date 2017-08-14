//
//  HMYKAlternativeTableViewCell.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/10/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerEntity.h"

@interface HMYKAlternativeTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIButton *btnAlternative;

@property (nonatomic,strong) AnswerEntity *answerEntity;

@end
