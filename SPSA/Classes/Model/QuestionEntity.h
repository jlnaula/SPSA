//
//  QuestionEntity.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionEntity : NSObject

@property (nonatomic,strong) NSString *idf;
@property (nonatomic,strong) NSString *questionDescription;
@property (nonatomic,strong) NSArray *answersArr;

-(void)loadWithDictionary:(NSDictionary*)data;

@end
