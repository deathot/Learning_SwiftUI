////
////  BottomSheetHelper.swift
////  FindMe
////
////  Created by deathot on 12/24/24.
////
//
//import SwiftUI
//
//extension View {
//    
//    @ViewBuilder
//    
//    func bottomMaskForSheet(_ height: CGFloat = 49) -> some View {
//        self
//            .background(SheetRootViewFinder(height: height))
//    }
//    
//}
//
//// Helpers
//fileprivate struct SheetRootViewFinder: UIViewRepresentable {
//    
//    var height: CGFloat
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator()
//    }
//    
//    func makeUIView(context: Context) -> UIView {
//        return .init()
//    }
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        
//    }
//    
//    class Coordinator: NSObject {
//        var isMasked: Bool = false
//    }
//    
//}
//
//#Preview {
//    Main0()
//}
