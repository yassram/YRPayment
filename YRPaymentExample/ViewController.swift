//
//  ViewController.swift
//  YRPaymentExample
//
//  Created by Yassir RAMDANI on 6/23/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit
import YRPayment

class ViewController: UIViewController {
    var payment: YRPayment!
    var card: YRPaymentCreditCard!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Creating a Credit Card object
        card = YRPaymentCreditCard()
        // Creating Payment object with our card
        payment = YRPayment(creditCard: card)

        // Setting Credit Card position
        view.addSubview(card)
        card.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true

        // Setting textFields position and size (can be done using storyboards)
        setupViews()

        // Linking textFields to Payment object
        payment.numberTextField = NumberTF
        payment.holderNameTextField = NameTF
        payment.validityTextField = ValidityTF
        payment.cryptogramTextField = cryptoTF

        // Accessing to Credit Card data after completion (ex: Done button, ...)
        /*
         payment.getCardNumber()
         payment.getCardHolderName()
         payment.getCardValidity()
         payment.getCardCryptogram()
         */
    }

    // MARK: textFields created programmatically (can be done using storyboards too)

    let NumberTF: UITextField = {
        let textF = CustomTextField()
        textF.placeholder = "XXXX XXXX XXXX XXXX"
        return textF
    }()

    let NameTF: UITextField = {
        let textF = CustomTextField()
        textF.placeholder = "Name Surname"
        return textF
    }()

    let ValidityTF: UITextField = {
        let textF = CustomTextField()
        textF.placeholder = "MM/YY"
        return textF
    }()

    let cryptoTF: UITextField = {
        let textF = CustomTextField()
        textF.placeholder = "XXX"
        return textF
    }()

    // MARK: Setting up textFilds (constrains ...)

    func setupViews() {
        view.addSubview(NumberTF)
        NumberTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NumberTF.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 30).isActive = true

        view.addSubview(NameTF)
        NameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NameTF.topAnchor.constraint(equalTo: NumberTF.bottomAnchor, constant: 10).isActive = true

        view.addSubview(ValidityTF)
        ValidityTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ValidityTF.topAnchor.constraint(equalTo: NameTF.bottomAnchor, constant: 10).isActive = true

        view.addSubview(cryptoTF)
        cryptoTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cryptoTF.topAnchor.constraint(equalTo: ValidityTF.bottomAnchor, constant: 10).isActive = true
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        NumberTF.resignFirstResponder()
        NameTF.resignFirstResponder()
        ValidityTF.resignFirstResponder()
        cryptoTF.resignFirstResponder()
    }
}

// MARK: Simple custom textField

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 200).isActive = true
        heightAnchor.constraint(equalToConstant: 30).isActive = true
        let bar = CALayer()
        bar.backgroundColor = UIColor.gray.cgColor
        bar.frame = CGRect(x: 3, y: 28, width: 196, height: 1.5)
        layer.addSublayer(bar)
        textAlignment = .center
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
