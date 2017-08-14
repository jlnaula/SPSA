//
//  QuestionEntity.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "QuestionEntity.h"
#import "AnswerEntity.h"

@implementation QuestionEntity

-(void)loadWithDictionary:(NSDictionary*)data{
    
    _idf =  [NSString stringWithFormat:@"%@",[data objectForKey:@"question_id"]];
    _questionDescription = [NSString stringWithFormat:@"%@",[data objectForKey:@"question_description"] ];
    _answersArr = [self answerList:[data objectForKey:@"answers"]];

}

- (NSMutableArray *)answerList:(NSDictionary *)answersDict{
    NSMutableArray *answersArray = [NSMutableArray array];
    for (NSDictionary *answerbean in answersDict) {
        AnswerEntity *answerEntity = [[AnswerEntity alloc] init];
        [answerEntity loadWithDictionary:answerbean];
        [answersArray addObject:answerEntity];
    }
    return answersArray;
}

@end
