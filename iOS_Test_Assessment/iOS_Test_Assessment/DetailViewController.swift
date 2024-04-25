//
//  DetailViewController.swift
//  iOS_Test_Assessment
//
//  Created by Bhargav Bhatti on 25/04/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var model: JsonModel?
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail"
        
        if let data = model {
           
            self.idLabel?.attributedText = attributedTextString(modelObj: "\(data.id ?? 0)", titleObj: "ID")
            self.titleLabel?.attributedText = attributedTextString(modelObj: data.title ?? "", titleObj: "Title")
            self.bodyLabel?.attributedText = attributedTextString(modelObj: data.body ?? "", titleObj: "Detail")
            
        }
    }
    
    func attributedTextString(modelObj: String, titleObj: String) -> NSMutableAttributedString {
        let idString = "\(titleObj): \(modelObj)"
        let attributedString = NSMutableAttributedString(string: idString)
        let range = (idString as NSString).range(of: "\(titleObj):")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: range)
        return attributedString
    }
    
}
