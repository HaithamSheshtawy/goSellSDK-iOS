//
//  Process+Additions.swift
//  goSellSDK
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import struct	CoreGraphics.CGGeometry.CGRect
import struct	TapAdditionsKit.TypeAlias

extension Process: ProcessInterface {
	
	// MARK: - Internal -
	// MARK: Properties
	
	internal var process: Process {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.process
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.process
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal var addressInputHandlerInterface: AddressInputHandlerInterface {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.addressInputHandler
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.addressInputHandler
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal var viewModelsHandlerInterface: ViewModelsHandlerInterface {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.viewModelsHandler
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.viewModelsHandler
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal var currencySelectionHandlerInterface: CurrencySelectionHandlerInterface {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.currencySelectionHandler
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.currencySelectionHandler
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal var cardScannerHandlerInterface: CardScannerHandlerInterface {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.cardScannerHandler
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.cardScannerHandler
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal var dataManagerInterface: DataManagerInterface {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.dataManager
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.dataManager
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal var webPaymentHandlerInterface: WebPaymentHandlerInterface {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.webPaymentHandler
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.webPaymentHandler
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal var buttonHandlerInterface: TapButtonHandlerInterface {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.buttonHandler
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.buttonHandler
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	// MARK: Methods
	
	internal func showPaymentController() {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			payment.showPaymentController()
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			cardSaving.showPaymentController()
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func showLoadingController(_ coveringHeader: Bool) -> LoadingViewController {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.showLoadingController(coveringHeader)
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.showLoadingController(coveringHeader)
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func closePayment(with status: PaymentStatus, fadeAnimation: Bool, force: Bool, completion: TypeAlias.ArgumentlessClosure?) {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.closePayment(with: status, fadeAnimation: fadeAnimation, force: force, completion: completion)
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.closePayment(with: status, fadeAnimation: fadeAnimation, force: force, completion: completion)
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func paymentOptionsControllerKeyboardLayoutFinished() {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			payment.paymentOptionsControllerKeyboardLayoutFinished()
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			cardSaving.paymentOptionsControllerKeyboardLayoutFinished()
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func startPayment(with paymentOption: PaymentOptionCellViewModel) {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			payment.startPayment(with: paymentOption)
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func openOTPScreen(with phoneNumber: String, for paymentOption: PaymentOption) {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			payment.openOTPScreen(with: phoneNumber, for: paymentOption)
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func loadingControllerFrame(coveringHeader: Bool) -> CGRect {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			return payment.loadingControllerFrame(coveringHeader: coveringHeader)
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			return cardSaving.loadingControllerFrame(coveringHeader: coveringHeader)
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func paymentSuccess(with chargeOrAuthorize: ChargeProtocol) {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			payment.paymentSuccess(with: chargeOrAuthorize)
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func paymentFailure(with status: ChargeStatus, chargeOrAuthorize: ChargeProtocol, error: TapSDKError?) {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			payment.paymentFailure(with: status, chargeOrAuthorize: chargeOrAuthorize, error: error)
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func openPaymentURL(_ url: URL, for paymentOption: PaymentOption, binNumber: String?) {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			payment.openPaymentURL(url, for: paymentOption, binNumber: binNumber)
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			cardSaving.openPaymentURL(url, for: paymentOption, binNumber: binNumber)
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	internal func continuePaymentWithCurrentChargeOrAuthorize<T>(with identifier: String, of type: T.Type, paymentOption: PaymentOption, loader: LoadingViewSupport?, retryAction: @escaping TypeAlias.ArgumentlessClosure, alertDismissButtonClickHandler: TypeAlias.ArgumentlessClosure?) where T : ChargeProtocol {
		
		if let payment: PaymentImplementation = self.wrappedImplementation.implementation() {
			
			payment.continuePaymentWithCurrentChargeOrAuthorize(with: identifier, of: type, paymentOption: paymentOption, loader: loader, retryAction: retryAction, alertDismissButtonClickHandler: alertDismissButtonClickHandler)
		}
		else if let cardSaving: CardSavingImplementation = self.wrappedImplementation.implementation() {
			
			cardSaving.continuePaymentWithCurrentChargeOrAuthorize(with: identifier, of: type, paymentOption: paymentOption, loader: loader, retryAction: retryAction, alertDismissButtonClickHandler: alertDismissButtonClickHandler)
		}
		else {
			
			fatalError("Wrong implementation.")
		}
	}
	
	// MARK: - Private -
	
	private typealias PaymentImplementation = Implementation<PaymentClass>
	private typealias CardSavingImplementation = Implementation<CardSavingClass>
}
