//
//  TalentAlternativeTableViewCell.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/10/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "TalentAlternativeTableViewCell.h"
#import "UIColor+SPSA.h"

@implementation TalentAlternativeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.btnAlternative setBackgroundColor:[UIColor spsaAlternativeButtonLightGray]];
    [self.btnAlternative.layer setMasksToBounds:YES];
    [self.btnAlternative.layer setCornerRadius:CGRectGetHeight(self.btnAlternative.frame)/2];
    [self.btnAlternative setTintColor:[UIColor spsaTextColor]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTeamEntity:(TeamEntity *)teamEntity {
    _teamEntity = teamEntity;
    
    [self.btnAlternative setTitle:teamEntity.teamName forState:UIControlStateNormal];
}

/*
- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = [UIColor spsaAlternativeButtonSelectedYellow];
    }
    else {
        self.backgroundColor = [UIColor spsaAlternativeButtonLightGray];
    }
}
*/

@end
