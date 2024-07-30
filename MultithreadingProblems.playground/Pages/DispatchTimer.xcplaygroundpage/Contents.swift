//: [Previous](@previous)

import Foundation

// Создаем очередь для таймера
let timerQueue = DispatchQueue(label: "com.example.timerQueue")

// Создаем DispatchSourceTimer
let timer = DispatchSource.makeTimerSource(queue: timerQueue)

// Устанавливаем таймер на выполнение каждые 2 секунды с начальной задержкой в 1 секунду
timer.schedule(deadline: .now() + 1.0, repeating: 2.0)

// Устанавливаем обработчик события для таймера
timer.setEventHandler {
    print("Timer fired at \(Date())")
}

// Запускаем таймер
timer.resume()

// Даем время для работы таймера (10 секунд в данном примере)
DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    // Останавливаем таймер
    timer.cancel()
    print("Timer stopped")
}

// Запускаем основной цикл для предотвращения завершения программы
RunLoop.main.run()


//: [Next](@next)
