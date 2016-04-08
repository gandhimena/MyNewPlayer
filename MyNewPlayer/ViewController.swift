//
//  ViewController.swift
//  MyNewPlayer
//
//  Created by Gandhi Mena Salas on 02/04/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    
//Variables
    let prevIcon = UIImage(named: "prev")
    let playIcon = UIImage(named: "play")
    let pauseIcon = UIImage(named: "pause")
    let nextIcon = UIImage(named: "next")
    
    //lists
    let titleList: [String] =   ["title1","title2","title3","title4","title5","title6"]
    let authorList: [String] =  ["autor1","autor2","autor3","autor4","autor5","autor6"]
    let songList: [String] =    ["sound1","sound2","sound3","sound4","sound5","sound6"]
    let coverList: [String] =   ["image1","image2","image3","image4","image5","image6"]
    
    //PlayerManager
    var player = AVAudioPlayer()
    
    //index
    var indexSong:Int!
    
//Outlets
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var titleSong: UILabel!
    @IBOutlet weak var authorSong: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prevButton.setImage(prevIcon, forState: .Normal)
        playButton.setImage(playIcon, forState: .Normal)
        nextButton.setImage(nextIcon, forState: .Normal)
        
        print(indexSong)
        addResource(songNumber: indexSong!)
        //45, 510, 230, 20
        
        //VolumeControll
        let formVolume = UIView(frame: CGRectMake(45, 510, 230, 20))
        let volumeView = MPVolumeView(frame: formVolume.bounds)
        formVolume.addSubview(volumeView)
        self.view.addSubview(formVolume)
    
    }
    
    
    @IBAction func playerController(sender: UIButton) {
        
        switch (sender.titleLabel?.text)! {
            
        case "play":
            
            if !player.playing{
                
                player.play()
                playButton.setImage(pauseIcon, forState: .Normal)
                
            }else{
                
                player.pause()
                playButton.setImage(playIcon, forState: .Normal)
                
            }
            
        case "prev":
            
            if indexSong == 0{
                indexSong = songList.count
            }
            
            indexSong! -= 1
            
            addResource(songNumber: indexSong)
            print(indexSong)
            
            
        case "next":
            
            if indexSong == songList.count - 1{
                indexSong! = -1
                
            }
            
            indexSong! += 1
            
            addResource(songNumber: indexSong)
            print(indexSong)
            
        default: //this is the shuffleButton
            
            let shuffle = Int(arc4random_uniform(UInt32(songList.count)))
            addResource(songNumber: shuffle)
            print(shuffle)
            
        }
    }
    
    
    func addResource(songNumber songNumber: Int){
        
        let songSource = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(songList[songNumber], ofType: "mp3")!)
        let coverSource = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(coverList[songNumber], ofType: "jpg")!)
        let coverData = NSData(contentsOfURL: coverSource)
        
        do{
            
            player = try AVAudioPlayer(contentsOfURL: songSource)
            player.play()
            playButton.setImage(pauseIcon, forState: .Normal)
        
            cover.image = UIImage(data: coverData!)
            titleSong.text = titleList[songNumber]
            authorSong.text = authorList[songNumber]
            
        }catch{
        
            print("Error")
            
            
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if motion == .MotionShake {
            
            let shuffle = Int(arc4random_uniform(UInt32(songList.count)))
            addResource(songNumber: shuffle)
            print(shuffle)
        }
    }

    
    
    //**********Volumen con slider
    /*
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        let selectedValue = Float(sender.value)
        
        if reproductor.playing{
            
            reproductor.volume = selectedValue
        }
     
    }*/
    /* //Volumen del dispositivo
     let wrapperView = UIView(frame: CGRectMake(45, 510, 230, 20))
     self.view.addSubview(wrapperView)
     let volumenView = MPVolumeView(frame: wrapperView.bounds)
     wrapperView.addSubview(volumenView)
     */
}

