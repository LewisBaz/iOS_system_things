//: [Previous](@previous)

import Foundation

// Функция для создания файла и записи в него
func createAndModifyFile(atPath path: String) {
    let fileManager = FileManager.default
    
    // Создаем файл, если он не существует
    if !fileManager.fileExists(atPath: path) {
        fileManager.createFile(atPath: path, contents: nil, attributes: nil)
    }
    
    // Записываем данные в файл через 2 секунды
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
        let data = "Hello, World!".data(using: .utf8)!
        if let fileHandle = FileHandle(forWritingAtPath: path) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
            fileHandle.closeFile()
        }
    }
}

// Путь к файлу
let filePath = "/tmp/example.txt"

// Создаем и модифицируем файл
createAndModifyFile(atPath: filePath)

// Создаем дескриптор файла
let fileDescriptor = open(filePath, O_EVTONLY)

guard fileDescriptor != -1 else {
    fatalError("Unable to open file")
}

// Создаем очередь для обработки событий
let queue = DispatchQueue(label: "com.example.fileWatchQueue")

// Создаем DispatchSource для файлового дескриптора
let source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: fileDescriptor, eventMask: .write, queue: queue)

// Устанавливаем обработчик события
source.setEventHandler {
    print("File was modified!")
}

// Устанавливаем обработчик завершения
source.setCancelHandler {
    close(fileDescriptor)
}

// Запускаем источник
source.resume()

// Даем время для наблюдения за изменениями файла (10 секунд в данном примере)
DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    source.cancel()
    print("Stopped watching the file")
}

// Запускаем основной цикл для предотвращения завершения программы
RunLoop.main.run()


//: [Next](@next)
