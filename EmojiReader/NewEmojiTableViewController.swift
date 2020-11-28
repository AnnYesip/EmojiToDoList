//
//  NewEmojiTableViewController.swift
//  EmojiReader
//
//  Created by Ann Yesip on 29.06.2020.
//  Copyright © 2020 Ann Yesip. All rights reserved.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateSabeButtonState()
    }
    
//    cостояние кнопки save
    private func updateSabeButtonState(){
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
// обновляем интерфейс посте изменения существующих ячеек
    private func updateUI() {
        emojiTextField.text = emoji.emoji
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description
        
    }
    
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSabeButtonState()
    }
//    срабатывает когда перемещаемся со второго экрана на первый
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        
        let emoji = emojiTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, description: description, isFavourite: self.emoji.isFavourite)
    }
    

    
}
