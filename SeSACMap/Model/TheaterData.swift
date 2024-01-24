//
//  TheaterData.swift
//  SeSACMap
//
//  Created by 김진수 on 1/24/24.
//

import Foundation

enum TheaterDataHelper {
    case LotteCinema
    case Cgv
    case MegaBox
    
    var name: String {
        switch self {
        case .LotteCinema:
            return "롯데시네마"
        case .Cgv:
            return "CGV"
        case .MegaBox:
            return "메가박스"
        }
    }
}

struct Theater {
    let name: String
    let latitude: Double
    let longitude: Double
}


struct TheaterData {
    static let theater: [Theater] = [
        Theater(name: TheaterDataHelper.Cgv.name, latitude: 37.539800, longitude: 127.066892),
        Theater(name: TheaterDataHelper.Cgv.name, latitude: 37.535856, longitude: 127.095695),
        Theater(name: TheaterDataHelper.Cgv.name, latitude: 37.535689, longitude: 127.095751),
        Theater(name: TheaterDataHelper.LotteCinema.name, latitude: 37.538633, longitude: 127.073253),
        Theater(name: TheaterDataHelper.LotteCinema.name, latitude: 37.513803, longitude: 127.104056),
        Theater(name: TheaterDataHelper.LotteCinema.name, latitude: 37.536662, longitude: 127.125331),
        Theater(name: TheaterDataHelper.MegaBox.name, latitude: 37.528468, longitude: 127.125387),
        Theater(name: TheaterDataHelper.MegaBox.name, latitude: 37.512909, longitude: 127.058698)
    ]
}

