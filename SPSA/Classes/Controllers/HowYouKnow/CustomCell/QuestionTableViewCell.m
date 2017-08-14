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
    
    [self.btnQuestion addTarget:self action:@selector(questionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setQuestionEntity:(QuestionEntity *)questionEntity {
    _questionEntity = questionEntity;
    
    [_lblQuestion setText:questionEntity.questionDescription];
}

- (void)questionButtonPressed:(id)sender {
    
    [_delegate showAlternativeListVC:_questionEntity];
    
}

@end
