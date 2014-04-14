//
//  Communication.m
//  BusOn
//
//  Created by Pedro Augusto Silva Lucena on 14/04/14.
//  Copyright (c) 2014 Pedro Augusto Silva Lucena. All rights reserved.
//

#import "Communication.h"

@implementation Communication

- (BOOL) communicationWithServer:(NSString *) urlString
                       andString:(NSString *) postString
                       andSender:(id) sender
                     andDelegate:(id /*<UIAlertViewDelegate>*/) delegate
{
    NSInteger success = 0;
    @try {
        
        
        NSString *post = postString;
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:urlString];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSString *responseData2 = [responseData substringWithRange:NSMakeRange(1, [responseData length] - 2)];
            NSString *responseData3 = [responseData2 stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            NSLog(@"Response ==> %@", responseData3);
            
            NSData *newData = [responseData3 dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *error = nil;
            NSDictionary *jsonData = [NSJSONSerialization
                                      JSONObjectWithData:newData
                                      options:NSJSONReadingMutableContainers
                                      error:&error];
            
            
            NSString *suc = [jsonData objectForKey:@"STATUS"];
            
            NSLog(@"%@", suc);
            
            if ([suc isEqualToString:@"SUCESSO"]){
                success = 1;
            }
            //success = [jsonData[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                NSLog(@"Login SUCCESS");
            } else {
                NSString *erroLogin = [jsonData objectForKey:@"ERRO"];
                /*if ([erroLogin length] == 0){
                 erroLogin = @"Usuario inexistente";
                 }*/
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
                [self alertStatus:error_msg :erroLogin :0 :delegate];
                
            }
            
        } else {
            //if (error) NSLog(@"Error: %@", error);
            [self alertStatus:@"Connection Failed" :@"Sign in Failed! Hue BR" :0 :delegate];
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed. Except." :@"Error!" :0 :delegate];
    }
    if (success) {
        return YES;
    }else{
        return NO;
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag :(id /*<UIAlertViewDelegate>*/) delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:delegate
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

- (BOOL) validateEmail: (NSString *) email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

- (BOOL) validatePassword: (NSString *)  password {
	if ([password length] < 6) {
        return NO;
    }
	NSString *passwordRegex = @"([a-zA-Z0-9.-_]+)";
	NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    
	return [passwordTest evaluateWithObject:password];
    
}

- (BOOL) validateUsername: (NSString *)  username {
    if ([username length] < 3) {
        return NO;
    }
    NSString *usernameRegex = @"([a-zA-Z0-9.-_]+)";
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegex];
    
    return [usernameTest evaluateWithObject:username];
    
}

@end
