//
//  RegisterViewController.m
//  BusOn
//
//  Created by Pedro Augusto Silva Lucena on 03/04/14.
//  Copyright (c) 2014 Pedro Augusto Silva Lucena. All rights reserved.
//

#import "RegisterViewController.h"
#import "Communication.h"

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
    Communication *comm = [[Communication alloc] init];
    NSString *name = _nameText.text;
    NSString *email = _emailText.text;
    NSString *username = _userText.text;
    NSString *password = _passText.text;
    NSString *confirm = _cPassText.text;
    if (name.length == 0 || email.length == 0 || username.length == 0 || password.length == 0 || confirm.length == 0){
        [comm alertStatus:@"Por favor preencha todos os campos" :@"Cadastro falhou" :0 :self];
    }else{
        bool validEmail = [comm validateEmail:email];
    	bool validPassword = [comm validatePassword:password];
        bool validUsername = [comm validateUsername:username];
        
        if (!validEmail){
            [comm alertStatus:@"Por favor entre com um email válido" :@"Cadastro falhou." :0 :self];
        }else if(!validUsername){
    		[comm alertStatus:@"Por favor entre com um username válido" :@"Cadastro falhou" :0 :self];
    	}else if(!validPassword){
    		[comm alertStatus:@"Sua senha deve ter no mínimo 6 caracteres" :@"Cadastro falhou" :0 :self];
    	}else if(![confirm isEqualToString:password]){
            [comm alertStatus:@"Confirme sua senha corretamente" :@"Cadastro falhou" :0 :self];
        }else{
            NSString *postString = [[NSString alloc] initWithFormat:@"SOLICITACAO=CADASTRO&NOME=%@&USERNAME=%@&EMAIL=%@&SENHA=%@", name, username, email, password];
            NSString *urlString = @"https://buson.info/php/cadastro.php";
            bool success = [comm communicationWithServer:urlString andString:postString andSender:sender andDelegate:self];
            if (success){
                [comm alertStatus:@"Cadastro feito com sucesso." :@"OK!" :0 :self];
                [self performSegueWithIdentifier:@"backToLoginSegue" sender:self];
            }
        }

    }
    
    
    
}
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

//- (IBAction)backgroundTap:(id)sender {
    //[self.view endEditing:YES];
//}

-(BOOL) textFieldShouldReturn: (UITextField *) textField{
    [textField resignFirstResponder];
    return YES;
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
