//
//  VideoControllerManageBridge.m
//  movie-maker
//
//  Created by Erivelton Elias on 3/25/18.
//  Copyright © 2018 650 Industries, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <React/RCTBridgeModule.h>


@interface RCT_EXTERN_MODULE(VideoController, NSObject)

RCT_EXTERN_METHOD(showVideo:(NSString *)name callback: (RCTResponseSenderBlock)callback);


//RCT_EXTERN_METHOD(openNativeScreen);



@end
