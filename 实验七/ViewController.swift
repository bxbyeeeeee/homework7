//
//  ViewController.swift
//  实验七
//
//  Created by student on 2018/12/17.
//  Copyright © 2018年 baoxinbei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = CardGame(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    //所有卡片关联的出口，所有卡片的集合
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var userScores: UILabel!
    var scores = 0 { didSet { userScores.text = "Scores : \(scores)" } }
    
    //所有UIBotton所关联的action
    @IBAction func UIButton(_ sender: UIButton) {
        //点击卡片开始
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    //从模型更新视图,如果点击没翻的卡片则翻出，注意与model中chooseCard的顺序
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
                //匹配成功则加分
                if game.add {
                    scores += 2
                    game.add = false
                }
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.groupTableViewBackground : UIColor.lightGray
            }
        }
    }
    
    //重新开始
    @IBAction func restartGame(_ sender: UIButton) {
        for index in cardButtons.indices {
            game.cards[index].isMatched = false
            game.cards[index].isFaceUp = false
            cardButtons[index].setTitle("", for: UIControl.State.normal)
            cardButtons[index].backgroundColor = UIColor.lightGray
        }
        scores = 0
        let them = Int(arc4random_uniform(UInt32(themes.keys.count)))
        emojiChoices = themes[them]!
        emoji = [Int:String]()
    }
    
    //emoji主题字典(重新开始时切换)
    var themes = [0 : ["😛","🤑","😎","🤗","🤓","😤"],
                  1 : ["❤️","💛","💚","💙","💜","💖"],
                  2 : ["🐶","🐼","🐨","🐷","🐰","🐮"],
                  3 : ["🍏","🍐","🍊","🍌","🍉","🍇"]]
    //emoji主题数组
    lazy var emojiChoices = themes[0]!
    
    //emoji字典
    var emoji = [Int:String]()
    func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            //初始化对应卡片后，把对应的emoji图片从数组中去除
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

