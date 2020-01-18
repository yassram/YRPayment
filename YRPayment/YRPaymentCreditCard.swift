//
//  YRPaymentCreditCard.swift
//  YRPayment
//
//  Created by Yassir RAMDANI on 6/23/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

public final class YRPaymentCreditCard: UIView, CAAnimationDelegate {
    var cardType = YRCreditCardType.masterCard
    var flipOnClick = true

    fileprivate let faceView = UIView()
    fileprivate let backView = UIView()

    var isFace: Bool {
        return !faceView.isHidden
    }

    // MARK: - Formating Strings on card

    fileprivate func formatCardNumber(s: String) -> (String, String) {
        if s.count > 16 {
            return ("", "XXXX XXXX XXXX XXXX")
        }
        var num = Array(s)
        num.append(contentsOf: Array(repeating: String.Element("X"), count: 16 - s.count))
        for i in 1 ... 4 {
            num.insert(" ", at: 4 * i + i - 1)
        }
        let s1 = String(num).replacingOccurrences(of: "X ", with: "").replacingOccurrences(of: "X", with: "")
        return (s1, String(num).replacingOccurrences(of: s1, with: ""))
    }

    fileprivate func formatValidity(s: String) -> (String, String) {
        if s.count > 5 {
            return ("", "MM/YY")
        }
        var num = Array(s)
        if s.count <= 4 {
            num.append(contentsOf: Array("MM/YY")[s.count ... 4])
        }
        var s1 = String(num).replacingOccurrences(of: "Y", with: "").replacingOccurrences(of: "M", with: "")
        if s.count < 3 {
            s1 = s1.replacingOccurrences(of: "/", with: "")
        }
        return (s1, String(num).replacingOccurrences(of: s1, with: ""))
    }

    func unselectAll() {
        cardNumberLabel.unSelect()
        cardHolderNameLabel.unSelect()
        cardValidityLabel.unSelect()
        cardCryptogramLabel.unSelect()
    }

    // MARK: - Card Strings

    var cardNumber: String! {
        didSet {
            unselectAll()
            cardNumberLabel.select()
            if cardNumber == "" {
                let xes = NSMutableAttributedString(string: "XXXX XXXX XXXX XXXX", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.gray,
                ])
                cardNumberLabel.attributedText = xes
                return
            }

            let formatedStr = formatCardNumber(s: cardNumber)
            let nums = NSMutableAttributedString(string: formatedStr.0, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ])

            let xes = NSMutableAttributedString(string: formatedStr.1, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
            ])
            nums.append(xes)
            cardNumberLabel.attributedText = nums
        }
    }

    var cardHolderName: String! {
        didSet {
            unselectAll()
            cardHolderNameLabel.select()
            if cardHolderName == "" {
                let name = NSMutableAttributedString(string: "", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                ])
                let placeholder = NSMutableAttributedString(string: "NAME SURNAME", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.gray,
                ])
                name.append(placeholder)
                cardHolderNameLabel.attributedText = name
                return
            }
            let name = NSMutableAttributedString(string: cardHolderName, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ])
            cardHolderNameLabel.attributedText = name
        }
    }

    var cardValidity: String! {
        didSet {
            unselectAll()
            cardValidityLabel.select()
            if cardValidity == "" {
                let nums = NSMutableAttributedString(string: "", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                ])
                let placeholder = NSMutableAttributedString(string: "MM/YY", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.gray,
                ])
                nums.append(placeholder)
                cardValidityLabel.attributedText = nums
            }
            let formatedStr = formatValidity(s: cardValidity)
            let nums = NSMutableAttributedString(string: formatedStr.0, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ])
            let placeholder = NSMutableAttributedString(string: formatedStr.1, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
            ])
            nums.append(placeholder)
            cardValidityLabel.attributedText = nums
        }
    }

    var cardCryptogram: String! {
        didSet {
            unselectAll()
            cardValidityLabel.select()
            if cardCryptogram == "" || cardCryptogram.count > 3 {
                let nums = NSMutableAttributedString(string: "", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                ])
                let xes = NSMutableAttributedString(string: "XXX", attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.gray,
                ])
                nums.append(xes)
                cardCryptogramLabel.attributedText = nums
                return
            }
            let nums = NSMutableAttributedString(string: cardCryptogram, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ])
            var s2 = ""
            if cardCryptogram.count < 3 {
                s2 = String(Array("XXX")[cardCryptogram.count ... 2])
            }
            let xes = NSMutableAttributedString(string: s2, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
            ])
            nums.append(xes)
            cardCryptogramLabel.attributedText = nums
        }
    }

    // MARK: - CardType

    fileprivate func cardSymbleLayer() -> CALayer {
        switch cardType {
        case .masterCard:
            return masterCard()
        case let .custom(img):
            let a = CALayer()
            a.contents = img.cgImage
            a.frame = CGRect(x: 0, y: 0, width: 36, height: 40)
            a.contentsGravity = .topRight
            return a
        }
    }

    fileprivate func masterCard() -> CAShapeLayer {
        let masterCard = CAShapeLayer()
        let masterCardL = CAShapeLayer()
        masterCardL.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 20, height: 20)).cgPath
        masterCardL.fillColor = UIColor.red.cgColor
        masterCardL.opacity = 0.7
        let masterCardR = CAShapeLayer()
        masterCardR.path = UIBezierPath(ovalIn: CGRect(x: 10, y: 0, width: 20, height: 20)).cgPath
        masterCardR.opacity = 0.7
        masterCardR.fillColor = UIColor(red: 0.99, green: 0.78, blue: 0.21, alpha: 1.00).cgColor
        masterCard.addSublayer(masterCardL)
        masterCard.addSublayer(masterCardR)
        return masterCard
    }

    // MARK: - Labels
    static var registerFonts: Void = {
        let fontUrl = Bundle(url: Bundle(for: YRPaymentCreditCard.self).url(forResource: "fonts", withExtension: "bundle")!)?.url(forResource: "OCRAStd", withExtension: "otf")
        try? UIFont.register(fontUrl: fontUrl)
    }()
    
    let cardNumberLabel: UILabel = {
        _ = YRPaymentCreditCard.registerFonts
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "OCRAStd", size: 18)
        let nums = NSMutableAttributedString(string: "", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ])
        let xes = NSMutableAttributedString(string: "XXXX XXXX XXXX XXXX", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
        ])
        nums.append(xes)
        lab.attributedText = nums
        lab.textAlignment = .center
        return lab
    }()

    let cardHolderNameLabel: UILabel = {
        _ = YRPaymentCreditCard.registerFonts
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "OCRAStd", size: 14)
        let name = NSMutableAttributedString(string: "", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ])
        let placeholder = NSMutableAttributedString(string: "NAME SURNAME", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
        ])
        name.append(placeholder)
        lab.attributedText = name
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()

    let cardValidityLabel: UILabel = {
        _ = YRPaymentCreditCard.registerFonts
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "OCRAStd", size: 14)
        let nums = NSMutableAttributedString(string: "", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ])
        let placeholder = NSMutableAttributedString(string: "MM/YY", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
        ])
        nums.append(placeholder)
        lab.attributedText = nums
        lab.textAlignment = .center
        return lab
    }()

    let cardCryptogramLabel: UILabel = {
        _ = YRPaymentCreditCard.registerFonts
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "OCRAStd", size: 14)
        let nums = NSMutableAttributedString(string: "", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ])
        let xes = NSMutableAttributedString(string: "XXX", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
        ])
        nums.append(xes)
        lab.attributedText = nums
        lab.textAlignment = .center
        return lab
    }()

    // MARK: - Setup Views

    func setupViews() {
        backgroundColor = UIColor(red: 0.29, green: 0.28, blue: 0.30, alpha: 1.00)
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 280).isActive = true
        heightAnchor.constraint(equalToConstant: 160).isActive = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 20
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)

        addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backView.isHidden = true
        backView.layer.cornerRadius = 12

        addSubview(faceView)
        faceView.translatesAutoresizingMaskIntoConstraints = false
        faceView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        faceView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        faceView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        faceView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        faceView.layer.cornerRadius = 12

        setupFaceView()
        setupBackView()
    }

    // MARK: - Setup Face View

    fileprivate func setupFaceView() {
        faceView.layoutIfNeeded()
        let cardSymbole = cardSymbleLayer()
        cardSymbole.frame = CGRect(x: faceView.bounds.width - 30 - 16, y: 20, width: cardSymbole.bounds.width, height: cardSymbole.bounds.height)
        faceView.layer.addSublayer(cardSymbole)

        faceView.addSubview(cardNumberLabel)
        cardNumberLabel.centerXAnchor.constraint(equalTo: faceView.centerXAnchor).isActive = true
        cardNumberLabel.widthAnchor.constraint(equalTo: faceView.widthAnchor, constant: -32).isActive = true
        cardNumberLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        cardNumberLabel.centerYAnchor.constraint(equalTo: faceView.centerYAnchor, constant: +2).isActive = true

        faceView.addSubview(cardHolderNameLabel)
        cardHolderNameLabel.leftAnchor.constraint(equalTo: faceView.leftAnchor, constant: 16).isActive = true
        cardHolderNameLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        cardHolderNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cardHolderNameLabel.bottomAnchor.constraint(equalTo: faceView.bottomAnchor, constant: -16).isActive = true

        faceView.addSubview(cardValidityLabel)
        cardValidityLabel.rightAnchor.constraint(equalTo: faceView.rightAnchor, constant: -16).isActive = true
        cardValidityLabel.widthAnchor.constraint(equalToConstant: 52).isActive = true
        cardValidityLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cardValidityLabel.bottomAnchor.constraint(equalTo: faceView.bottomAnchor, constant: -16).isActive = true

        let cardHolderNameStaticLabel = UILabel()
        cardHolderNameStaticLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 10)
        cardHolderNameStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        cardHolderNameStaticLabel.text = "CARD HOLDER NAME"
        cardHolderNameStaticLabel.textColor = .white
        faceView.addSubview(cardHolderNameStaticLabel)
        cardHolderNameStaticLabel.widthAnchor.constraint(equalTo: cardHolderNameLabel.widthAnchor).isActive = true
        cardHolderNameStaticLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        cardHolderNameStaticLabel.bottomAnchor.constraint(equalTo: cardHolderNameLabel.topAnchor, constant: -4).isActive = true
        cardHolderNameStaticLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true

        let cardValidityStaticLabel = UILabel()
        cardValidityStaticLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 10)
        cardValidityStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        cardValidityStaticLabel.text = "VALID THRU"
        cardValidityStaticLabel.textColor = .white
        cardValidityStaticLabel.textAlignment = .right
        faceView.addSubview(cardValidityStaticLabel)
        cardValidityStaticLabel.widthAnchor.constraint(equalTo: cardHolderNameLabel.widthAnchor).isActive = true
        cardValidityStaticLabel.heightAnchor.constraint(equalTo: cardHolderNameStaticLabel.heightAnchor).isActive = true
        cardValidityStaticLabel.bottomAnchor.constraint(equalTo: cardHolderNameStaticLabel.bottomAnchor).isActive = true
        cardValidityStaticLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }

    // MARK: - Setup Back View

    fileprivate func setupBackView() {
        let blacMagneticBar = CAShapeLayer()
        blacMagneticBar.fillColor = UIColor.black.cgColor
        layoutIfNeeded()
        layoutSubviews()
        blacMagneticBar.path = UIBezierPath(rect: CGRect(x: 0, y: 24, width: backView.frame.width, height: 36)).cgPath
        backView.layer.addSublayer(blacMagneticBar)

        let cardSymbole = cardSymbleLayer()
        cardSymbole.frame = CGRect(x: backView.bounds.width - 30 - 16, y: backView.frame.height - 40, width: cardSymbole.bounds.width, height: cardSymbole.bounds.height)
        backView.layer.addSublayer(cardSymbole)

        backView.addSubview(cardCryptogramLabel)
        cardCryptogramLabel.leftAnchor.constraint(equalTo: backView.centerXAnchor, constant: 30).isActive = true
        cardCryptogramLabel.widthAnchor.constraint(equalToConstant: 42).isActive = true
        cardCryptogramLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cardCryptogramLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 8).isActive = true

        let rayedBar = CAShapeLayer()
        rayedBar.fillColor = UIColor.gray.cgColor
        cardCryptogramLabel.layoutIfNeeded()
        layoutIfNeeded()
        layoutSubviews()
        rayedBar.path = UIBezierPath(rect: CGRect(x: 12, y: cardCryptogramLabel.frame.minY - 5,
                                                  width: cardCryptogramLabel.frame.minX - 8 - 12, height: 30)).cgPath
        let whiteBar1 = CAShapeLayer()
        whiteBar1.fillColor = UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1.00).cgColor
        whiteBar1.path = UIBezierPath(rect: CGRect(x: 12, y: cardCryptogramLabel.frame.minY - 5 + 5,
                                                   width: cardCryptogramLabel.frame.minX - 8 - 12, height: 5)).cgPath
        let whiteBar2 = CAShapeLayer()
        whiteBar2.fillColor = UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1.00).cgColor
        whiteBar2.path = UIBezierPath(rect: CGRect(x: 12, y: cardCryptogramLabel.frame.minY - 5 + 3 * 5,
                                                   width: cardCryptogramLabel.frame.minX - 8 - 12, height: 5)).cgPath

        let whiteBar3 = CAShapeLayer()
        whiteBar3.fillColor = UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1.00).cgColor
        whiteBar3.path = UIBezierPath(rect: CGRect(x: 12, y: cardCryptogramLabel.frame.minY - 5 + 5 * 5,
                                                   width: cardCryptogramLabel.frame.minX - 8 - 12, height: 5)).cgPath
        rayedBar.addSublayer(whiteBar1)
        rayedBar.addSublayer(whiteBar2)
        rayedBar.addSublayer(whiteBar3)
        backView.layer.addSublayer(rayedBar)
    }

    // MARK: - Constructors

    public init(type: YRCreditCardType) {
        super.init(frame: .zero)
        cardType = type
        setupViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Animation

    public func flip() {
        if !faceView.isHidden {
            rotateCard(from: 0, to: CGFloat.pi / 2, handleEnd: true)
        } else {
            rotateCard(from: 0, to: CGFloat.pi / 2, handleEnd: true)
        }
    }

    fileprivate func rotateCard(from: CGFloat, to: CGFloat, handleEnd: Bool = false,
                                timingFuncName: CAMediaTimingFunctionName = .easeIn) {
        let rot = CABasicAnimation(keyPath: "transform")
        rot.fromValue = CATransform3DMakeRotation(from, 0, 1, 0)
        rot.toValue = CATransform3DMakeRotation(to, 0, 1, 0)
        if handleEnd { rot.delegate = self }
        rot.duration = 0.6
        rot.timingFunction = CAMediaTimingFunction(name: timingFuncName)
        rot.autoreverses = false
        rot.isRemovedOnCompletion = false
        rot.fillMode = .forwards
        layer.add(rot, forKey: "transform")
    }

    public func animationDidStop(_: CAAnimation, finished _: Bool) {
        if !faceView.isHidden {
            rotateCard(from: CGFloat.pi / 2, to: 0, timingFuncName: .easeOut)
            faceView.isHidden = true
            backView.isHidden = false
        } else {
            rotateCard(from: CGFloat.pi / 2, to: 0, timingFuncName: .easeOut)
            faceView.isHidden = false
            backView.isHidden = true
        }
    }

    public override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        if flipOnClick {
            flip()
        }
    }
}
