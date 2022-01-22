//
//  NoteTableView.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/06.
//


import UIKit
import CoreData

var noteList = [Note]()

class NoteTableView: UITableViewController {
    

    override func viewDidLoad() {
         
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = "原因と解決策"
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            // 文字の色
            .foregroundColor: UIColor.systemTeal
            ]
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        
       return noteList.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let note = noteList[indexPath.row]
     cell.textLabel?.text = note.chestity!
        
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
  
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            noteList = try context.fetch(Note.fetchRequest())
        }
        catch{
            print("読み込み失敗")
        }
    }
    
    
    
    //delete
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete{
            let note = noteList[indexPath.row]
            context.delete(note)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                noteList = try context.fetch(Note.fetchRequest())
            }
            catch {
                print("読み込み失敗")
            }
        }
        tableView.reloadData()
    }

   
}
