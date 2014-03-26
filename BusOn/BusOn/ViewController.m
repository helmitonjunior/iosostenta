//
//  ViewController.m
//  BusOn
//
//  Created by Pedro Augusto Silva Lucena on 22/03/14.
//  Copyright (c) 2014 Pedro Augusto Silva Lucena. All rights reserved.
//

#import "ViewController.h"
#import "Login.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passText;
@property (strong, nonatomic) Login *login;
//@property (strong, nonatomic) NSString *email;
//@property (strong, nonatomic) NSString *password;

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
    		[self.login LoginWithEmail:email andPassword:password andSender:sender];
    	}
        
        
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