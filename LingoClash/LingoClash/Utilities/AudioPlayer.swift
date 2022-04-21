//
//  AudioPlayer.swift
//  Peggle-PSET4
//
//  Created by Sherwin Poh on 1/3/22.
//

import AVFoundation

class AudioPlayer {
    static var musicPlayer: AVAudioPlayer?
    static var soundEffectPlayers = [AVAudioPlayer]()
    static var fileExtension = "mp3"

    static func playPKGameBackgroundMusic() {
        guard musicPlayer == nil else {
            return
        }

        let fileName = "pkgamebackground"
        guard let bundle = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
            return
        }

        let fileURL = URL(fileURLWithPath: bundle)
        guard let musicPlayer = try? AVAudioPlayer(contentsOf: fileURL) else {
            return
        }

        self.musicPlayer = musicPlayer
        musicPlayer.volume = 0.15
        musicPlayer.numberOfLoops = -1
        musicPlayer.prepareToPlay()
        musicPlayer.play()
    }
    
    static func playWinSound() {
        playSoundEffect(fileName: "win", volume: 0.2)
    }
    
    static func playLoseSound() {
        playSoundEffect(fileName: "lose", volume: 0.2)
    }

    static func playCorrectAnswerSound() {
        playSoundEffect(fileName: "correct", volume: 0.2)
    }
    
    static func playWrongAnswerSound() {
        playSoundEffect(fileName: "wrong", volume: 0.2)
    }

    static func playSoundEffect(fileName: String, volume: Float = 0.2) {
        guard let bundle = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
            return
        }
        let fileURL = URL(fileURLWithPath: bundle)
        guard let soundEffectPlayer = try? AVAudioPlayer(contentsOf: fileURL) else {
            return
        }

        soundEffectPlayers.append(soundEffectPlayer)
        soundEffectPlayer.volume = volume
        soundEffectPlayer.numberOfLoops = 0
        soundEffectPlayer.prepareToPlay()
        soundEffectPlayer.play()
    }
    
    static func stopPlaying() {
        musicPlayer = nil
        soundEffectPlayers = []
    }
}
