//
//  TeamEntity.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamEntity : NSObject

@property (nonatomic,strong) NSString *idf;
@property (nonatomic,strong) NSString *teamName;
@property (nonatomic,strong) NSString *teamDance;

-(void)loadWithDictionary:(NSDictionary*)data;

@end
