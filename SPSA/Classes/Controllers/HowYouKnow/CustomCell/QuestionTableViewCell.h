//
//  QuestionTableViewCell.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/11/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionEntity.h"

@protocol QuestionTableViewCellDelegate

- (void)showAlternativeListVC:(QuestionEntity *)questionEntity;

@end

@interface QuestionTableViewCell : UITableViewCell

@property (nonatomic, readwrite, retain) id<QuestionTableViewCellDelegate> delegate;

@property (nonatomic,weak) IBOutlet UIImageView *imgQuestionBox;
@property (nonatomic,weak) IBOutlet UIImageView *imgCheck;
@property (nonatomic,weak) IBOutlet UILabel *lblQuestion;
@property (nonatomic,weak) IBOutlet UIButton *btnQuestion;

@property (nonatomic) BOOL isActiveQuestion;
@property (nonatomic) BOOL isDeactiveQuestion;
@property (nonatomic) BOOL isAnsweredQuestion;

@property (nonatomic,strong) QuestionEntity *questionEntity;

@end
