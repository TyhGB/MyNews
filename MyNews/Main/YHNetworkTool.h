//
//  YHNetworkTool.h
//  MyNews
//
//  Created by TyhOS on 2017/12/26.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHNetworkTool : NSObject

+(instancetype)shareYHNetworkTool;

+(void)requestWithUrlString:(NSString *)url
                 parameters:(NSDictionary *)paramenters
                     method:(NSString *)method         //GET或者POST
                   success:(void(^)(id resposeObject))sucess
                    failure:(void(^)(NSError *error))failure;
@end
