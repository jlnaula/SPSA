//
//  QuestionTableViewCell.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/11/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "QuestionTableViewCell.h"

@implementation QuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_btnQuestion setEnabled:NO];
    [_btnQuestion addTarget:self action:@selector(questionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setQuestionEntity:(QuestionEntity *)questionEntity {
    _questionEntity = questionEntity;
    
    if (_isActiveQuestion) {
        [_lblQuestion setText:questionEntity.questionDescription];
        [_imgQuestionBox setImage:[UIImage imageNamed:@"img_question_box_empty"]];
        [_btnQuestion setEnabled:YES];
    } else {
        [_lblQuestion setText:@""];
        [_imgQuestionBox setImage:[UIImage imageNamed:@"img_question_box"]];
        [_btnQuestion setEnabled:NO];
    }
    
    if (_isDeactiveQuestion) {
        [_btnQuestion setEnabled:NO];
    }
    
    if (_isAnsweredQuestion) {
        [_lblQuestion setText:questionEntity.questionDescription];
        [_btnQuestion setEnabled:NO];
    }
    
}

- (void)questionButtonPressed:(id)sender {
    
    [_delegate showAlternativeListVC:_questionEntity];
    
}

@end
