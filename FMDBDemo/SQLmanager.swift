//
//  SQLmanager.swift
//  FMDBDemo
//
//  Created by leergou on 16/8/2.
//  Copyright © 2016年 WhiteHouse. All rights reserved.
//

import UIKit

// 数据库名称
private let dbName = "my.db"

class SQLmanager: NSObject {
    
    // 全局访问点
    static let sharedTools: SQLmanager = SQLmanager()
    
    let queue: FMDatabaseQueue
    
    override init() {
        // 路径
        let path = ((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString).stringByAppendingPathComponent(dbName))
        
        // 打印一下路径
        print(path)
        
        // 核心对象
        queue = FMDatabaseQueue(path: path)
        
        // 调用 super.init(),要放在 创建表格之前,否则会提示 有变量没有初始化
        super.init()
        
        // 创建表
        createTabel()
    }
    
    
    func createTabel(){
        // 要执行的 sql 语句,保存的路径
        let file = NSBundle.mainBundle().pathForResource("db.sql", ofType: nil)!
        
        // 准备 sql
        let sql = try! String(contentsOfFile: file)
        
        // 创建表
        queue.inDatabase { (db) -> Void in
            // 执行 sql 
            let result = db.executeStatements(sql)
            
            if result {
                print("创建成功")
            } else {
                print("创建失败")
            }
        }
        
    }
    
    

}












