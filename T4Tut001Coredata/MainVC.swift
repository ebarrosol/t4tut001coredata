//
//  MainVC.swift
//  T4Tut001Coredata
//
//  Created by Efren Alejandro Barroso Llanes on 15/06/15.
//  Copyright (c) 2015 EBL. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController
{

    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var nvoelemento : Lista? = nil
    
    
    @IBOutlet var alimento: UITextField!
    @IBOutlet var nota: UITextField!
    @IBOutlet var cantidad: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if( nvoelemento != nil )
        {
            alimento.text = nvoelemento?.elemento
            nota.text = nvoelemento?.nota
            cantidad.text = nvoelemento?.cantidad
        }
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func guardar(sender: UIBarButtonItem)
    {
        if( nvoelemento == nil )
        {
            agregarElemento()
        }
        else
        {
            editarElemento()
        }
        cerrarVC()
    }
    
    @IBAction func cancelar(sender: UIBarButtonItem)
    {
        cerrarVC()
    }
    
    func cerrarVC()
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func agregarElemento()
    {
        let context = self.context
        let ent = NSEntityDescription.entityForName("Lista", inManagedObjectContext: context!)
        let nvoelemento = Lista(entity: ent!, insertIntoManagedObjectContext: context)
        
        nvoelemento.elemento = alimento.text
        nvoelemento.nota = nota.text
        nvoelemento.cantidad = cantidad.text
        
        context?.save(nil)
        
    }
    
    func editarElemento()
    {
        nvoelemento!.elemento = alimento.text
        nvoelemento!.nota = nota.text
        nvoelemento!.cantidad = cantidad.text
        
        context?.save(nil)
    }

}

