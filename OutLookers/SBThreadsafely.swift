//
//  SBThreadsafely.swift
//  SBPhotoPickerDemo
//
//  Created by 宋碧海 on 16/8/31.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import Foundation

func dispatch_async_safely_to_main_queue(block: ()->()) {
    dispatch_async_safely_to_queue(dispatch_get_main_queue(), block)
}

func dispatch_async_safely_to_queue(queue: dispatch_queue_t, _ block: ()->()) {
    if queue === dispatch_get_main_queue() && NSThread.isMainThread() {
        block()
    } else {
        dispatch_async(queue) {
            block()
        }
    }
}

//swift没有Objective-C里的@synchronized, 自己实现一个
func synchronized(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}