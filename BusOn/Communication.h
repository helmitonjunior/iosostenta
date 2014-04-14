//
//  Communication.h
//  BusOn
//
//  Created by Pedro Augusto Silva Lucena on 14/04/14.
//  Copyright (c) 2014 Pedro Augusto Silva Lucena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Communication : NSObject

- (BOOL) communicationWithServer:(NSString *) urlString
                       andString:(NSString *) postString
                       andSender:(id) sender
                     andDelegate:(id /*<UIAlertViewDelegate>*/) delegate;

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag :(id /*<UIAlertViewDelegate>*/) delegate;

- (BOOL) validateEmail: (NSString *) email;

- (BOOL) validatePassword: (NSString *)  password;

- (BOOL) validateUsername: (NSString *)  username;




@end
