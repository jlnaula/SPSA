//
//  TalentAlternativeTableViewCell.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/10/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamEntity.h"

@interface TalentAlternativeTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIButton *btnAlternative;

@property (nonatomic,strong) TeamEntity *teamEntity;

@end
