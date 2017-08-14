//
//  UserEntity.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject

@property (nonatomic,strong) NSString *dni;
@property (nonatomic,strong) NSString *firstname;
@property (nonatomic,strong) NSString *lastname;
@property (nonatomic,strong) NSString *user_id;

-(void)loadWithDictionary:(NSDictionary*)data;

@end
