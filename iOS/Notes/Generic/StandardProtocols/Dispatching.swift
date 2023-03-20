//  Created by Denis Malykh on 20.03.2023.

import Foundation

public protocol DispatchingQueue {
    func async(_ work: @escaping () -> Void)
}

extension DispatchQueue: DispatchingQueue {
    public func async(_ work: @escaping () -> Void) {
        self.async(execute: work)
    }
}

class FakeDispatchingQueue: DispatchingQueue {
    private(set) var pendingAsyncs = [() -> Void]()

    func async(_ work: @escaping () -> Void) {
        pendingAsyncs.append(work)
    }

    func executeAsyncs() {
        while !pendingAsyncs.isEmpty {
            let pending = pendingAsyncs
            pendingAsyncs.removeAll()
            pending.forEach { $0() }
        }
    }
}
