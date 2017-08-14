//
//  AnswerEntity.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerEntity : NSObject

@property (nonatomic,strong) NSString *answerDescription;
@property (nonatomic) BOOL answerCorrect;

-(void)loadWithDictionary:(NSDictionary*)data;

@end
