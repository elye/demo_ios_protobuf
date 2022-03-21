
import SwiftUI

struct ContentView: View {
    @State var mode: ModeOption.Mode = .none
    
    let protoDataURL = URL(
        fileURLWithPath: "myfile.pbd",
        relativeTo: FileManager.documentDirectoryURL
    )
    
    var body: some View {
        VStack {
            Menu {
                ForEach(ModeOption.Mode.allCases, id: \.self) { mode in
                    Button {
                        self.mode = mode
                    } label: { Text(mode.description) }
                }
            } label: {
                Text(mode.description)
                    .frame(width: 150)
                    .border(Color.red)
            }
            Button {
                do {
                    let object = ModeOption.with { $0.mode = self.mode }
                    let myData = try Data(_: object.serializedData())
                    try myData.write(to: protoDataURL)
                    print("Saved To File: \(mode.description)")
                } catch {
                    print("Saved To File Failed")
                }
            } label: { Text("Saved To File") }
            Button {
                do {
                    let myData = try Data(contentsOf: protoDataURL)
                    let modeOption = try ModeOption(serializedData: myData)
                    mode = modeOption.mode
                    print("Read From File: \(mode.description)")
                } catch {
                    print("Read From File Failed")
                }
            } label: { Text("Read From File") }
        }
    }
}

// Manually add String here due to Swift Proto file don't support
// Enum to String yet.
extension ModeOption.Mode: CustomStringConvertible {
    var description: String {
        let description: String
        switch self {
        case .none: description = "NONE"
        case .ecstatic: description = "ECSTATIC"
        case .happy: description = "HAPPY"
        case .sad: description = "SAD"
        case .depressed: description = "DEPRESSED"
        case .UNRECOGNIZED: description = "UNRECOGNIZED"
        }
        return description
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
