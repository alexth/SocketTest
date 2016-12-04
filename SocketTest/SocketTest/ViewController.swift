//
//  ViewController.swift
//  SocketTest
//
//  Created by Alex Golub on 12/3/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let socket = SocketIOClient(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .forcePolling(true)])
        socket.on("currentAmount") {data, ack in
            if let cur = data[0] as? Double {
                socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                    socket.emit("update", ["amount": cur + 2.50])
                }
                ack.with("Got your currentAmount", "dude")
            }
        }
        socket.connect()
    }
}
