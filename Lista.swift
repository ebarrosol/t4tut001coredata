//
//  Lista.swift
//  T4Tut001Coredata
//
//  Created by Efren Alejandro Barroso Llanes on 15/06/15.
//  Copyright (c) 2015 EBL. All rights reserved.
//

import Foundation
import CoreData

@objc(Lista)

class Lista: NSManagedObject
{
    @NSManaged var elemento: String
    @NSManaged var nota: String
    @NSManaged var cantidad: String

}
