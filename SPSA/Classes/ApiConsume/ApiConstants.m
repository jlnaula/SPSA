//
//  ApiConstants.m
//  SPSA
//
//  Created by Jorge Naula Rios on 8/9/17.
//  Copyright © 2017 Jorge Naula Rios. All rights reserved.
//

#import "ApiConstants.h"

NSString *const API_URL_BASE = @"http://13.58.168.88/juegos_spsa/";
//NSString *const API_URL_BASE = @"http://18.220.23.80/juegos_spsa/";
NSString *const API_URL_BASE2 = @"http://34.201.27.155/";

NSString *const POST = @"POST";
NSString *const GET = @"GET";
NSString *const PUT = @"PUT";

NSString *const API_PARAM_TOKEN = @"Token";
NSString *const API_PARAMS = @"Params";


NSString *const URL_HOME = @"user/home?user_dni=%@&user_name=%@&user_last_name=%@";
NSString *const URL_VOTE = @"user/vote";
NSString *const URL_GET_QUESTION = @"user/question";
NSString *const URL_SEND_ANSWER = @"user/answer";
