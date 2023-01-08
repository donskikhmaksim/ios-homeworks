//
//  FeefView.swift
//  Navigation
//
//  Created by Максим Донских on 04.01.2023.
//

import UIKit
import AVFoundation

protocol FeedViewDelegate: AnyObject {
    func didTapCheckButton(text: String)
    func didTapPushButton()
    func alert()
    func pushVideo()
    func recordButtonDidTap()
}

class FeedView: UIView {
    
    private weak var delegate: FeedViewDelegate?
    
    var player = AVAudioPlayer()
    
    private let mediaArray: [String] = [
        "Media1", "Media2", "Media3", "Media4", "Media5",
    ]
    
    var currentMedia: String?
    var currentMediaCount: Int?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var showPostButton: CustomButton = {
        let button = CustomButton(title: "Push", width: 250, height: 50, backgroundColor: .purple)
        button.closure = { self.didTapPushButton() }
        return button
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check", width: 250, height: 50, backgroundColor: .systemYellow)
        button.closure = { self.didTapCheckButton(text: self.textField.text ?? "") }
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.text = "0"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var indicatorLabel: UILabel = {
        let textField = UILabel()
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var playButton: CustomButton = {
        let button = CustomButton(title: "Play/pause Song", width: 250, height: 50, backgroundColor: .green)
        button.closure = {
            self.playPauseMedia()
        }
        return button
    }()
    
    private lazy var stopButton: CustomButton = {
        let button = CustomButton(title: "Stop Song", width: 250, height: 50, backgroundColor: .red)
        button.closure = {
            self.stopMedia()
        }
        return button
    }()
    
    private lazy var nextButton: CustomButton = {
        let button = CustomButton(title: "Next Song", width: 100, height: 50, backgroundColor: .red)
        button.closure = {
            self.nextSong()
        }
        return button
    }()
    
    private lazy var prevButton: CustomButton = {
        let button = CustomButton(title: "Prev Song", width: 100, height: 50, backgroundColor: .red)
        button.closure = {
            self.prevSong()
        }
        return button
    }()
    
    private lazy var videoButton: CustomButton = {
        let button = CustomButton(title: "Video", width: 100, height: 50, backgroundColor: .red)
        button.closure = {
            self.pushVideo()
        }
        return button
    }()
    
    private lazy var recordButton: CustomButton = {
        let button = CustomButton(title: "Record", width: 100, height: 50, backgroundColor: .red)
        button.closure = {
            self.recordButtonDidTap()
        }
        return button
    }()
    
    init(delegate: FeedViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        currentMedia = mediaArray.first
        currentMediaCount = 0
        setupUI()
        setupGesture()
        setupPlayer()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(alert) , userInfo: nil, repeats: false)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBrown
        addSubview(scrollView)
        scrollView.addSubview(showPostButton)
        scrollView.addSubview(checkGuessButton)
        scrollView.addSubview(textField)
        scrollView.addSubview(indicatorLabel)
        scrollView.addSubview(playButton)
        scrollView.addSubview(stopButton)
        scrollView.addSubview(nextButton)
        scrollView.addSubview(prevButton)
        scrollView.addSubview(videoButton)
        scrollView.addSubview(recordButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            showPostButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showPostButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            checkGuessButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: showPostButton.bottomAnchor, constant: 8),
            
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 8),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 100),
            
            indicatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            indicatorLabel.widthAnchor.constraint(equalToConstant: 250),
            indicatorLabel.heightAnchor.constraint(equalToConstant: 50),
            
            playButton.bottomAnchor.constraint(equalTo: showPostButton.topAnchor, constant: -8),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            stopButton.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -8),
            stopButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            prevButton.bottomAnchor.constraint(equalTo: stopButton.topAnchor, constant: -8),
            prevButton.leadingAnchor.constraint(equalTo: stopButton.leadingAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: prevButton.bottomAnchor),
            nextButton.trailingAnchor.constraint(equalTo: stopButton.trailingAnchor),
            
            videoButton.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -8),
            videoButton.trailingAnchor.constraint(equalTo: nextButton.trailingAnchor),
            
            recordButton.bottomAnchor.constraint(equalTo: videoButton.bottomAnchor),
            recordButton.leadingAnchor.constraint(equalTo: prevButton.leadingAnchor)
            
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupPlayer() {
        
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: currentMedia, ofType: "mp3")!))
            player.prepareToPlay()
        } catch {
            print(error)
        }
    }
    
    @objc private func hideKeyboard() {
        endEditing(true)
    }
    
    @objc func didTapCheckButton(text: String) {
        delegate?.didTapCheckButton(text: text)
    }
    
    @objc func didTapPushButton() {
        delegate?.didTapPushButton()
    }
    
    @objc func alert() {
        delegate?.alert()
    }
    
    func checkTextField(text: String) {
        if text.count == 0 {
            indicatorLabel.backgroundColor = .white
        } else if text != FeedModel().secretWord {
            indicatorLabel.backgroundColor = .red
        } else {
            indicatorLabel.backgroundColor = .green
        }
    }
    
    func whiteLabel() {
        indicatorLabel.backgroundColor = .white
    }
    
    func checkText(_ result: Bool) {
        if result {
            indicatorLabel.backgroundColor = .green
        } else {
            indicatorLabel.backgroundColor = .red
        }
    }
    
    private func playPauseMedia() {
        indicatorLabel.text = mediaArray[currentMediaCount!]
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    
    private func stopMedia() {
        player.stop()
        player.currentTime = 0
        indicatorLabel.text = ""
    }
    
    private func nextSong() {
        let playNow = player.isPlaying
        do {
            let nextSongCount: Int?
            if currentMediaCount == mediaArray.count - 1 {
                nextSongCount = 0
                currentMediaCount = nextSongCount
            } else {
                nextSongCount = currentMediaCount! + 1
                currentMediaCount! += 1
                
            }
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: mediaArray[nextSongCount!], ofType: "mp3")!))
            player.prepareToPlay()
            
            if playNow {
                player.play()
            }
            indicatorLabel.text = mediaArray[currentMediaCount!]
        } catch {
            print(error)
        }
    }
    
    private func prevSong() {
        let playNow = player.isPlaying
        do {
            if player.currentTime > 2 {
                stopMedia()
                playPauseMedia()
            } else {
                let prevSongCount: Int?
                if currentMediaCount == 0 {
                    prevSongCount = mediaArray.count - 1
                    currentMediaCount = prevSongCount
                } else {
                    prevSongCount = currentMediaCount! - 1
                    currentMediaCount! -= 1
                }
                player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: mediaArray[prevSongCount!], ofType: "mp3")!))
                player.prepareToPlay()
                
                if playNow {
                    player.play()
                }
                indicatorLabel.text = mediaArray[currentMediaCount!]
            }
            
        } catch {
            print(error)
        }
    }
    
    private func pushVideo() {
        delegate?.pushVideo()
    }
    
    private func recordButtonDidTap() {
        delegate?.recordButtonDidTap()
    }
    
}
