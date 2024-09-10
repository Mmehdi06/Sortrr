import SwiftUI

struct AppMenu: View {
    @ObservedObject var sorter: Sorter
    @State private var isSorting: Bool = false  // To handle sorting state
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            // Header Section
            Text("SORTRR.")
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            
//    Sort Button with enhanced styling and loading state
            Button(action: {
                isSorting = true
                sorter.sortDownloads()
                
                // Simulate sorting delay for demo purposes
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isSorting = false
                }
            }) {
                if isSorting {
                    // Progress view while sorting
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.5)
                        .padding(.trailing, 5)
                    
                    
                } else {
                    Label("Sort Downloads", systemImage: "arrow.up.arrow.down.circle.fill")
                        .foregroundColor(.white)
                                            
                    
                                    
                    
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.8), lineWidth: 1)
            )
            .padding(.bottom, 10)
            
            
        
            
      
    
            
            
            Divider()

            // Quit Button with enhanced styling
            Button(action: {
                NSApplication.shared.terminate(nil)
            }) {
                Label("Quit App", systemImage: "xmark.circle")
                    .foregroundColor(.white)
                    
            }.frame(maxWidth: .infinity)
                .padding(8)
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.8), lineWidth: 1)
                )
            
            
        }
        .padding()
        .frame(width: 260)
        .background(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.1), .gray.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.all, 10)
    }
}

#Preview {
    AppMenu(sorter: Sorter())
}
