//
//  ViewController.swift
//  TestApp
//
//  Created by Юля Пономарева on 12.07.17.
//  Copyright © 2017 Юля Пономарева. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ViewController: UIViewController {

    private let mainButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.setTitle("Tap ME", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    private let acceptLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()
    private let acceptEncodingLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()

    private let acceptLanguageLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()
    
    private let connectionLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()
    
    private let hostLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()

    private let userAgent: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()
    
    private let imageView = UIImageView()
    
    private let networkManager = NetworkManager()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateConstraints()
        mainButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func updateConstraints() {
        self.view.addSubview(mainButton)
        self.view.addSubview(imageView)
        self.view.addSubview(acceptLabel)
        self.view.addSubview(acceptEncodingLabel)
        self.view.addSubview(acceptLanguageLabel)
        self.view.addSubview(connectionLabel)
        self.view.addSubview(hostLabel)
        self.view.addSubview(userAgent)
        
        mainButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(60)
        }
        
        imageView.snp.remakeConstraints { make in
            make.top.lessThanOrEqualTo(mainButton.snp.bottom).offset(30)
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        userAgent.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mainButton.snp.top).offset(-30)
            make.left.right.equalToSuperview().inset(15)
        }
        
        hostLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(userAgent.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(15)
        }
        
        connectionLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(hostLabel.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(15)
        }
        
        acceptLanguageLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(connectionLabel.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(15)
        }
        
        acceptEncodingLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(acceptLanguageLabel.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(15)
        }
        
        acceptLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(acceptEncodingLabel.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(15)
        }
        
        super.updateViewConstraints()
    }
    
    func buttonPressed() {
        self.imageView.image = nil
        
        self.acceptLabel.text = ""
        self.acceptEncodingLabel.text = ""
        self.acceptLanguageLabel.text = ""
        self.connectionLabel.text = ""
        self.hostLabel.text = ""
        self.userAgent.text = ""
        
        loadText().asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] model in
                let acceptText = model.headers.accept ?? "empty"
                let acceptEncodingText = model.headers.acceptEncoding ?? "empty"
                let acceptLanguageText = model.headers.acceptLanguage ?? "empty"
                let connectionText = model.headers.connection ?? "empty"
                let hostText = model.headers.host ?? "empty"
                let userAgentText = model.headers.userAgent ?? "empty"
                
                self.acceptLabel.text = "Accept: \(acceptText)"
                self.acceptEncodingLabel.text = "Accept-Encoding: \(acceptEncodingText)"
                self.acceptLanguageLabel.text = "Accept-Encoding: \(acceptLanguageText)"
                self.connectionLabel.text = "Accept-Encoding: \(connectionText)"
                self.hostLabel.text = "Accept-Encoding: \(hostText)"
                self.userAgent.text = "Accept-Encoding: \(userAgentText)"
        }).addDisposableTo(disposeBag)
        downloadImage()
    }
    
    func downloadImage() {
        networkManager.getDataForImageFromURL() { (data, response, error)  in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() { () -> Void in
                self.imageView.image = UIImage(data: data)
                
            }
        }
    }
    
    func loadText() -> Observable<MainModel> {
        return networkManager.downloadText()
            .flatMap({ model -> Observable<MainModel> in
                return Observable.just(model)
            })
    }

}

