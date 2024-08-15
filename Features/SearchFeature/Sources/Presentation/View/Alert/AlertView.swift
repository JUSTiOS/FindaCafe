import SwiftUI

public enum AlertButtonType {
    case confirm
    case cancel
}

public struct AlertButtonView: View {
    public typealias Action = () -> ()
    
    @Binding public var isPresented: Bool
    
    public var buttonTitle: String = "확인"
    
    public var buttonColor: Color = .white
    
    public var buttonBackgroundColor: Color = .black
    
    public var action: Action
    
    public var type: AlertButtonType
    
    public init(type: AlertButtonType, isPresented: Binding<Bool>, action: @escaping Action) {
        self._isPresented = isPresented
        
        switch type {
        case .confirm:
            self.buttonTitle = "확인"
            self.buttonColor = .white
            self.buttonBackgroundColor = .black
        case .cancel:
            self.buttonTitle = "취소"
            self.buttonColor = .white
            self.buttonBackgroundColor = .gray
        }
        self.action = action
        self.type = type
    }
    
    public var body: some View {
        Button {
            self.isPresented = false
            
            action()
        } label: {
            Text(buttonTitle)
                .foregroundStyle(self.buttonColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(self.buttonBackgroundColor)
                .cornerRadius(10)
        }
    }
}

public struct AlertView: View {
    public var content: String = ""
    public let confirmButton: AlertButtonView
    public let cancelButton: AlertButtonView
    
    public init(
        content: String,
        confirmButton: () -> AlertButtonView,
        cancelButton: () -> AlertButtonView
    ) {        self.content = content
        self.confirmButton = confirmButton()
        self.cancelButton = cancelButton()
    }
    
    public var body: some View {
        ZStack {
            Color.black
                .opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                VStack {
                    Text(self.content)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18))
                        .bold()
                }
                .frame(height: 80)
                .padding([.leading, .trailing], 10)
                
                HStack {
                    self.cancelButton
                    self.confirmButton
                }
                .frame(height: 50)
                .padding([.leading, .trailing], 10)
            }
            .frame(width: 300, height: 150)
            .background(.white)
            .cornerRadius(15)
        }
        .background(ClearBackground())
    }
}

public struct AlertModifier: ViewModifier {
    @Binding var isPresent: Bool
    
    let alert: AlertView
    
    public func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresent) {
                alert
            }
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
    }
}

extension View {
    public func alert(isPresented: Binding<Bool>, alert: @escaping () -> AlertView) -> some View {
        return modifier(AlertModifier(isPresent: isPresented, alert: alert()))
    }
}
