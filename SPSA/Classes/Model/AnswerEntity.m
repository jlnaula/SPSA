//
//  AnswerEntity.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "AnswerEntity.h"

@implementation AnswerEntity

-(void)loadWithDictionary:(NSDictionary*)data{
    
    _answerDescription =  [NSString stringWithFormat:@"%@",[data objectForKey:@"answer_description"]];
    _answerCorrect = [[data objectForKey:@"answer_correct"] boolValue];

}

@end
