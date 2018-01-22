//
//  UserViewController.swift
//  DOIT
//
//  Created by pow on 2018/1/16.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    

    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var userNameTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人信息"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style:.done, target:self, action:#selector(done_Action(_ :)))
        self.navigationController?.navigationBar.tintColor = MAINREDCOLOR
        
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func userImageClick_Action(_ sender: UIButton) {
        
        let sheest:UIAlertController = UIAlertController.init(title: "选取照片", message:nil, preferredStyle: .actionSheet)
        let imagePicker:UIImagePickerController = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        let photoLibiary:UIAlertAction = UIAlertAction.init(title: "从相册选取", style:.default) { (action) in
            
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion:nil)
            
            
        }
        let cmaera:UIAlertAction = UIAlertAction.init(title: "拍照选取", style: .default) { (action) in
            
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion:nil)
            
        }
        
        let cancel:UIAlertAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        sheest.addAction(cmaera)
        sheest.addAction(photoLibiary)
         sheest.addAction(cancel)
        self.present(sheest, animated: true, completion: nil)
        
        
        
        
        
    }
    @objc func done_Action(_ sender:UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion:{
            if let image = info[UIImagePickerControllerEditedImage] {
                
                self.userImageButton.setImage(image as? UIImage, for: .normal)
                
            }
      
        })
       
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            return tableView.dequeueReusableCell(withIdentifier: "IDcell")!
            
        }else if  indexPath.row == 1{
            
            return tableView.dequeueReusableCell(withIdentifier: "sexCell")!
        }
        return UITableViewCell()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
