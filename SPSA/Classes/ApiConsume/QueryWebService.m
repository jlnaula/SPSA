//
//  QueryWebService.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "QueryWebService.h"
#import "ApiConstants.h"

@implementation QueryWebService {
    NSURLSessionConfiguration *defaultConfigObject;
    NSURLSession *defaultSession;
}

+(QueryWebService *)sharedInstance{
    static dispatch_once_t pred;
    static QueryWebService *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[QueryWebService alloc] init];
    });
    return shared;
}

-(id)init{
    defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfigObject.timeoutIntervalForRequest = 30.0;
    defaultConfigObject.timeoutIntervalForResource = 60.0;
    defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    return self;
}
#pragma mark - Private Methods
-(NSMutableString*)dictionaryToStringValue:(NSDictionary*)dictionary{
    
    NSArray*key = [dictionary allKeys];
    NSArray*values = [dictionary allValues];
    NSMutableString * bodyString = [[NSMutableString alloc] init];
    
    for (int i=0; i<key.count; i++) {
        if (i<[key count]-1) {
            [bodyString appendString:[NSString stringWithFormat:@"%@=%@&",[key objectAtIndex:i],[values objectAtIndex:i]]];
        }else{
            [bodyString appendString:[NSString stringWithFormat:@"%@=%@",[key objectAtIndex:i],[values objectAtIndex:i]]];
        }
    }
    
    return bodyString;
}
#pragma mark - Public Methods

-(void)getDataFromPath:(NSString *)path withMethod:(NSString*)method withParamData:(NSDictionary *)dictParam withNotification:(NSString*)nameNotification{
    
    
        for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
            
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            
        }
        
        NSString*methodName=path;
        NSString *stringUrl = [NSString stringWithFormat:@"%@%@",API_URL_BASE,methodName];
        if (path==nil) {
            stringUrl = [[dictParam objectForKey:API_PARAMS] objectForKey:@"urlPath"];
        }
        NSString *properlyEscapedURL = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url = [NSURL URLWithString:properlyEscapedURL];
        
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
        if ([dictParam objectForKey:API_PARAM_TOKEN]!=nil) {
            [request addValue:[NSString stringWithFormat:@"%@",[dictParam objectForKey:API_PARAM_TOKEN]] forHTTPHeaderField:@"Authorization"];
        }
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:method];
        
        if ([dictParam objectForKey:API_PARAMS]!=nil) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[dictParam objectForKey:API_PARAMS]
                                                               options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                 error:&error];
            
            if (! jsonData) {
                NSLog(@"Got an error: %@", error);
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSLog(@"jsonString: %@", jsonString);
            }
            [request setHTTPBody:jsonData];
        }
        NSLog(@"%@", [request allHTTPHeaderFields]);
#ifdef DEBUG
        // Something to log your sensitive data here
        NSLog(@"URL_FILE_PATH: \n%@",stringUrl);
#else
        
        //
        
#endif
        NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request
                                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                                NSLog(@"%@",response);
                                                                if (response!=nil&&data!=nil) {
                                                                    NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
                                                                    id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                                    
                                                                    NSLog(@"Data: %@",dic);
                                                                    if (statusCode == 200 || statusCode == 201) {
                                                                        [self successWithData:data withError:error withNameNotification:nameNotification];
                                                                    }else {
                                                                        id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                                        NSDictionary*dictionaryData;
                                                                        if (dic!=nil) {
                                                                            dictionaryData=@{@"statusCode":[NSString stringWithFormat:@"%lu",(unsigned long)statusCode],
                                                                                             @"data":dic};
                                                                        }else{
                                                                            dictionaryData=@{@"statusCode":[NSString stringWithFormat:@"%lu",(unsigned long)statusCode]};
                                                                        }
                                                                        
                                                                        NSError *error;
                                                                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryData
                                                                                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                                                                             error:&error];
                                                                        
                                                                        if (! jsonData) {
                                                                            NSLog(@"Got an error: %@", error);
                                                                        } else {
                                                                            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                                                                            NSLog(@"jsonString: %@", jsonString);
                                                                        }
                                                                        
                                                                        [self successWithData:jsonData withError:error withNameNotification:nameNotification];
                                                                    }
                                                                }else{
                                                                    //
                                                                    NSLog(@"Got an error: %@", error);
                                                                }
                                                                
                                                                
                                                            }];
        
        [dataTask resume];
        // return dataTask;
        
    
}

-(void)getDataFromPath2:(NSString *)path withMethod:(NSString*)method withParamData:(NSDictionary *)dictParam withNotification:(NSString*)nameNotification{
    
    
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        
    }
    
    NSString*methodName=path;
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@",API_URL_BASE2,methodName];
    if (path==nil) {
        stringUrl = [[dictParam objectForKey:API_PARAMS] objectForKey:@"urlPath"];
    }
    NSString *properlyEscapedURL = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:properlyEscapedURL];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    if ([dictParam objectForKey:API_PARAM_TOKEN]!=nil) {
        [request addValue:[NSString stringWithFormat:@"%@",[dictParam objectForKey:API_PARAM_TOKEN]] forHTTPHeaderField:@"Authorization"];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:method];
    
    if ([dictParam objectForKey:API_PARAMS]!=nil) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[dictParam objectForKey:API_PARAMS]
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"jsonString: %@", jsonString);
        }
        [request setHTTPBody:jsonData];
    }
    NSLog(@"%@", [request allHTTPHeaderFields]);
#ifdef DEBUG
    // Something to log your sensitive data here
    NSLog(@"URL_FILE_PATH: \n%@",stringUrl);
#else
    
    //
    
#endif
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                            NSLog(@"%@",response);
                                                            if (response!=nil&&data!=nil) {
                                                                NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
                                                                id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                                
                                                                NSLog(@"Data: %@",dic);
                                                                if (statusCode == 200 || statusCode == 201) {
                                                                    [self successWithData:data withError:error withNameNotification:nameNotification];
                                                                }else {
                                                                    id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                                    NSDictionary*dictionaryData;
                                                                    if (dic!=nil) {
                                                                        dictionaryData=@{@"statusCode":[NSString stringWithFormat:@"%lu",(unsigned long)statusCode],
                                                                                         @"data":dic};
                                                                    }else{
                                                                        dictionaryData=@{@"statusCode":[NSString stringWithFormat:@"%lu",(unsigned long)statusCode]};
                                                                    }
                                                                    
                                                                    NSError *error;
                                                                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryData
                                                                                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                                                                         error:&error];
                                                                    
                                                                    if (! jsonData) {
                                                                        NSLog(@"Got an error: %@", error);
                                                                    } else {
                                                                        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                                                                        NSLog(@"jsonString: %@", jsonString);
                                                                    }
                                                                    
                                                                    [self successWithData:jsonData withError:error withNameNotification:nameNotification];
                                                                }
                                                            }else{
                                                                //
                                                                NSLog(@"Got an error: %@", error);
                                                            }
                                                            
                                                            
                                                        }];
    
    [dataTask resume];
    // return dataTask;
    
    
}

-(void)successWithData:(NSData*)data withError:(NSError*)error withNameNotification:(NSString*)nameNotification{
    if(error == nil){
        NSError *jsonError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        if (jsonError==nil) {
            
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSArray *jsonArray = (NSArray *)jsonObject;
#ifdef DEBUG
                
                // Something to log your sensitive data here
                NSLog(@"Notification: \n%@ \n JSON_ARRAY: \n%@",nameNotification,jsonArray);
#else
                
                //
                
#endif
                if (jsonArray==nil) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:nameNotification object:data];
                }else{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:nameNotification object:jsonArray];
                }
                
            } else {
                
                NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
#ifdef DEBUG
                
                // Something to log your sensitive data here
                NSLog(@"Notification: \n%@ \n JSON_DICTIONARY: \n%@",nameNotification,jsonDictionary);
#else
                
                //
                
#endif
                
                if (jsonDictionary==nil) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:nameNotification object:data];
                }else{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:nameNotification object:jsonDictionary];
                }
            }
            
        }else{
            //   NSLog(@"jsonError: %@",jsonError.description);
            //  NSDictionary*message = @{@"message":NSLocalizedString(@"ERROR_SERVER", nil)};
            //    [[NSNotificationCenter defaultCenter] postNotificationName:nameNotification object:message];
            
            NSDictionary*dictionaryData=@{@"statusCode":[NSString stringWithFormat:@"200"]};
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryData
                                                               options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                 error:&error];
            
            if (! jsonData) {
                NSLog(@"Got an error: %@", error);
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSLog(@"jsonString: %@", jsonString);
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:nameNotification object:dictionaryData];
        }
        
        
    }else{
#ifdef DEBUG
        
        // Something to log your sensitive data here
        NSLog(@"Error Description: \n%@",error.description);
#else
        
        //
        
#endif
    }
}


@end
