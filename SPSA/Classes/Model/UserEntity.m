//
//  UserEntity.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

-(void)loadWithDictionary:(NSDictionary*)data{
    
    _dni =  [NSString stringWithFormat:@"%@",[data objectForKey:@"dni"]];
    _firstname = [NSString stringWithFormat:@"%@",[data objectForKey:@"firstname"] ];
    _lastname =[NSString stringWithFormat:@"%@",[data objectForKey:@"lastname"]];

}

@end
