//
//  AddGroupViewController.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 11/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

protocol AddGroupViewControllerDelegate: class {
    
    func addGroupViewController(_vc: AddGroupViewController, didEditTask group: Group)
}

class AddGroupViewController: UIViewController {
    weak var delegate: AddGroupViewControllerDelegate!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    internal var group: Group!
    
    
    convenience init(group: Group?)
    {
        self.init()
        if group == nil{
            self.group = Group()
            self.group.id = UUID().uuidString
            self.group.name = ""
            self.group.people = nil
        }
        else
        {
            self.group = group
        }
    }
    //funcion para poner el fondo a la animacion que creamos
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8) {
            self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBack.layer.cornerRadius = 8.0
        viewBack.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = 8.0
        saveButton.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonPressed()
    {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func saveButtonPressed()
    {
        
        self.group.name = textFieldName.text
        delegate.addGroupViewController(_vc: self, didEditTask: group)
        
    }

}
