//
//  ViewController.m
//  BusOn
//
//  Created by Pedro Augusto Silva Lucena on 22/03/14.
//  Copyright (c) 2014 Pedro Augusto Silva Lucena. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passText;


@end

@implementation ViewController

- (IBAction)LoginClick:(id)sender {
    NSString *email = _emailText.text;
    NSString *password = _passText.text;
    if (!email || !password){
    	[self alertStatus:@"Por favor digite Email e Senha" :@"Login falhou." :0];
    }else {
    	bool validEmail = [self validateEmail:email];
    	bool validPassword = [self validatePassword:password];
        
    	if(!validEmail){
    		[self alertStatus:@"Por favor entre com um email válido" :@"Login falhou." :0];
    	}else if(!validPassword){
    		[self alertStatus:@"Sua senha deve ter no mínimo 6 caracteres" :@"Login falhou" :0];
    	}else{
    		[self LoginWithEmail:email andPassword:password andSender:sender];
    	}
        
        
    }
}

- (void) LoginWithEmail:(NSString *) email andPassword:(NSString *) password andSender:(id) sender
{
	NSInteger success = 0;
    @try {
        
        
        NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@", email, password];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"https://buson.info/php/"];
        
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
            NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
            NSDictionary *jsonData = [NSJSONSerialization
                                      JSONObjectWithData:urlData
                                      options:NSJSONReadingMutableContainers
                                      error:&error];
            
            success = [jsonData[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                NSLog(@"Login SUCCESS");
            } else {
                
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
                [self alertStatus:error_msg :@"Sign in Failed!" :0];
            }
            
        } else {
            //if (error) NSLog(@"Error: %@", error);
            [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        [self performSegueWithIdentifier:@"login_success" sender:self];
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
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


@end