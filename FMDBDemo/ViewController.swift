//
//  ViewController.swift
//  FMDBDemo
//
//  Created by leergou on 16/8/2.
//  Copyright © 2016年 WhiteHouse. All rights reserved.
//

import UIKit

/*
    1. 这样在表中添加字段, createtime, text 类型, 在底部 DEFAULT 中输入 ((datetime('now','localetime')))

    "createtime" TEXT DEFAULT (datetime('now','localtime')),
    
    功能: 在添加值时,会自动生成该字段,记录数据添加的时间

*/

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         导入库 lisqlite3.tbd, 创建桥接文件, 在桥接文件中 导入 import "FMDB.h"
        */
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        insert()
//        update()
//     delete()
//        select1()
        select2()
    }
    
    // 查询2
    func select2(){
        
        // 准备 sql
        var sql = "SELECT * FROM T_Person\n"
        sql += "ORDER BY age DESC\n" // 查询后按将序返回 升序好像是 ASC???
        sql += "LIMIT 1" // 限制查询的个数
        
        // 执行
        SQLmanager.sharedTools.queue.inDatabase { (db) -> Void in
            let resultSet = db.executeQuery(sql, withArgumentsInArray: nil)
            
            while resultSet.next(){
                
                // 遍历列数
                for index in 0..<resultSet.columnCount(){
                    let key = resultSet.columnNameForIndex(index)
                    let value = resultSet.objectForColumnIndex(index)
                    print(key, value)
                    print("*********************")
                }
            }
        }
    }
    
    
    // 查询1
    func select1(){
        
        // 准备 sql
        let sql = "SELECT * FROM T_Person"
        // 执行 sql
        SQLmanager.sharedTools.queue.inDatabase { (db) -> Void in
            
            let resultSet = db.executeQuery(sql, withArgumentsInArray: nil)
            // 循环获取数据
            while resultSet.next(){
                
                // id 
                let id = resultSet.intForColumn("id")
                // 名字
                let name = resultSet.stringForColumn("name")
                // 年龄
                let age = resultSet.intForColumn("age")
                // 身高
                let height = resultSet.doubleForColumn("height")
                
                print("id=\(id)名字=\(name)年龄=\(age)身高=\(height)")
                print("================")
                
            }
            // 循环获取数据
        
        }
    }
    
    
    // 删除数据
    func delete(){
        // 准备 sql
        let sql = "DELETE FROM T_Person WHERE id=2"
        // 执行 sql
        SQLmanager.sharedTools.queue.inDatabase { (db) -> Void in
            let result = db.executeUpdate(sql, withArgumentsInArray: nil)
            
            if result {
                print("删除数据成功")
            } else {
                print("删除数据失败")
            }
        }
        
    }
    
    
    // 修改数据
    func update(){
        
        // 准备 sql 语句
        let sql = "UPDATE T_Person SET name=?,age=?,height=? WHERE id=2"
        
        // 执行 sql
        SQLmanager.sharedTools.queue.inDatabase { (db) -> Void in
            let result = db.executeUpdate(sql, withArgumentsInArray: ["小万把",100,200])
            
            if result  {
            print("修改数据成功")
            } else {
                print("修改数据失败")
            }
        }
    }

    
    // 插入数据
    func insert(){
        
        // 准备 sql 语句
        let sql = "INSERT INTO T_Person (name,age,height) VALUES (?,?,?)"
        // 执行 sql
        SQLmanager.sharedTools.queue.inDatabase { (db) -> Void in
            let result = db.executeUpdate(sql, withArgumentsInArray:
            ["老王",18,150])
            
            if result {
                print("添加成功")
            } else {
                print("添加失败")
            }
            
            
        }
    }


}

