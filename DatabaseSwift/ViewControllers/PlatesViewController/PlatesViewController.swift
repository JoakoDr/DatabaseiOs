//
//  PlatesViewController.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 11/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class PlatesViewController: UIViewController {
    
    @IBOutlet weak var table : UITableView?
    internal var tasks: [Task] = []
    internal var repository = LocalTaskRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dinner Plates"
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addBarButtonItem, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc internal func addPressed()
    {
        
        let addView = AddViewController(task: nil)
        addView.delegate = self as! AddViewControllerDelegate
        addView.modalTransitionStyle = .coverVertical
        addView.modalPresentationStyle = .overCurrentContext
        present(addView,animated: true,completion: nil)
    }
  

}

extension PlatesViewController: UITableViewDelegate,UITableViewDataSource
    
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 88.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TaskTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell)!
        let task1 = tasks[indexPath.row]
        cell.nameLabel?.text = task1.name
        cell.imgLabel?.isHidden = !task1.isDone
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task1 = tasks[indexPath.row]
        task1.isDone = !task1.isDone
        if repository.update(a: task1)
        {
            table?.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task1 = tasks[indexPath.row]
            if repository.delete (a: task1)
            {
                tasks.remove(at: indexPath.row)
                table?.beginUpdates()
                table?.deleteRows(at: [indexPath], with: .automatic)
                table?.endUpdates()
            }
            
        }
    }
    
}
extension PlatesViewController: AddViewControllerDelegate
{
    func addViewController(_vc: AddViewController, didEditTask task: Task) {
        _vc.dismiss(animated: true, completion: nil)
        if repository.create(a: task) {
            tasks = repository.getAll()
            table?.reloadData()
        }
    }
}

