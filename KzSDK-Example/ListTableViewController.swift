//
//  ListTableViewController.swift
//  KzSDK-Example
//
//  Created by K-zing on 5/6/2018.
//  Copyright © 2018 K-zing. All rights reserved.
//

import Foundation
import UIKit
import KzSDK_Swift

public class ListTableViewController: UITableViewController {
    public var logined: Bool = false
    
    public var apiActionsNotRequireLogin: [KzApi] = []
    public var apiActionsOptionalLogin: [KzApi] = []
    public var apiActionsRequireLogin: [KzApi] = []
    public var apiActions: [[KzApi]] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let getKey = ApiAction.GetKey()
        let getGPByPlatform = ApiAction.GetGPByPlatform().setAvailableOnly(true).setIncludeSubGames(true)
        let getDownloadAppList = ApiAction.GetDownloadAppList()
        let getActivitiesContent = ApiAction.GetActivitiesContent().setActivityId("1234567890")
        let getClientInfo = ApiAction.GetClientInfo()
        let getRegisterInfo = ApiAction.GetRegisterInfo()
        let registerAccount = ApiAction.RegisterAccount()
            .setQQ("123456789")
            .setAgentCode("1234")
            .setEmail("email@email.com")
            .setPhone("13812345678")
            .setJoinName("username")
            .setJoinPassword("password")
            .setBirthday(Calendar.current.date(byAdding: .year, value: -25, to: Date()))
            .setFullName("Name")
            .setJSessionId("SESSIONID")
            .setVerifyCode("CAPCHA")
            .setWithdrawPassword("withdrawPassword")
        let logout = ApiAction.Logout()
        
        let getActivitiesInfo = ApiAction.GetActivitiesInfo()
        
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: endDate)
        let offset = 0
        let pageCount = 10
        let page = 1
        
        let getMemberInfo = ApiAction.GetMemberInfo()
        let getBonus = ApiAction.GetBonus().setStartDate(startDate).setEndDate(endDate).setOffset(offset).setPageCount(pageCount)
        let getBankDictionary = ApiAction.GetBankDictionary()
        let getWithdrawBanksList = ApiAction.GetWithdrawBanksList()
        let addBankCard = ApiAction.AddBankCard().setCard("132123123").setBankCode("CODE").setAccountName("Name").setBankAccountName("Name")
        let submitWithdraw = ApiAction.SubmitWithdraw().setWithdrawBank("CODE").setWithdrawPassword("withdrawPassword").setAmount(100)
        let applyActivities = ApiAction.ApplyActivities().setActivityId("1234567890")
        let getDepositHistory = ApiAction.GetDepositHistory().setStartDate(startDate).setEndDate(endDate).setOffset(offset).setPageCount(pageCount)
        let getTransferHistory = ApiAction.GetTransferHistory().setStartDate(startDate).setEndDate(endDate).setOffset(offset).setPageCount(pageCount)
        let getWithdrawHistory = ApiAction.GetWithdrawHistory().setStartDate(startDate).setEndDate(endDate).setOffset(offset).setPageCount(pageCount)
        let getMessageHistory = ApiAction.GetMessageHistory().setStartDate(startDate).setEndDate(endDate).setOffset(offset).setPageCount(pageCount)
        let getBetHistory = ApiAction.GetBetHistory().setStartDate(startDate).setEndDate(endDate).setPage(page).setGamePlatformId("1234567890")
        let gameTransferOnEnter = ApiAction.GameTransferOnEnter().setGamePlatformAccountId("1234567890")
        let getGameUrl = ApiAction.GetGameUrl().setAppUrlPath("/url/path")
        
        //Currently iOS has no other game platform app supported
        let thirdPartyApp = KzPlatformApp.getInstance(gamePlatformId: "id")?.setUsername("username").setSiteId("siteId")
        
        self.apiActionsNotRequireLogin = [
            getKey,
            getGPByPlatform,
            getDownloadAppList,
            getActivitiesContent,
            getClientInfo,
            getRegisterInfo,
            registerAccount,
            logout
        ]
        
        self.apiActionsOptionalLogin = [
            getActivitiesInfo
        ]
        
        self.apiActionsRequireLogin = [
            getMemberInfo,
            getBonus,
            getBankDictionary,
            getWithdrawBanksList,
            addBankCard,
            submitWithdraw,
            applyActivities,
            getDepositHistory,
            getTransferHistory,
            getWithdrawHistory,
            getMessageHistory,
            getBetHistory,
            gameTransferOnEnter,
            getGameUrl
        ]
        if let thirdPartyApp = thirdPartyApp {
            self.apiActionsRequireLogin.append(thirdPartyApp)
        }
        
        self.apiActions = [
            apiActionsNotRequireLogin,
            apiActionsOptionalLogin,
            apiActionsRequireLogin
        ]
        
        //
        //Add Listeners
        //
        
        //GetKey
        _ = getKey.addListener(ApiListener<ApiAction.GetKey.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetGPByPlatform
        _ = getGPByPlatform.addListener(ApiListener<ApiAction.GetGPByPlatform.Result>.init(onSuccess: { result in
            guard let data = result.body?.data, let gpList = data.gamePlatformTypes else {
                return
            }
            
            for gpType in gpList {
                self.log(gpType.typeId)
                self.log(gpType.typeName)
                if let gps = gpType.gamePlatforms {
                    for gp in gps {
                        self.log(gp)
                    }
                }
            }
        }, onFail: logApiResult))
        
        //GetDownloadAppList
        _ = getDownloadAppList.addListener(ApiListener<ApiAction.GetDownloadAppList.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetActivitiesContent
        _ = getActivitiesContent.addListener(ApiListener<ApiAction.GetActivitiesContent.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetClientInfo
        _ = getClientInfo.addListener(ApiListener<ApiAction.GetClientInfo.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetRegisterInfo
        _ = getRegisterInfo.addListener(ApiListener<ApiAction.GetRegisterInfo.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //RegisterAccount
        _ = registerAccount.addListener(ApiListener<ApiAction.RegisterAccount.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //Logout
        _ = logout.addListener(ApiListener<ApiAction.Logout.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetActivitiesInfo
        _ = getActivitiesInfo.addListener(ApiListener<ApiAction.GetActivitiesInfo.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetMemberInfo
        _ = getMemberInfo.addListener(ApiListener<ApiAction.GetMemberInfo.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetBonus
        _ = getBonus.addListener(ApiListener<ApiAction.GetBonus.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetBankDictionary
        _ = getBankDictionary.addListener(ApiListener<ApiAction.GetBankDictionary.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetWithdrawBanksList
        _ = getWithdrawBanksList.addListener(ApiListener<ApiAction.GetWithdrawBanksList.Result>.init(onSuccess: logApiResult, onFail: logApiResult))

        //AddBankCard
        _ = addBankCard.addListener(ApiListener<ApiAction.AddBankCard.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //SubmitWithdraw
        _ = submitWithdraw.addListener(ApiListener<ApiAction.SubmitWithdraw.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //ApplyActivities
        _ = applyActivities.addListener(ApiListener<ApiAction.ApplyActivities.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetDepositHistory
        _ = getDepositHistory.addListener(ApiListener<ApiAction.GetDepositHistory.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetTransferHistory
        _ = getTransferHistory.addListener(ApiListener<ApiAction.GetTransferHistory.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetWithdrawHistory
        _ = getWithdrawHistory.addListener(ApiListener<ApiAction.GetWithdrawHistory.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetMessageHistory
        _ = getMessageHistory.addListener(ApiListener<ApiAction.GetMessageHistory.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetBetHistory
        _ = getBetHistory.addListener(ApiListener<ApiAction.GetBetHistory.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GameTransferOnEnter
        _ = gameTransferOnEnter.addListener(ApiListener<ApiAction.GameTransferOnEnter.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //GetGameUrl
        _ = getGameUrl.addListener(ApiListener<ApiAction.GetGameUrl.Result>.init(onSuccess: logApiResult, onFail: logApiResult))
        
        //KzPlatformApp
        _ = thirdPartyApp?.addListener(KzPlatformAppListener<KzPlatformAppResultProtocol>.init(onSuccess: { result in
            print(result)
        }, onFail: { result in
            print(result)
        }))
    }
    
    public func log(_ object: Any?, padding: String = "") {
        if let object = object {
            print("\(padding)\(object)")
        }else{
            print("\(padding)nil")
        }
    }
    
    public func logApiResult(_ result: ApiResultProtocol) {
        self.log(result)
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Login is not required (\(apiActionsNotRequireLogin.count))"
        case 1:
            return "Login is optional (\(apiActionsOptionalLogin.count))"
        case 2:
            return "Login is not required (\(apiActionsRequireLogin.count))"
        default:
            return nil
        }
    }
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        if !logined {
            return 2
        }
        return 3
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return apiActionsNotRequireLogin.count
        case 1:
            return apiActionsOptionalLogin.count
        case 2:
            return apiActionsRequireLogin.count
        default:
            return 0
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var apiActions: [KzApi]
        switch indexPath.section {
        case 0:
            apiActions = apiActionsNotRequireLogin
        case 1:
            apiActions = apiActionsOptionalLogin
        case 2:
            apiActions = apiActionsRequireLogin
        default:
            apiActions = []
        }
        
        let apiAction = apiActions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = String(describing: apiAction.self).replacingOccurrences(of: "KzSDK_Swift.", with: "")
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let action = apiActions[indexPath.section][indexPath.row]
        action.post()
    }
}
