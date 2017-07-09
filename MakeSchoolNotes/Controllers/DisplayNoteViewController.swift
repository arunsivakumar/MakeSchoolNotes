//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

import RealmSwift

class DisplayNoteViewController: UIViewController {
    
    var note: Note?

    @IBOutlet weak var noteContentTextView: UITextView!
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = note {
            // 2
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            // 3
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "Cancel" {
                print("Cancel button tapped")
            } else if identifier == "Save" {
                let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
                if let note = note {
                    
                    // 1
                    let newNote = Note()
                    newNote.title = noteTitleTextField.text ?? ""
                    newNote.content = noteContentTextView.text ?? ""
                    RealmHelper.updateNote(note, newNote: newNote)
//                    // 1
//                    note.title = noteTitleTextField.text ?? ""
//                    note.content = noteContentTextView.text ?? ""
//                    // 2
//                    listNotesTableViewController.tableView.reloadData()
                } else {
                    
                    // if note does not exist, create new note
                    let note = Note()
                    note.title = noteTitleTextField.text ?? ""
                    note.content = noteContentTextView.text ?? ""
                    note.modificationTime = NSDate()
                    // 2
                    RealmHelper.addNote(note)
//                    // 3
//                    let newNote = Note()
//                    newNote.title = noteTitleTextField.text ?? ""
//                    newNote.content = noteContentTextView.text ?? ""
//                    newNote.modificationTime = NSDate()
//                    listNotesTableViewController.notes.append(newNote)
                }
                // 3
                listNotesTableViewController.notes = RealmHelper.retrieveNotes()
            }
        }
    }
}
