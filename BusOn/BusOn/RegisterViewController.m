//
//  RegisterViewController.m
//  BusOn
//
//  Created by Pedro Augusto Silva Lucena on 03/04/14.
//  Copyright (c) 2014 Pedro Augusto Silva Lucena. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *passText;
@property (weak, nonatomic) IBOutlet UITextField *cPassText;

@end

@implementation RegisterViewController

- (IBAction)backToLogin:(id)sender {
    [self performSegueWithIdentifier:@"backToLoginSegue" sender:self];
}

- (IBAction)registerUser:(id)sender {
    NSString *name = _nameText.text;
    NSString *email = _emailText.text;
    NSString *username = _userText.text;
    NSString *password = _passText.text;
    NSString *confirm = _cPassText.text;
    if (name.length == 0 || email.length == 0 || username.length == 0 || password.length == 0 || confirm.length == 0){
        [self alertStatus:@"Por favor preencha todos os campos" :@"Cadastro falhou" :0];
    }else{
        bool validEmail = [self validateEmail:email];
    	bool validPassword = [self validatePassword:password];
        bool validUsername = [self validateUsername:username];
        
        if (!validEmail){
            [self alertStatus:@"Por favor entre com um email válido" :@"Cadastro falhou." :0];
        }else if(!validUsername){
    		[self alertStatus:@"Por favor entre com um username válido" :@"Cadastro falhou" :0];
    	}else if(!validPassword){
    		[self alertStatus:@"Sua senha deve ter no mínimo 6 caracteres" :@"Cadastro falhou" :0];
    	}else if(![confirm isEqualToString:password]){
            [self alertStatus:@"Confirme sua senha corretamente" :@"Cadastro falhou" :0];
        }else{
            NSLog(@"lalala");
        }

    }
    
    
    
}
- (void) RegisterWithName:(NSString *) name
                 andEmail:(NSString *) email
              andUsername:(NSString *) username
              andPassword:(NSString *) password
               andConfirm:(NSString *) confirm
                andSender:(id) sender
{
    
    
    
    
    
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField{
    [textField resignFirstResponder];
    return YES;
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
    if ([username length] < 4) {
            return NO;
    }
    NSString *usernameRegex = @"([a-zA-Z0-9.-_]+)";
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegex];
                  
    return [usernameTest evaluateWithObject:username];
                  
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
