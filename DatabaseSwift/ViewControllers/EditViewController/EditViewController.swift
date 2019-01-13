//
//  EditViewController.swift
//  DatabaseSwift
//
//  Created by Dario Autric on 12/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

protocol EditViewControllerDelegate: class {
    
    func editViewController(_vc: EditViewController, didEditTask task: Task)
}

class EditViewController: UIViewController {
    
    weak var delegate: EditViewControllerDelegate!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldJob: UITextField!
    @IBOutlet weak var textFieldFav: UITextField!
    @IBOutlet weak var swtPaid: UISwitch!
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
            self.task.isDone = false
        }
        else
        {
            self.task = task
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8) {
            self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
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
        if (swtPaid.isOn){
        self.task.isDone = true
        }
        else {
            task.isDone = false
        }
        print(task)
        delegate.editViewController(_vc: self, didEditTask: task)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
