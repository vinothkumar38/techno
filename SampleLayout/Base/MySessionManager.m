//
//  MySessionManager.m
//  BaseProject
//
//  Created by Cumulations on 10/07/17.
//  Copyright © 2017 Cumulations. All rights reserved.
//

#import "MySessionManager.h"
#import "Reachability.h"
MySessionManager *PublicManager;
CompletionBlock commanCallBack;


@implementation MySessionManager
+(instancetype)sharedManager{
    if(PublicManager==nil){
        PublicManager = [MySessionManager new];
    }
    return PublicManager;
}
-(void)ApiWithUrl:(NSString*)urlStr andWithHeader:(NSDictionary*)headerDictionary andWithBody:(NSDictionary*)body andWithMethode:(NSString*)methode withCallBack:(CompletionBlock)callBack{
    if(callBack){
        commanCallBack = callBack;
    }
    if([Reachability hasConnectivity]){
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setHTTPAdditionalHeaders:headerDictionary];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:urlStr];

    if([methode isEqualToString:@"GET"]){
        [PublicManager getApiWithSession:session andWithUrl:url];
    }
    else if([methode isEqualToString:@"POST"]||[methode isEqualToString:@"PUT"]){

        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:methode];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:postData];
        [self postApiWithSession:session andWithUrl:url andWithRequest:request];

    }
    }
    else{
        commanCallBack(@"No internet connection",NO);
    }
}
-(void)getApiWithSession:(NSURLSession*)session andWithUrl:(NSURL*)url{
        NSURLSessionDataTask *apiCall= [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
        dispatch_async(dispatch_get_main_queue(), ^{
        if (error)
        {
            commanCallBack(@{@"error":@"Connection error"},NO);
        }
        else
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSInteger  responseStatusCod = [httpResponse statusCode];
            NSError *error1 = nil;
            id finalData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error1];
            if (responseStatusCod== 200)
            {
                commanCallBack(finalData,YES);
            }
            else{
                commanCallBack(finalData,NO);
            }
        }
        });
            }];
        [apiCall resume];

}
-(void)postApiWithSession:(NSURLSession*)session andWithUrl:(NSURL*)url andWithRequest:(NSMutableURLRequest*)request{

    NSURLSessionDataTask *apiCall = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{

        if(error){
            NSDictionary *errorDiction = [NSDictionary dictionaryWithObjectsAndKeys:@{@"error":@"Connection error, please try again"}, nil];
            commanCallBack(errorDiction,NO);
        }
        else{
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSInteger  responseStatusCod = [httpResponse statusCode];
            NSError *error1 = nil;
            id finalData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error1];
            if (responseStatusCod== 200)
            {
                commanCallBack(finalData,YES);

            }
            else{

                commanCallBack(finalData,NO);
            }
        }
        });
    }];
    [apiCall resume];
}
@end
