//
//  ViewController.swift
//  TableForm
//
//  Created by Deepak Kumar on 16/05/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableViewHeader: UIImageView!
    @IBOutlet weak var formTableView: UITableView!
    @IBOutlet var header: UIView!
    @IBOutlet var tableViewBottom: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Variables
    var dataSource: [FormDataSource]? // FormDataSource is an enum
    var user: User = User() // User is class
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Method
    func setup() {
        formTableView.register(UINib.init(nibName: "FormTableViewCell", bundle: nil), forCellReuseIdentifier: "formCellId")
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
        loginButton.layer.masksToBounds = true
        
        FormDataSource.user = user
        dataSource = FormDataSource.allLoginFields
        formTableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - IBActiona Methods
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print(user.username)
        print(user.password)
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let photosViewC = storyBoard.instantiateViewController(withIdentifier: "PhotosViewController") as? PhotosViewController {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = photosViewC
            
            
            // create a new UINavigationController
            let newNavVC = UINavigationController()
            
            // set the "root" VC of the NavVC to your SearchResultsTableViewController
            newNavVC.setViewControllers([photosViewC], animated: false)
            
            // use the new NavVC as the new rootViewController
            UIApplication.shared.keyWindow?.rootViewController = newNavVC
            UIApplication.shared.keyWindow?.rootViewController?.navigationController?.isNavigationBarHidden = false
        }
    }
    

}

// MARK: TableView Extension

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return data.formArrayDict.count
        
        guard  let dataSource = self.dataSource else { return 0 }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = formTableView.dequeueReusableCell(withIdentifier: "formCellId") as? FormTableViewCell {
            
            if let dataSource = self.dataSource {
                cell.formData = dataSource[indexPath.row]
            }
            cell.delegate = self
            cell.formTextField.tag = indexPath.row // set tag, to identify text fields, so that become 1st responder can be used
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.size.height / 2 - 130
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.view.frame.size.height / 2 - 170
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableViewBottom
    }
}

extension ViewController: FormTableViewCellDelegate {
    
    func valueDidChanged(_ formData: FormDataSource, value: String) {
        switch formData {
        case .username:
            user.username = value
        case .password:
            user.password = value
        default: break
        }
    }
}
