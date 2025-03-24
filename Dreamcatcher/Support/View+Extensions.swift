//
//  View+Extensions.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 24/03/25.
//

import SwiftUI

struct BackButton: ToolbarContent {
	@Environment(\.dismiss) private var dismiss
	@State private var isBacked = false
	
	var body: some ToolbarContent {
		ToolbarItem(placement: .topBarLeading) {
			Button {
				dismiss()
				isBacked.toggle()
			} label: {
				Image(systemName: "chevron.left")
			}
			.sensoryFeedback(.impact, trigger: isBacked)
		}
	}
}

struct DisableSwipeBackView: UIViewControllerRepresentable {
	typealias UIViewControllerType = DisableSwipeBackViewController
	
	func makeUIViewController(context: Context) -> UIViewControllerType {
		UIViewControllerType()
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
	}
}

class DisableSwipeBackViewController: UIViewController {
	override func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)
		if let parent = parent?.parent,
		   let navigationController = parent.navigationController,
		   let interactivePopGestureRecognizer = navigationController.interactivePopGestureRecognizer {
			navigationController.view.removeGestureRecognizer(interactivePopGestureRecognizer)
		}
	}
}

struct RegainSwipeBackView: UIViewControllerRepresentable {
	typealias UIViewControllerType = RegainSwipeBackViewController
	
	func makeUIViewController(context: Context) -> UIViewControllerType {
		UIViewControllerType()
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		
	}
}

class RegainSwipeBackViewController: UIViewController {
	override func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)
		if let parent = parent?.parent,
		   let navigationController = parent.navigationController {
			navigationController.interactivePopGestureRecognizer?.isEnabled = true
		}
	}
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
	override open func viewDidLoad() {
		super.viewDidLoad()
		interactivePopGestureRecognizer?.delegate = self
	}
	
	public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return viewControllers.count > 1
	}
}

extension View {
	public func disableSwipeBack() -> some View {
		self.background(
			DisableSwipeBackView()
		)
	}
	
	public func regainSwipeBack() -> some View {
		self.background(
			RegainSwipeBackView()
		)
	}
}
