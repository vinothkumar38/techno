//
//  MySessionManager.h
//  BaseProject
//
//  Created by Cumulations on 10/07/17.
//  Copyright © 2017 Cumulations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySessionManager : NSObject
typedef void (^CompletionBlock)(id response,BOOL success);

-(void)ApiWithUrl:(NSString*)urlStr andWithHeader:(NSDictionary*)headerDictionary andWithBody:(NSDictionary*)body andWithMethode:(NSString*)methode withCallBack:(CompletionBlock)callBack;
+(instancetype)sharedManager;
@end
