//
//  ViewController.swift
//  swiftTest
//
//  Created by Mr_zhaohy on 16/3/30.
//  Copyright © 2016年 Mr_zhaohy. All rights reserved.
//

import UIKit

    let 宽 = UIScreen.mainScreen().bounds.size.width
    let 高 = UIScreen.mainScreen().bounds.size.height

    var barItem = UIButton()
    var _tableView = UITableView()
    var yes = NSMutableArray()
    var no = NSMutableArray()

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate {
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "3D Touch菜单定制"
        
        for yesIndes in use_array
        {
            yes.addObject(shortItems[yesIndes.integerValue])
        }
        
        for noIndes in no_use_array
        {
            no.addObject(shortItems[noIndes.integerValue])
        }
        
        barItem = UIButton(type: UIButtonType.System)
        barItem.setTitle("编辑", forState: UIControlState.Normal)
        barItem.setTitle("保存", forState: UIControlState.Selected)
        
        barItem.frame = CGRectMake(0, 0, 50, 50)
        
        barItem.addTarget(self, action: #selector(self.save), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barItem)
        
        _tableView = UITableView(frame: CGRectMake(0, 0, 宽, 高), style: UITableViewStyle.Grouped)
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.registerClass(UITableViewCell.classForKeyedArchiver(), forCellReuseIdentifier: "cell")
        self.view.addSubview(_tableView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func save()
    {
        barItem.selected = !barItem.selected
        
        _tableView.setEditing(barItem.selected, animated: true)
        
        print(barItem.selected)
        
        if barItem.selected == false
        {
            UIApplication.sharedApplication().shortcutItems = (yes as! [UIApplicationShortcutItem])
            
            NSUserDefaults.standardUserDefaults().setObject(use_array, forKey: "use")
            NSUserDefaults.standardUserDefaults().setObject(no_use_array, forKey: "no_use")
            NSUserDefaults.standardUserDefaults().setBool(yes.count <= 0 ? true : false, forKey: "isClose")
            UIAlertView(title: "", message: "保存成功", delegate: self, cancelButtonTitle: "确定").show()
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
        func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        print(sourceIndexPath,destinationIndexPath)
        
        if sourceIndexPath.section == destinationIndexPath.section
        {
            if sourceIndexPath.section == 0
            {
                var obj = yes[sourceIndexPath.row]
                yes.removeObjectAtIndex(sourceIndexPath.row)
                yes.insertObject(obj, atIndex: destinationIndexPath.row)
                
                obj = use_array[sourceIndexPath.row]
                use_array.removeObjectAtIndex(sourceIndexPath.row)
                use_array.insertObject(obj, atIndex: destinationIndexPath.row)
            }
            else
            {
                var obj = no[sourceIndexPath.row]
                no.removeObjectAtIndex(sourceIndexPath.row)
                no.insertObject(obj, atIndex: destinationIndexPath.row)
                
                obj = no_use_array[sourceIndexPath.row]
                no_use_array.removeObjectAtIndex(sourceIndexPath.row)
                no_use_array.insertObject(obj, atIndex: destinationIndexPath.row)
            }
            
        }
        else
        {
            if sourceIndexPath.section == 0
            {

                var obj = yes[sourceIndexPath.row]
                yes.removeObjectAtIndex(sourceIndexPath.row)
                no.insertObject(obj, atIndex: destinationIndexPath.row)
                
                obj = use_array[sourceIndexPath.row]
                use_array.removeObjectAtIndex(sourceIndexPath.row)
                no_use_array.insertObject(obj, atIndex: destinationIndexPath.row)
            }
            else if sourceIndexPath.section == 1
            {
                var obj = no[sourceIndexPath.row]
                no.removeObjectAtIndex(sourceIndexPath.row)
                yes.insertObject(obj, atIndex: destinationIndexPath.row)
                
                obj = no_use_array[sourceIndexPath.row]
                no_use_array.removeObjectAtIndex(sourceIndexPath.row)
                use_array.insertObject(obj, atIndex: destinationIndexPath.row)
                
                if yes.count > 4
                {
                    var objc = yes.lastObject
                    yes.removeLastObject()
                    no.insertObject(objc!, atIndex: 0)
                    
                    objc = use_array.lastObject
                    use_array.removeLastObject()
                    no_use_array.insertObject(objc!, atIndex: 0)
                }
            }
        }
        
        tableView.reloadData()
        
//        tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0,length: 2)), withRowAnimation: UITableViewRowAnimation.Middle)


    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "包含(max:4,min:0),为0时关闭" : "不包含"
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? yes.count : no.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            var item = UIApplicationShortcutItem(type: "", localizedTitle: "")
            item = yes[indexPath.row] as! UIApplicationShortcutItem
            cell.textLabel?.text = String(item.localizedTitle)
        }
        else
        {
            var item = UIApplicationShortcutItem(type: "", localizedTitle: "")
            item = no[indexPath.row] as! UIApplicationShortcutItem
            cell.textLabel?.text = String(item.localizedTitle)
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print(indexPath.row)
    }
}

