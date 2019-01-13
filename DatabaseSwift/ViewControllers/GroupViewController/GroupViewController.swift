//
//  GroupViewController.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 11/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    @IBOutlet weak var table : UITableView?
    internal var groups: [Group] = []
    internal var users: [Task] = []
    internal var repository = GroupRepository()
    internal var repository2 = LocalTaskRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        title = "Group Friends"
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addBarButtonItem, animated: true)

        // Do any additional setup after loading the view.
    }

    @objc internal func addPressed()
    {
        
        let addView = AddGroupViewController(group: nil)
        addView.delegate = self as AddGroupViewControllerDelegate
        addView.modalTransitionStyle = .coverVertical
        addView.modalPresentationStyle = .overCurrentContext
        present(addView,animated: true,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func registerCell()
    {
        let indentifier = "GroupTableViewCell"
        let nib = UINib(nibName: indentifier, bundle: nil)
        table?.register(nib, forCellReuseIdentifier: "GroupCell")
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
extension GroupViewController: UITableViewDelegate,UITableViewDataSource
    
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 88.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: GroupTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupTableViewCell)!
        let task1 = groups[indexPath.row]
        cell.nameGroupLabel?.text = task1.name
        
            table?.reloadRows(at: [indexPath], with: .automatic)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]
        users = repository2.getAll()
        let friendsVC = FriendsViewController()
        group.people = users
        navigationController?.pushViewController(friendsVC, animated: true)
        if repository.update(a: group)
        {
            table?.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task1 = groups[indexPath.row]
            if repository.delete (a: task1)
            {
                groups.remove(at: indexPath.row)
                table?.beginUpdates()
                table?.deleteRows(at: [indexPath], with: .automatic)
                table?.endUpdates()
            }
            
        }
    }
    
}
extension GroupViewController: AddGroupViewControllerDelegate
{
    func addGroupViewController(_vc: AddGroupViewController, didEditTask group: Group) {
        _vc.dismiss(animated: true, completion: nil)
        if repository.create(a: group) {
            groups = repository.getAll()
            table?.reloadData()
        }
    }
    
}
