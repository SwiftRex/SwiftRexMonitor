import Foundation

extension Data {
    init(reading input: InputStream) {
        self.init()
        input.open()

        let bufferSize = 1_024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while input.hasBytesAvailable {
            let read = input.read(buffer, maxLength: bufferSize)
            if read < 0 { break }

            append(buffer, count: read)
        }
        buffer.deallocate()

        input.close()
    }
}
