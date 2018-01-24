//
//  ViewController.swift
//  FullCoreDataExample
//
//  Created by MOHIT SINGH on 24/01/18.
//  Copyright © 2018 MOHIT SINGH. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // print("----Insert Data----")
        self.insertData()
        print("----Data after insert----")
        self.fetchData()
        
       // print("----Update Data----")
        self.updateData()
        print("----Data after Update----")
        self.fetchData()
        
        //print("----Delete Data----")
        self.deleteData()
        print("----Data after Delete----")
        self.fetchData()
        
        
        
    }
    
    func insertData()
    {
        
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: DatabaseController.getContext()) as! Employee
        employee.id = "2"
        employee.name = "Mohit Singh"
        employee.address = "India"
        employee.salary = 100000.0
        DatabaseController.saveContext()
    }
    
    func fetchData()
    {
        let fetchRequest:NSFetchRequest<Employee> = Employee.fetchRequest()
        do{
            
            let searchResult = try DatabaseController.getContext().fetch(fetchRequest)
            for result in searchResult as [Employee]
            {
                print("Employee id : \(String(describing: result.id!))\nEmployee Name : \(String(describing: result.name!))\nEmployee Address : \(String(describing: result.address!))\nEmployee Salary : \(result.salary)\n")
            }
        }
        catch
        {
            print("Error: \(error)")
        }
        
    }
    func updateData()
    {
        let fetchRequest:NSFetchRequest<Employee> = Employee.fetchRequest()
        let predicate = NSPredicate(format: "id==2")
        fetchRequest.predicate = predicate
        do
        {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            for i in 0..<searchResults.count{
            let employee = searchResults[i]
                employee.setValue(54321.0, forKey: "salary")
            }
            DatabaseController.saveContext()
        }
        catch
            {
                print(error)
            }
        
    }
    func deleteData()
    {
        let context = DatabaseController.getContext()
        let coord = DatabaseController.getContext().persistentStoreCoordinator
        let fetchRequest:NSFetchRequest<Employee> = Employee.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==2")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as!
            NSFetchRequest<NSFetchRequestResult>)
        do {
            try coord?.execute(deleteRequest, with: context)
            
        } catch let error as NSError {
            debugPrint(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

