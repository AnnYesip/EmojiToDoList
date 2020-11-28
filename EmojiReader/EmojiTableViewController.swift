//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by Ann Yesip on 20.06.2020.
//  Copyright © 2020 Ann Yesip. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var objects = [
        Emoji(emoji: "🥰", name: "Love", description: "Let's love each other", isFavourite: false),
        Emoji(emoji: "⚽️", name: "Football", description: "Let's play football together", isFavourite: false),
        Emoji(emoji: "🐱", name: "Cat", description: "Cat is the cutest animal", isFavourite: false)
    
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
//верхняя панель title и edit
        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewEmojiTableViewController
        let emoji = sourceVC.emoji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade )
        }else{
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let newEmojiVC = navigationVC.topViewController as! NewEmojiTableViewController
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
    }

    // MARK: - Table view data source
    
//    колличество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
//    колличество ячеек в секциях
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }
    
//    настраиваем и возвращаем ячейку
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
//      из масива вытаскиваем элимент для конкретной ячейки
//      row номер строки для конкретной секции
        let object = objects[indexPath.row]
        cell.set(object: object)
        
        return cell
    }
    
//можем удалять ячейки. также это функция есть по умолчанию
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        
    }
    
    
//    при удалении ячейки в приложении удаляем ее и в object и в tableView(используем также анимацию при удалении)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
//    перетаскивание ячейки вверх-вниз
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
// с sourceIndexPath мы начали передвигать ячейку
// на destinationIndexPath мы переставили ячейку
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
//   экшн по свайпу влево. возвращается как массив, пишем функции чтобы вписать внутрь масива
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneActio(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
    
//    кнопка удаляет обьект. типо сделанно
    func doneActio(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark")
        return action
    }
//    like
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction{
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Like") {
            (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
        
        
    }
    
}
