//
//  ViewController.swift
//  hookone
//
//  Created by KARTHIK on 6/5/15.
//  Copyright (c) 2015 Sweatha. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numbersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var timer:NSTimer!
    var time:Int = 60;
    var score:Int = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupgame();
        
        setRandomNumberLabel();
        updateScoreLabel();
        
        if(inputField != nil)
        {
            inputField!.font = UIFont(name: "Helvetica", size: 46.0);
            inputField!.frame.size.height = 100.0;
            inputField!.addTarget(self, action: "textFieldDidChange:", forControlEvents:UIControlEvents.EditingChanged);
        }
        
    }
    
    func setupgame()
    {
        score=0
        scoreLabel!.text="Score: \(score)"
        
        timeLabel.text = "Time:\(time)";
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:  Selector("elapsedtime"), userInfo: nil, repeats: true)
        
    }
    
    func elapsedtime()
    {
        time-- ;
        timeLabel.text = "Time:\(time)";
        if( time<=0)
        {
            
            var alertView:UIAlertView=UIAlertView()
            alertView.title="GameOver!"
            alertView.message="Your score is \(score)"
            alertView.delegate=self
            alertView.addButtonWithTitle("ok")
            alertView.show()
            timer.invalidate()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex==0 {
            time = 60
            setupgame()
        }
    }
    
    
    func updateScoreLabel()
    {
        
        if(scoreLabel != nil)
        {
            scoreLabel!.text = "Score: \(score)";
        }
    }
    
    func setRandomNumberLabel()
    {
        if(numbersLabel != nil)
        {
            numbersLabel!.text = generateRandomNumber();
        }
    }
    
    
    
    
    
    
    
    
    func generateRandomNumber() -> String
    {
        var result:String = "";
        
        for _ in 1...4
        {
            var digit:Int = Int(arc4random_uniform(8) + 1);
            
            result += "\(digit)";
        }
        
        return result;
    }
    
    
    func textFieldDidChange(textView:UITextView!)
    {
        
        if(inputField == nil || numbersLabel == nil || inputField!.text.utf16Count < 4 || numbersLabel!.text!.utf16Count < 4)
        {
            return;
        }
        
        var numbers:Int? = numbersLabel!.text!.toInt();
        var input:Int? = inputField!.text.toInt();
        if(numbers != nil && input != nil)
        {
            println("Comparing: \(inputField!.text) minus \(numbersLabel!.text!) == \(input! - numbers!)");
            
            if(input! - numbers! == 1111)
            {
                println("Correct!");
                
                score++;
            }
            else
            {
                println("Incorrect!");
                
                score--;
            }
        }
        
        setRandomNumberLabel();
        updateScoreLabel();
        
        inputField!.text = "";
        inputField.resignFirstResponder()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false;
    }
    
    
    
    
}

