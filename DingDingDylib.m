//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  DingDingDylib.m
//  DingDingDylib
//
//  Created by 李超群 on 2019/1/5.
//  Copyright (c) 2019 李超群. All rights reserved.
//

#import "DingDingDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>
#import <CoreLocation/CoreLocation.h>

CHConstructor{
    NSLog(INSERT_SUCCESS_WELCOME);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
#ifndef __OPTIMIZE__
        CYListenServer(6666);

        MDCycriptManager* manager = [MDCycriptManager sharedInstance];
        [manager loadCycript:NO];

        NSError* error;
        NSString* result = [manager evaluateCycript:@"UIApp" error:&error];
        NSLog(@"result: %@", result);
        if(error.code != 0){
            NSLog(@"error: %@", error.localizedDescription);
        }
#endif
        
    }];
}


CHDeclareClass(DTALocationManager)


CHOptimizedMethod2(self, void, DTALocationManager, amapLocationManager, id, arg1, didUpdateLocation, id, arg2){
    NSLog(@"%@--%@", arg1, arg2);
    id arg = [[CLLocation alloc] initWithLatitude:40.103648 longitude:116.558864];
    CHSuper2(DTALocationManager, amapLocationManager, arg1, didUpdateLocation, arg);
}

CHConstructor{
    CHLoadLateClass(DTALocationManager);
    CHHook2(DTALocationManager, amapLocationManager, didUpdateLocation);
}

