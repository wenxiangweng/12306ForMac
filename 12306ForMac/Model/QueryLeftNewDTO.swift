//
//  TicketQueryResult.swift
//  Train12306
//
//  Created by fancymax on 15/8/1.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

struct SeatTypePair:CustomDebugStringConvertible {
    let id1:String
    let id2:String
    let number:Int
    let price:Double
    
    init(id1:String,id2:String,number:Int,price:Double) {
        self.id1 = id1
        self.id2 = id2
        self.number = number
        self.price = price
    }
    
    var debugDescription: String {
        return "id1:\(id1) id:\(id2) number:\(number) price:\(price)"
    }
}

class QueryLeftNewDTO:NSObject {
// MARK: JSON Property
    let train_no:String!
    let TrainCode:String!
    let start_station_telecode:String!
    let start_station_name:String!

    let end_station_telecode:String!
    let end_station_name:String!
    
    let FromStationCode:String?
    let FromStationName:String?
    
    let ToStationName:String?
    let ToStationCode:String?
    
    let start_time:String?
    let arrive_time:String?
    
    let day_difference:String?
    let train_class_name:String?
    //"12:01"
    let lishi:String?
    //"Y"  "IS_TIME_NOT_BUY"预售期未到/系统维护时间
    let canWebBuy:String?
    //721
    let lishiValue:String?
    
    //"yp_info":"O021700228M026050032O021703072" 二等座228张 一等座32 无座72
    let yp_info:String?
    let control_train_day:String?
    let start_train_date:String!
    let controlled_train_flag:String?
    let seat_feature:String?
    
    //"yp_ex":"O0M0O0"
    let yp_ex:String?
    let train_seat_feature:String?
    let seat_types:String?
    let location_code:String?
    let from_station_no:String?
    let to_station_no:String?
    let control_day:String?
    let sale_time:String?
    let is_support_card:String?
    //标识符
    var SecretStr:String?
    //票务描述
    var buttonTextInfo:String?
    //观光
//    var Gg_Num:String?
    //迎宾
//    var Yb_Num:String!
    //高级软卧
    let Gr_Num:String!
    //其他
    let Qt_Num:String!
    //软卧
    let Rw_Num:String!
    //软座
    let Rz_Num:String!
    //特等座
    let Tz_Num:String!
    //无座
    let Wz_Num:String!
    //硬卧
    let Yw_Num:String!
    //硬座
    let Yz_Num:String!
    //二等座
    let Ze_Num:String!
    //一等座
    let Zy_Num:String!
    //商务座
    let Swz_Num:String!
    
// MARK: Custom Property
    var seatTypePairDic = [String:SeatTypePair]()
    
    let isStartStation:Bool
    let isEndStation:Bool
    
    var hasTicket:Bool = false
    
    var startTrainDate:Date!
    fileprivate func getStartTrainDate(_ dateStr:String)->Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyymmdd"
        return dateFormatter.date(from: dateStr)
    }
    
    //"20150926" - > "2015-09-26"
    var startTrainDateStr:String!
    
    //"Fri Dec 04 2015 08:00:00 GMT+0800 (中国标准时间)"
    var jsStartTrainDateStr:String!
    fileprivate func getJsStartTrainDateStr(_ date:Date)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd yyyy '08:00:00' 'GMT'+'0800' '(中国标准时间)'"
        dateFormatter.locale = Locale(identifier: "en-US")
        return dateFormatter.string(from: date)
    }
    
    func isTicketInvalid() -> Bool {
        if controlled_train_flag == "1" {
            return true
        }
        else {
            return false
        }
    }
    
    init(json:JSON)
    {
        let ticket = json["queryLeftNewDTO"]
        train_no = ticket["train_no"].string
        TrainCode = ticket["station_train_code"].string
        
        start_station_telecode = ticket["start_station_telecode"].string
        start_station_name = ticket["start_station_name"].string
        
        end_station_telecode = ticket["end_station_telecode"].string
        end_station_name = ticket["end_station_name"].string
        
        FromStationName = ticket["from_station_name"].string
        FromStationCode = ticket["from_station_telecode"].string
        ToStationName = ticket["to_station_name"].string
        ToStationCode = ticket["to_station_telecode"].string
        start_time = ticket["start_time"].string
        arrive_time = ticket["arrive_time"].string
        lishi = ticket["lishi"].string
        start_train_date = ticket["start_train_date"].string
        controlled_train_flag = ticket["controlled_train_flag"].string
        
        day_difference = ticket["day_difference"].string
        train_class_name = ticket["train_class_name"].string
        canWebBuy = ticket["canWebBuy"].string
        lishiValue = ticket["lishiValue"].string
        yp_info = ticket["yp_info"].string
        control_train_day = ticket["control_train_day"].string
        seat_feature = ticket["seat_feature"].string
        yp_ex = ticket["yp_ex"].string
        train_seat_feature = ticket["train_seat_feature"].string
        seat_types = ticket["seat_types"].string
        location_code = ticket["location_code"].string
        from_station_no = ticket["from_station_no"].string
        to_station_no = ticket["to_station_no"].string
        control_day = ticket["control_day"].string
        sale_time = ticket["sale_time"].string
        is_support_card = ticket["is_support_card"].string
        
        Swz_Num = ticket["swz_num"].string
        Tz_Num = ticket["tz_num"].string
        Zy_Num = ticket["zy_num"].string
        Ze_Num = ticket["ze_num"].string
        Gr_Num = ticket["gr_num"].string
        Rw_Num = ticket["rw_num"].string
        Yw_Num = ticket["yw_num"].string
        Rz_Num = ticket["rz_num"].string
        Yz_Num = ticket["yz_num"].string
        Wz_Num = ticket["wz_num"].string
        Qt_Num = ticket["qt_num"].string
        
        SecretStr = json["secretStr"].string
        buttonTextInfo = json["buttonTextInfo"].string
        
        if SecretStr != nil{
            SecretStr = SecretStr!.removingPercentEncoding
        }
        
        isStartStation = (FromStationCode == start_station_telecode)
        isEndStation = (ToStationCode == end_station_telecode)
        
        super.init()
        
        startTrainDate = getStartTrainDate(start_train_date)
        startTrainDateStr = Convert2StartTrainDateStr(start_train_date)
        jsStartTrainDateStr = getJsStartTrainDateStr(startTrainDate)
        
        setupSeatTypePairs()
        setupHasTicket()
    }
    
    func hasTicketForSeatTypeFilterKey(_ key:String) -> Bool {
        for val in seatTypePairDic.values {
            if ((key.contains(val.id1))&&(val.number > 0)) {
                return true
            }
        }
        return false
    }
    
    func getSeatTypeNameByFilterKey(_ key:String) -> String? {
        for val in seatTypePairDic.values {
            if ((key.contains(val.id1))&&(val.number > 0)) {
                return val.id1
            }
        }
        return nil
    }
    
    func setupHasTicket(){
        for val in seatTypePairDic.values {
            if val.number > 0 {
                hasTicket = true
                return
            }
        }
    }
    
    func setupSeatTypePairs() {
        if self.yp_info == nil {
            return
        }
        let yp_info = self.yp_info!
        
        let totalLength = yp_info.lengthOfBytes(using: String.Encoding.utf8)
        if totalLength == 0 {
            return
        }
/*
1/02510/3186 :  无座/251元/186张
4/06730/0005
1/02510/0519
3/04260/0116

O/07650/0604
M/12075/0100
9/23895/0024
 */
        let ticketLength = 10
        let priceOffset = 1
        let priceLength = 5
        let numberOffset = 6
        let numberLength = 4
        let idOffset = 0
        let idLength = 1
        
        var numberPrevPos = yp_info.startIndex
        var numberNextPos = yp_info.startIndex
        var pricePrevPos = yp_info.startIndex
        var priceNextPos = yp_info.startIndex
        var idPrevPos = yp_info.startIndex
        var idNextPos = yp_info.startIndex
        
        var id1 = "无座"
        var id2 = "1"
        var number = 0
        var price:Double = 0
        
        let seatTypeDic = QuerySeatTypeDicBy(TrainCode)
        
        let totalTicketNumber = totalLength / ticketLength
        
        for _ in 1...totalTicketNumber {
            idPrevPos = yp_info.index(idPrevPos, offsetBy: idOffset)// idPrevPos.advancedBy(idOffset)
            idNextPos = yp_info.index(idPrevPos, offsetBy: idLength)// idPrevPos.advancedBy(idLength)
            id2 = yp_info.substring(with: idPrevPos..<idNextPos)
            
            pricePrevPos = yp_info.index(pricePrevPos, offsetBy: priceOffset)// pricePrevPos.advancedBy(priceOffset)
            priceNextPos = yp_info.index(pricePrevPos, offsetBy: priceLength)// pricePrevPos.advancedBy(priceLength)
            price = Double(yp_info.substring(with: pricePrevPos..<priceNextPos))! / 10
        
            numberPrevPos = yp_info.index(numberPrevPos, offsetBy: numberOffset)// numberPrevPos.advancedBy(numberOffset)
            numberNextPos = yp_info.index(numberPrevPos, offsetBy: numberLength)// numberPrevPos.advancedBy(numberLength)
            number = Int(yp_info.substring(with: numberPrevPos..<numberNextPos))!
            
            if number >= 3000 {
                id1 = "无座"
                number -= 3000
            }
            else {
                for (seatTypeName,seatTypeId) in seatTypeDic {
                    if (seatTypeId == id2) && (seatTypeName != "无座") {
                        id1 = seatTypeName
                    }
                }
            }
            
            pricePrevPos = yp_info.index(pricePrevPos, offsetBy: ticketLength - priceOffset)// pricePrevPos.advancedBy(ticketLength - priceOffset)
            numberPrevPos = yp_info.index(numberPrevPos, offsetBy: ticketLength - numberOffset)// numberPrevPos.advancedBy(ticketLength - numberOffset)
            idPrevPos = yp_info.index(idPrevPos, offsetBy: ticketLength - idOffset)// idPrevPos.advancedBy(ticketLength - idOffset)
            
            let seatType = SeatTypePair(id1: id1, id2: id2, number: number, price: price)
            seatTypePairDic[id1] = seatType
        }
    }
}

