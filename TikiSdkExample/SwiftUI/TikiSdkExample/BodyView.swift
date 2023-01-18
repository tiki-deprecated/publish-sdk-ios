import SwiftUI
import TikiSdk

struct BodyView: View {
    
    @EnvironmentObject var appModel: TikiSdkExampleAppModel
    
    var body: some View {
        VStack{
            Text("Body")
            TextEditor(text: $appModel.stream.body)
                       .frame(height: 600, alignment: .leading)
                       .cornerRadius(10, antialiased: true)
                       .foregroundColor(.black)
                       .font(.body)
                       .padding()
                       .fixedSize(horizontal: false, vertical: true)
                       .multilineTextAlignment(.leading)
        }.background(Color(UIColor.systemBackground))
    }
}
