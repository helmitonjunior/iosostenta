//
//  ViewController.m
//  BusOn
//
//  Created by Pedro Augusto Silva Lucena on 22/03/14.
//  Copyright (c) 2014 Pedro Augusto Silva Lucena. All rights reserved.
//

#import "ViewController.h"
#import "Communication.h"


@interface ViewController () 
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passText;


@end

@implementation ViewController



- (IBAction)RegisterClick:(id)sender {
    [self performSegueWithIdentifier:@"registerSegue" sender:self];

    
}


- (IBAction)loginClickTest:(id)sender {
    Communication *comm = [[Communication alloc] init];
    NSString *email = _emailText.text;
    NSString *password = _passText.text;
        if (email.length == 0 || password.length == 0){
            [comm alertStatus:@"Por favor digite Email e Senha" :@"Login falhou." :0 :self];
    }else {
    	bool validEmail = [comm validateEmail:email];
    	bool validPassword = [comm validatePassword:password];
        
    	if(!validEmail){
    		[comm alertStatus:@"Por favor entre com um email válido" :@"Login falhou." :0 :self];
    	}else if(!validPassword){
    		[comm alertStatus:@"Sua senha deve ter no mínimo 6 caracteres" :@"Login falhou" :0 :self];
    	}else{
    		NSString *postString =[[NSString alloc] initWithFormat:@"SOLICITACAO=LOGIN& EMAIL=%@&SENHA=%@", email, password];
            NSString *urlString = @"https://buson.info/php/login.php";
            bool success = [comm communicationWithServer:urlString andString:postString andSender:sender andDelegate:self];
            if(success){
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }
    	}
    
        
    }
    
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField{
    [textField resignFirstResponder];
    return YES;
}



@end