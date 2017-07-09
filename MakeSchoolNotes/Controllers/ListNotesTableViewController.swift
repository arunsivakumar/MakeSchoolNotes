//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    
    var notes:Results<Note>!{
        didSet {
            tableView.reloadData()
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    notes = RealmHelper.retrieveNotes()
  }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 1
        if let identifier = segue.identifier {
            // 2
            if identifier == "displayNote" {
                // 3
//                print("Transitioning to the Display Note View Controller")
                
                
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let note = notes[indexPath.row]
                // 3
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                // 4
                displayNoteViewController.note = note
            }else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
        
    }
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
    
    // 1
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // 2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 3
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath)  as! ListNotesTableViewCell
        
            // 1
        let row = indexPath.row
        
        // 2
        let note = notes[row]
        
        // 3
        cell.noteTitleLabel.text = note.title
        
        // 4
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        
        // 5
        return cell
    }
    
    // 1
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 2
        if editingStyle == .Delete {
            // 3
//            notes.removeAtIndex(indexPath.row)
            //1
            RealmHelper.deleteNote(notes[indexPath.row])
            //2
            notes = RealmHelper.retrieveNotes()
            // 4
//            tableView.reloadData()
        }
    }
  
}