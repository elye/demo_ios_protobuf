
import SwiftUI

struct ContentView: View {
    @State var mode: ModeOption.Mode = .none
    
    @State var info = ModeOption.with {
        $0.mode = .none
    }
    
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
                info = ModeOption.with { $0.mode = self.mode }
            } label: { Text("Saved To File") }
            Button {
                mode = info.mode
            } label: { Text("Read To File") }
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
