//
//  MainViewController.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 19/12/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var table : UITableView?
    internal var tasks: [Task] = []
    internal var repository = LocalTaskRepository()
    internal var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        tasks = repository.getAll()
        title = "Dinner People"
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addBarButtonItem, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @objc internal func addPressed()
    {
        
        let addView = AddViewController(task: nil)
        addView.delegate = self as AddViewControllerDelegate
        addView.modalTransitionStyle = .coverVertical
        addView.modalPresentationStyle = .overCurrentContext
        present(addView,animated: true,completion: nil)
    }
    @IBAction func morosoActionButtonPressed()
    {
        let myCategory = tasks
        let filteredVC = FilteredViewController(tasks: myCategory)
        navigationController?.pushViewController(filteredVC, animated: true)
        
    }
    internal func registerCell()
    {
        let indentifier = "TaskTableViewCell"
        let nib = UINib(nibName: indentifier, bundle: nil)
        table?.register(nib, forCellReuseIdentifier: "TaskCell")
        let indentifier2 = "UserTableViewCell"
        let nib2 = UINib(nibName: indentifier2, bundle: nil)
        table?.register(nib2, forCellReuseIdentifier: "User2Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension MainViewController: UITableViewDelegate,UITableViewDataSource
    
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
        
        let cell: UserTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "User2Cell", for: indexPath) as? UserTableViewCell)!
       let task1 = tasks[indexPath.row]
        cell.nameLabel?.text = task1.name
        cell.foodLabel?.text = task1.food
         cell.imgPaid?.isHidden = !task1.isDone
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         task = tasks[indexPath.row]
        let addView = EditViewController(task: task)
        addView.delegate = self as? EditViewControllerDelegate
        addView.modalTransitionStyle = .coverVertical
        addView.modalPresentationStyle = .overCurrentContext
        present(addView,animated: true,completion: nil)
        if repository.update(a: task!)
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
extension MainViewController: AddViewControllerDelegate
{
    func addViewController(_vc: AddViewController, didEditTask task: Task) {
        _vc.dismiss(animated: true, completion: nil)
        if repository.create(a: task) {
            tasks = repository.getAll()
            table?.reloadData()
        }
    }
}
extension MainViewController: EditViewControllerDelegate
{
    func editViewController(_vc: EditViewController, didEditTask task: Task) {
        _vc.dismiss(animated: true, completion: nil)
        if repository.update(a: task) {
            table?.reloadData()
        }
    }

}
