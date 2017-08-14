//
//  TeamEntity.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "TeamEntity.h"

@implementation TeamEntity

-(void)loadWithDictionary:(NSDictionary*)data{
    
    _idf =  [NSString stringWithFormat:@"%@",[data objectForKey:@"team_id"]];
    _teamName = [NSString stringWithFormat:@"%@",[data objectForKey:@"team_name"] ];
    _teamDance =[NSString stringWithFormat:@"%@",[data objectForKey:@"team_dance"]];

}

@end
