//
//  YHNetworkTool.m
//  MyNews
//
//  Created by TyhOS on 2017/12/26.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "YHNetworkTool.h"
#import <AFNetworking.h>
@implementation YHNetworkTool
static YHNetworkTool *_instance;

+(instancetype)shareYHNetworkTool
{
   
    return [[self alloc] init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        if (!_instance) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+(void)requestWithUrlString:(NSString *)url parameters:(NSDictionary *)paramenters method:(NSString *)method success:(void (^)(id))sucess failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if ([method isEqualToString:@"GET"]) {
        [manager GET:url parameters:paramenters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            sucess(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
            NSLog(@"请求失败，%@",error);
        }];
    }
    if ([method isEqualToString:@"POST"]) {
        [manager POST:url parameters:paramenters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            sucess(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
            NSLog(@"请求失败,%@",error);
        }];
    }
}
@end
