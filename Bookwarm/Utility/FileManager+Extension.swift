//
//  FileManager+Extension.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/09/05.
//

import UIKit

extension UIViewController {
    //Document에 이미지 저장
    func saveImageToDocument(fileName: String, image: UIImage) {
        //1. Document 디렉토리 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        //2. 이미지 저장할 경로 설정
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //3. 이미지 데이터로 변환
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        //4. 이미지 저장
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file Save Error", error)
        }
    }
    
    //Document에 저장된 이미지 가져오기
    func loadImageFromDocument(fileName: String) -> UIImage {
        //1. Document 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return UIImage(systemName: "star.fill")!
        }
        
        //2. 이미지 저장된 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //3. 파일 유효성 검사
        if FileManager.default.fileExists(atPath: fileURL.path) {
            guard let image = UIImage(contentsOfFile: fileURL.path) else {
                return UIImage(systemName: "star.fill")!
            }
            return image
        } else {
            return UIImage(systemName: "star.fill")!
        }
        
    }
}
