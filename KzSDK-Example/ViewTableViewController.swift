//
//  ViewTableViewController.swift
//  KzSDK-Example
//
//  Created by K-zing on 30/5/2018.
//  Copyright © 2018 K-zing. All rights reserved.
//

import UIKit
import KzSDK_Swift

class ViewTableViewController: UITableViewController {
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func navigateListTableViewController(logined: Bool){
        let listTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
        listTableViewController.logined = logined
        
        self.navigationController?.pushViewController(listTableViewController, animated: true)
    }

    @IBAction func loginClick(_ sender: UIButton) {
        let username = txtUsername.text
        let password = txtPassword.text
        
        ApiAction.Login().addListener(ApiListener<ApiAction.Login.Result>.init(onSuccess: { (result) in
            print(result)
            DispatchQueue.main.async {
                self.navigateListTableViewController(logined: true)
            }
        }, onFail: { (result) in
            print(result)
        }).popAlertOnFail(true, viewController: self)).setUsername(username).setPassword(password).post()
    }
    
    @IBAction func guestClick(_ sender: UIButton) {
        navigateListTableViewController(logined: false)
    }
    
    @IBAction func webViewClick(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "WebViewController")
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(describing: ApiAction.Login().self).replacingOccurrences(of: "KzSDK_Swift.", with: "")
    }
}

