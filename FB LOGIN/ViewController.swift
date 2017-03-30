// L' ACCOUNT DI FIREBASE è 22giulio22@gmail.com

import UIKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController,FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        
        // questo modo di fare layout è obsoleto quindi devo poi usare i costrain
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
     
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("LOGOUNT DA FB")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil
        {
        
            print(error)
            return
        
        }
        
        print("LOGIN CORRETTO")
        
        // permette di fare una richiesta a fb sul mio profilo: /me e mandarmi il nome, la mail e l'id
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection , results, erorr) in
            if error != nil
            {
                print("erorre:",error)
                return
            }
           // ora entro con i dati che ho ricevuto su firebase
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString else {return}
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString )
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if error != nil
                {
                    print("erorre:",error)
                    return
   
                }
                
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

