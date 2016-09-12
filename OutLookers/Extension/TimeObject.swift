//
//  TimeObject.swift
//  jizhi
//
//  Created by C on 15/9/23.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import Foundation

class TimeObject {
    class func timeWithOrderUnit() -> String {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMddHHmmss"
        let dateString = formatter.stringFromDate(date)
        return dateString
    }
    
    class func timeWithPayTime() -> String {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateString = formatter.stringFromDate(date)
        return dateString
    }
}

typealias Task = (cancel: Bool) -> ()

func delay(time: NSTimeInterval, task:() -> ()) -> Task?{
    func dispatch_later(block: () -> ()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
    }
    var closure: dispatch_block_t? = task
    var result: Task?
    let delayClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if cancel == false {
                dispatch_async(dispatch_get_main_queue(), internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    result = delayClosure
    
    dispatch_later { () -> () in
        if let delayClosure = result {
            delayClosure(cancel: false)
        }
    }
    return result
}
func cancel(task: Task?){
    task?(cancel: true)
}

class SKDevice {
    class func getIFAddresses() -> [String]? {
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs> = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                let flags = Int32(ptr.memory.ifa_flags)
                var addr = ptr.memory.ifa_addr.memory
                
                // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        
                        // Convert interface address to a human readable string:
                        var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String.fromCString(hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr.memory.ifa_next
            }
            // For each interface ...
//            for (var ptr = ifaddr; ptr != nil; ptr = ptr.memory.ifa_next) {
//                let flags = Int32(ptr.memory.ifa_flags)
//                var addr = ptr.memory.ifa_addr.memory
//                
//                // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
//                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
//                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
//                        
//                        // Convert interface address to a human readable string:
//                        var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
//                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
//                            nil, socklen_t(0), NI_NUMERICHOST) == 0) {
//                                if let address = String.fromCString(hostname) {
//                                    addresses.append(address)
//                                }
//                        }
//                    }
//                }
//            }
            freeifaddrs(ifaddr)
        }
        
        return addresses
    }
}
