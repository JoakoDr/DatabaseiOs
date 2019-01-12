//
//  FriendsViewController.swift
//  DatabaseSwift
//
//  Created by Dario Autric on 12/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var table : UITableView?
    internal var groups: [Group] = []
    internal var repository = GroupRepository()
    internal var tasks: [Task] = []
    internal var repository2 = LocalTaskRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func registerCell()
    {
        let indentifier = "TaskTableViewCell"
        let nib = UINib(nibName: indentifier, bundle: nil)
        table?.register(nib, forCellReuseIdentifier: "TaskCell")
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
extension FriendsViewController: UITableViewDelegate,UITableViewDataSource
    
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
        cell.jobLabel?.text = task1.job
        cell.favLabel?.text = task1.food
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task1 = tasks[indexPath.row]
        let addView = EditViewController(task: task1)
        addView.delegate = self as? EditViewControllerDelegate
        addView.modalTransitionStyle = .coverVertical
        addView.modalPresentationStyle = .overCurrentContext
        present(addView,animated: true,completion: nil)
        if repository2.update(a: task1)
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
            if repository2.delete (a: task1)
            {
                tasks.remove(at: indexPath.row)
                table?.beginUpdates()
                table?.deleteRows(at: [indexPath], with: .automatic)
                table?.endUpdates()
            }
            
        }
    }
    
}
extension FriendsViewController: AddViewControllerDelegate
{
    func addViewController(_vc: AddViewController, didEditTask task: Task) {
        _vc.dismiss(animated: true, completion: nil)
        if repository2.create(a: task) {
            tasks = repository2.getAll()
            table?.reloadData()
        }
    }
}
