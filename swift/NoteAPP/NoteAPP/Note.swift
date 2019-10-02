//
//  Note.swift
//  NoteAPP
//
//  Created by user46 on 2018/5/17.
//  Copyright © 2018年 Mint. All rights reserved.
//

import Foundation
//沒有import UIKit程式會看不見UIImage的型態
import UIKit
import CoreData
//class Note : Equatable{
//class Note : NSObject,NSCoding{
class Note : NSManagedObject{
    /*
    func encode(with aCoder: NSCoder) {
        //寫到檔案
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.imageName, forKey: "imageName")
        aCoder.encode(self.noteID ,forKey: "noteID")
    }
    //NSObject 的designate init
    required init?(coder aDecoder: NSCoder) {
        //檔案->物件
        self.noteID = aDecoder.decodeObject(forKey:"noteID") as! String
        super.init()
        self.text = aDecoder.decodeObject(forKey:"text") as? String
        self.imageName = aDecoder.decodeObject(forKey:"imageName") as? String
        
        
        
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        /*
        //判斷記憶體立面的位置，如果一樣，那當然是同一個物件
        return lhs === rhs //三個等於
        */
        //第二種做法，判斷noteID(身分證字號)，一樣表示為同一個物件
        return lhs.noteID == rhs.noteID
    }
    */
    
    @NSManaged var text : String?
    //把image存成檔案，不要setImage(記憶體)，改成只提供getImage方法(從檔案讀出轉成UIImage)
    //var image : UIImage?
    @NSManaged var noteID : String
    @NSManaged var imageName : String? //檔名(uuid.jpg)，如果沒有值表示沒有照片，有值表示有照片
    func image() -> UIImage? {
        //從檔案讀出轉成UIImage
        if let fileName = self.imageName{//如果有imageName，表示有圖檔
        let homeUrl = URL(fileURLWithPath: NSHomeDirectory())
        let docmentUrl = homeUrl.appendingPathComponent("Documents")
        //let fileName = "\(self.note.noteID).jpg"
            let fileUrl = docmentUrl.appendingPathComponent(fileName)
            return UIImage(contentsOfFile: fileUrl.path) //載入圖檔回傳
        }
        return nil// 如果沒有圖檔回傳nil
    }
    //新增inser into table時才會被執行，此時才產生noteID
    override func awakeFromInsert() {
        self.noteID = UUID().uuidString
    }

    /*
    override init(){
        //利用 UUID物件產生一個uuid(文字型式)//PHP MySQL(uuid:asf-adsas-asdasd-adasd)
        noteID = UUID().uuidString
    }
 */
    func thumbnail() -> UIImage? {
        
        if let image =  self.image() {
            
            let thumbnailSize = CGSize(width:50, height: 50); //設定縮圖大小
            let scale = UIScreen.main.scale //找出目前螢幕的scale，視網膜技術為2.0
            
            //產生畫布，第一個參數指定大小,第二個參數true:不透明（黑色底）,false表示透明背景,scale為螢幕scale
            UIGraphicsBeginImageContextWithOptions(thumbnailSize,false,scale)
            
            //計算長寬要縮圖比例，取最大值MAX會變成UIViewContentModeScaleAspectFill
            //最小值MIN會變成UIViewContentModeScaleAspectFit
            let widthRatio = thumbnailSize.width / image.size.width;
            let heightRadio = thumbnailSize.height / image.size.height;
            
            let ratio = max(widthRatio,heightRadio);
            
            let imageSize = CGSize(width:image.size.width*ratio,height: image.size.height*ratio);
            
            image.draw(in:CGRect(x: -(imageSize.width-thumbnailSize.width)/2.0,y: -(imageSize.height-thumbnailSize.height)/2.0,
                                 width: imageSize.width,height: imageSize.height))
            //取得畫布上的縮圖
            let smallImage = UIGraphicsGetImageFromCurrentImageContext();
            //關掉畫布
            UIGraphicsEndImageContext();
            return smallImage
        }else{
            return nil;
        }
    }
    
    
    

}
