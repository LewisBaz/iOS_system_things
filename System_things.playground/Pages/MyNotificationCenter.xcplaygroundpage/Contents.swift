import Foundation

final class MyNotificationCenter {
    static let shared = MyNotificationCenter()

    private var observers: [String: [(AnyObject, Selector)]] = [:]
    private let queue = DispatchQueue(label: "com.myapp.mynotificationcenter", attributes: .concurrent)

    private init() {}

    func addObserver(_ observer: AnyObject, selector: Selector, name: String) {
        queue.async(flags: .barrier) {
            if self.observers[name] != nil {
                self.observers[name]?.append((observer, selector))
            } else {
                self.observers[name] = [(observer, selector)]
            }
        }
    }

    func removeObserver(_ observer: AnyObject, name: String) {
        queue.async(flags: .barrier) {
            if var observerList = self.observers[name] {
                observerList.removeAll { $0.0 === observer }
                self.observers[name] = observerList.isEmpty ? nil : observerList
            }
        }
    }

    func post(name: String, userInfo: [AnyHashable: Any]? = nil) {
        queue.async {
            if let observerList = self.observers[name] {
                for (observer, selector) in observerList {
                    DispatchQueue.main.async {
                        _ = observer.perform(selector, with: userInfo)
                    }
                }
            }
        }
    }
}

class MyObserver {
    init() {
        MyNotificationCenter.shared.addObserver(self, selector: #selector(handleNotification(_:)), name: "MyNotification")
    }

    deinit {
        MyNotificationCenter.shared.removeObserver(self, name: "MyNotification")
    }

    @objc func handleNotification(_ userInfo: [AnyHashable: Any]?) {
        print("Received notification with userInfo: \(String(describing: userInfo))")
    }
}

let observer = MyObserver()
MyNotificationCenter.shared.post(name: "MyNotification", userInfo: ["key": "value"])

