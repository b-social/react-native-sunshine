#import "RCTSmooch.h"
#import <Smooch/Smooch.h>

@implementation SmoochManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(show) {
    NSLog(@"Smooch Show");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Smooch show];
    });
};

RCT_EXPORT_METHOD(showConversationById:(NSString*)conversationId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"Smooch Show Conversation By ID");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Smooch showConversationWithId:conversationId];
    });

    resolve(nil);
};

RCT_EXPORT_METHOD(setCurrentConversationDetails:(NSString*)name description:(NSString*)description resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"Smooch Set Conversation Details");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        SKTConversation* conversation = [Smooch conversation];
        NSString *conversationId = conversation.conversationId;
        [Smooch updateConversationById:conversationId withName:name description:description iconUrl:NULL metadata:NULL completionHandler:^(NSError * _Nullable error, NSDictionary * _Nullable userInfo) {
            if (error) {
                reject(
                       userInfo[SKTErrorCodeIdentifier],
                       userInfo[SKTErrorDescriptionIdentifier],
                       error);
            }
            else {
                resolve(userInfo);
            }
        }];
    });
};

RCT_EXPORT_METHOD(showConversationList) {
    NSLog(@"Smooch Show Convesation List");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Smooch showConversationList];
    });
};

RCT_EXPORT_METHOD(showWithStartingText:(NSString*)text) {
    NSLog(@"Smooch showWithStartingText %@", text);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Smooch showWithStartingText:text];
    });
};

RCT_EXPORT_METHOD(close) {
    NSLog(@"Smooch Close");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Smooch close];
    });
};

RCT_EXPORT_METHOD(setFirebaseCloudMessagingToken:(NSString*)token) {
    NSData* tokenData = [token dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Smooch setFirebaseCloudMessagingToken %@", token);
    [Smooch setPushToken:(tokenData)];
};

RCT_EXPORT_METHOD(login:(NSString*)userId jwt:(NSString*)jwt resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"Smooch Login");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Smooch login:userId jwt:jwt completionHandler:^(NSError * _Nullable error, NSDictionary * _Nullable userInfo) {
            if (error) {
                reject(
                       userInfo[SKTErrorCodeIdentifier],
                       userInfo[SKTErrorDescriptionIdentifier],
                       error);
            }
            else {
                resolve(userInfo);
            }
        }];
    });
};

RCT_EXPORT_METHOD(logout:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"Smooch Logout");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Smooch logoutWithCompletionHandler:^(NSError * _Nullable error, NSDictionary * _Nullable userInfo) {
            if (error) {
                reject(
                       userInfo[SKTErrorCodeIdentifier],
                       userInfo[SKTErrorDescriptionIdentifier],
                       error);
            }
            else {
                resolve(userInfo);
            }
        }];
    });
};


RCT_EXPORT_METHOD(setUserProperties:(NSDictionary*)options) {
    NSLog(@"Smooch setUserProperties with %@", options);
    
    [[SKTUser currentUser] addMetadata:options];
};

RCT_EXPORT_METHOD(getUserId:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"Smooch getUserId");
    
    resolve([SKTUser currentUser].userId);
};

RCT_REMAP_METHOD(getUnreadCount,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    NSLog(@"Smooch getUnreadCount");
    
    long unreadCount = [Smooch conversation].unreadCount;
    resolve(@(unreadCount));
};

RCT_EXPORT_METHOD(setFirstName:(NSString*)firstName) {
    NSLog(@"Smooch setFirstName");
    
    [SKTUser currentUser].firstName = firstName;
};

RCT_EXPORT_METHOD(setLastName:(NSString*)lastName) {
    NSLog(@"Smooch setLastName");
    
    [SKTUser currentUser].lastName = lastName;
};

RCT_EXPORT_METHOD(setEmail:(NSString*)email) {
    NSLog(@"Smooch setEmail");
    
    [SKTUser currentUser].email = email;
};


RCT_EXPORT_METHOD(setSignedUpAt:(NSDate*)date) {
    NSLog(@"Smooch setSignedUpAt");
    
    [SKTUser currentUser].signedUpAt = date;
};


@end
