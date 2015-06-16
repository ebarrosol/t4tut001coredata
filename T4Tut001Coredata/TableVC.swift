//
//  TableVC.swift
//  T4Tut001Coredata
//
//  Created by Efren Alejandro Barroso Llanes on 15/06/15.
//  Copyright (c) 2015 EBL. All rights reserved.
//

import UIKit
import CoreData

class TableVC: UITableViewController, NSFetchedResultsControllerDelegate
{

    let context : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    var frc : NSFetchedResultsController = NSFetchedResultsController()
    
    func getNSFetchedResultsController() -> NSFetchedResultsController
    {
        frc = NSFetchedResultsController(fetchRequest: listaFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func listaFetchRequest() -> NSFetchRequest
    {
        let fecthRequest = NSFetchRequest(entityName: "Lista")
        let sortDescriptor = NSSortDescriptor(key: "elemento", ascending: true)
        fecthRequest.sortDescriptors = [sortDescriptor]
        return fecthRequest
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        getNSFetchedResultsController()
        
        frc.delegate = self
        frc.performFetch(nil)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return (frc.sections?.count)!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return (frc.sections?[section].numberOfObjects)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        let lista = frc.objectAtIndexPath(indexPath) as! Lista
        
        cell.textLabel?.text = lista.elemento
        cell.detailTextLabel?.text = "Cantidad: \(lista.cantidad) - \(lista.nota)."
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let managedobject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        context.deleteObject(managedobject)
        context.save(nil)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "edit")
        {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController : MainVC = segue.destinationViewController as! MainVC
            let nvoelemento : Lista = frc.objectAtIndexPath(indexPath!) as! Lista
            itemController.nvoelemento = nvoelemento
        }
        else
        {
            
        }
    }

}
