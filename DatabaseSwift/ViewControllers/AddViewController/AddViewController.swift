//
//  AddViewController.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 19/12/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit
protocol AddViewControllerDelegate: class {
    
    func addViewController(_vc: AddViewController, didEditTask task: Task)
}

class AddViewController: UIViewController {
    
   
    weak var delegate: AddViewControllerDelegate!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldJob: UITextField!
    @IBOutlet weak var textFieldFav: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    internal var task: Task!
    
    
    convenience init(task: Task?)
    {
        self.init()
        if task == nil{
            self.task = Task()
            self.task.id = UUID().uuidString
            self.task.name = ""
            self.task.job = ""
            self.task.food = ""
        }
        else
        {
            self.task = task
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
        
        self.task.name = textFieldName.text
        self.task.job = textFieldJob.text
        self.task.food = textFieldFav.text
        if(textFieldName.text==nil || textFieldJob.text == nil || textFieldFav.text == nil)
        {
            
            let alert2 = UIAlertController(title :"You need to fill everything", message: "Press continue", preferredStyle: .actionSheet)
            alert2.addAction(UIAlertAction(title:"Continue",style: .default, handler: nil))
            
        }
        else{
        delegate.addViewController(_vc: self, didEditTask: task)
        }
    }

}
