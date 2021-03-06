//
//  FilteredViewController.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 11/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class FilteredViewController: UIViewController {
    
    var morosos = [Task]()
    @IBOutlet weak var table : UITableView?
    internal var tasks: [Task] = []
    internal var repository = LocalTaskRepository()
    convenience init(tasks: [Task])
    {
        self.init()
        self.tasks = tasks
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        
        let participantesMorosos = tasks.filter{
            (participantes) -> Bool in return participantes.isDone == false
        }
        morosos = participantesMorosos
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    internal func registerCell()
    {
        let indentifier = "FilterTableViewCell"
        let nib = UINib(nibName: indentifier, bundle: nil)
        table?.register(nib, forCellReuseIdentifier: "FilterCell")
    }

}
extension FilteredViewController: UITableViewDelegate,UITableViewDataSource
    
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return morosos.count
        
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return (morosos.count>0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 88.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FilterTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterTableViewCell)!
        
           let moroso = morosos[indexPath.row]
    
        cell.nameMorosoLabel?.text = moroso.name
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
}

