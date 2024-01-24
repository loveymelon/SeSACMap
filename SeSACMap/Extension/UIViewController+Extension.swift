//
//  UIViewController+Extension.swift
//  SeSACMap
//
//  Created by 김진수 on 1/24/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(completionhandler: @escaping (String) -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let oneButton = UIAlertAction(title: TheaterDataHelper.Cgv.name, style: .default) { button in
            completionhandler(button.title!)
        }
        
        
        let twoButton = UIAlertAction(title: TheaterDataHelper.LotteCinema.name, style: .default) { button in
            completionhandler(button.title!)
        }
        let threeButton = UIAlertAction(title: TheaterDataHelper.MegaBox.name, style: .default) { button in
            completionhandler(button.title!)
        }
        let fourButton = UIAlertAction(title: "전체보기", style: .default) { button in
            completionhandler(button.title!)
        }
        
        alert.addAction(oneButton)
        alert.addAction(twoButton)
        alert.addAction(threeButton)
        alert.addAction(fourButton)
        
        
        present(alert, animated: true)
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            } else {
                print("설정으로 가주세요")
            }
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
