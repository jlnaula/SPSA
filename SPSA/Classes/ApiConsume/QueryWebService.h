//
//  QueryWebService.h
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryWebService : NSObject

+(QueryWebService *)sharedInstance;

-(void)getDataFromPath:(NSString *)path withMethod:(NSString*)method withParamData:(NSDictionary *)dictParam withNotification:(NSString*)nameNotification;

-(void)getDataFromPath2:(NSString *)path withMethod:(NSString*)method withParamData:(NSDictionary *)dictParam withNotification:(NSString*)nameNotification;

@end
