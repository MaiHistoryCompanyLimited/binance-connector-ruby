# frozen_string_literal: true

module Binance
  class Spot
    # all sub-account endpoints
    # @see https://developers.binance.com/docs/sub_account/Introduction
    module Subaccount
      # Create a Virtual Sub-account(For Master Account)
      #
      # POST /sapi/v1/sub-account/virtualSubAccount
      #
      # This request will generate a virtual sub account under your master account.<br>
      # You need to enable "trade" option for the api key which requests this endpoint.
      #
      # @param subAccountString [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/account-management/Create-a-Virtual-Sub-account
      def create_virtual_sub_account(subAccountString:, **kwargs)
        Binance::Utils::Validation.require_param('subAccountString', subAccountString)

        @session.sign_request(:post, '/sapi/v1/sub-account/virtualSubAccount', params: kwargs.merge(
          subAccountString: subAccountString
        ))
      end

      # Query Sub-account List (For Master Account)
      #
      # GET /sapi/v1/sub-account/list
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :email Sub-account email
      # @option kwargs [String] :isFreeze true or false
      # @option kwargs [Integer] :page
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/account-management/Query-Sub-account-List
      def get_sub_account_list(**kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/list', params: kwargs)
      end

      # Query Sub-account Spot Asset Transfer History (For Master Account)
      #
      # GET /sapi/v1/sub-account/sub/transfer/history
      #
      # fromEmail and toEmail cannot be sent at the same time.<br>
      # Return fromEmail equal master account email by default.
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :fromEmail Sub-account email
      # @option kwargs [String] :toEmail Sub-account email
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :page Default value: 1
      # @option kwargs [Integer] :limit Default value: 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Query-Sub-account-Spot-Asset-Transfer-History
      def get_sub_account_spot_transfer_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/sub/transfer/history', params: kwargs)
      end

      # Query Sub-account Futures Asset Transfer History (For Master Account)
      #
      # GET /sapi/v1/sub-account/futures/internalTransfer
      #
      # @param email [String]
      # @param futuresType [Integer] 1:USDT-margined Futures, 2: Coin-margined Futures
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime Default return the history with in 100 days
      # @option kwargs [Integer] :endTime Default return the history with in 100 days
      # @option kwargs [Integer] :page Default value: 1
      # @option kwargs [Integer] :limit Default value: 50, Max value: 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Query-Sub-account-Futures-Asset-Transfer-History
      def get_sub_account_futures_transfer_history(email:, futuresType:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('futuresType', futuresType)

        @session.sign_request(:get, '/sapi/v1/sub-account/futures/internalTransfer', params: kwargs.merge(
          email: email,
          futuresType: futuresType
        ))
      end

      # Sub-account Futures Asset Transfer (For Master Account)
      #
      # POST /sapi/v1/sub-account/futures/internalTransfer
      #
      # @param fromEmail [String]
      # @param toEmail [String]
      # @param futuresType [Integer] 1:USDT-margined Futures, 2: Coin-margined Futures
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Sub-account-Futures-Asset-Transfer
      def sub_account_futures_internal_transfer(fromEmail:, toEmail:, futuresType:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('fromEmail', fromEmail)
        Binance::Utils::Validation.require_param('toEmail', toEmail)
        Binance::Utils::Validation.require_param('futuresType', futuresType)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/sub-account/futures/internalTransfer', params: kwargs.merge(
          fromEmail: fromEmail,
          toEmail: toEmail,
          futuresType: futuresType,
          asset: asset,
          amount: amount
        ))
      end

      # Query Sub-account Assets (For Master Account)
      #
      # GET /sapi/v3/sub-account/assets
      #
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Query-Sub-account-Assets-V3
      def get_sub_account_assets(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v3/sub-account/assets', params: kwargs.merge(email: email))
      end

      # Query Sub-account Assets (For Master Account)(USER_DATA)
      #
      # GET /sapi/v4/sub-account/assets
      #
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Query-Sub-account-Assets-V4
      def get_sub_account_assets_v4(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v4/sub-account/assets', params: kwargs.merge(email: email))
      end

      # Query Sub-account Spot Assets Summary (For Master Account)
      #
      # GET /sapi/v1/sub-account/spotSummary
      #
      # Get BTC valued asset summary of subaccounts.
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :email
      # @option kwargs [Integer] :page Default value: 1
      # @option kwargs [Integer] :size default 10, max 20
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Query-Sub-account-Spot-Assets-Summary
      def get_sub_account_spot_summary(**kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/spotSummary', params: kwargs)
      end

      # Get Sub-account Deposit Address (For Master Account)
      #
      # GET /sapi/v1/capital/deposit/subAddress
      #
      # Fetch sub-account deposit address
      #
      # @param email [String]
      # @param coin [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :network
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Get-Sub-account-Deposit-Address
      def sub_account_deposit_address(email:, coin:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('coin', coin)

        @session.sign_request(:get, '/sapi/v1/capital/deposit/subAddress', params: kwargs.merge(
          email: email,
          coin: coin
        ))
      end

      # Get Sub-account Deposit History (For Master Account)
      #
      # GET /sapi/v1/capital/deposit/subHisrec
      #
      # Fetch sub-account deposit history
      #
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [String] :status
      # @option kwargs [String] :startTime
      # @option kwargs [String] :endTime
      # @option kwargs [String] :limit
      # @option kwargs [String] :offset
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Get-Sub-account-Deposit-History
      def sub_account_deposit_history(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v1/capital/deposit/subHisrec', params: kwargs.merge(
          email: email
        ))
      end

      # Get Sub-account's Status on Margin/Futures(For Master Account)
      #
      # GET /sapi/v1/sub-account/status
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :email
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/account-management/Get-Sub-accounts-Status-on-Margin-Or-Futures
      def sub_account_status(**kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/status', params: kwargs)
      end

      # Enable Margin for Sub-account (For Master Account)
      #
      # POST /sapi/v1/sub-account/margin/enable
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :email
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/account-management/Enable-Margin-for-Sub-account
      def sub_account_enable_margin(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:post, '/sapi/v1/sub-account/margin/enable', params: kwargs.merge(
          email: email
        ))
      end

      # Enable Options for Sub-account(For Master Account)(USER_DATA)
      #
      # POST /sapi/v1/sub-account/eoptions/enable
      #
      # @param email [String] Sub user email
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/account-management/Enable-Options-for-Sub-account
      def sub_account_enable_options(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:post, '/sapi/v1/sub-account/eoptions/enable', params: kwargs.merge(
          email: email
        ))
      end

      # Get Detail on Sub-account's Margin Account (For Master Account)
      #
      # GET /sapi/v1/sub-account/margin/account
      #
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Get-Detail-on-Sub-accounts-Margin-Account
      def sub_account_margin_account(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v1/sub-account/margin/account', params: kwargs.merge(
          email: email
        ))
      end

      # Get Summary of Sub-account's Margin Account (For Master Account)
      #
      # GET /sapi/v1/sub-account/margin/accountSummary
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Get-Summary-of-Sub-accounts-Margin-Account
      def sub_account_margin_account_summary(**kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/margin/accountSummary', params: kwargs)
      end

      # Enable Futures for Sub-account (For Master Account)
      #
      # POST /sapi/v1/sub-account/futures/enable
      #
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/account-management/Enable-Futures-for-Sub-account
      def sub_account_enable_futures(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:post, '/sapi/v1/sub-account/futures/enable', params: kwargs.merge(
          email: email
        ))
      end

      # Get Detail on Sub-account's Futures Account (For Master Account)
      #
      # GET /sapi/v2/sub-account/futures/account
      #
      # @param email [String]
      # @param futuresType [Integer] 1:USDT Margined Futures, 2:COIN Margined Futures
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Get-Detail-on-Sub-accounts-Futures-Account-V2
      def sub_account_futures_account(email:, futuresType:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('futuresType', futuresType)

        @session.sign_request(:get, '/sapi/v2/sub-account/futures/account', params: kwargs.merge(
          email: email,
          futuresType: futuresType
        ))
      end

      # Get Summary of Sub-account's Futures Account (For Master Account)
      #
      # GET /sapi/v2/sub-account/futures/accountSummary
      #
      # @param futuresType [Integer] 1:USDT Margined Futures, 2:COIN Margined Futures
      # @param kwargs [Hash]
      # @option kwargs [Integer] :page  default:1
      # @option kwargs [Integer] :limit default:10, max:20
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Get-Summary-of-Sub-accounts-Futures-Account-V2
      def sub_account_futures_account_summary(futuresType:, **kwargs)
        Binance::Utils::Validation.require_param('futuresType', futuresType)

        @session.sign_request(:get, '/sapi/v2/sub-account/futures/accountSummary', params: kwargs.merge(
          futuresType: futuresType
        ))
      end

      # Get Futures Position-Risk of Sub-account (For Master Account)
      #
      # GET /sapi/v2/sub-account/futures/positionRisk
      #
      # @param email [String]
      # @param futuresType [Integer] 1:USDT Margined Futures, 2:COIN Margined Futures
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/account-management/Get-Futures-Position-Risk-of-Sub-account-V2
      def sub_account_futures_position_risk(email:, futuresType:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('futuresType', futuresType)

        @session.sign_request(:get, '/sapi/v2/sub-account/futures/positionRisk', params: kwargs.merge(
          email: email,
          futuresType: futuresType
        ))
      end

      # Query Sub-account Transaction Statistics(For Master Account)(USER_DATA)
      #
      # GET /sapi/v1/sub-account/transaction-statistics
      #
      # @param email [String] Sub user email
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/account-management/Query-Sub-account-Transaction-Statistics
      def sub_account_transaction_statistics(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v1/sub-account/transaction-statistics', params: kwargs.merge(
          email: email
        ))
      end

      # Futures Transfer for Sub-account(For Master Account)
      #
      # POST /sapi/v1/sub-account/futures/transfer
      #
      # @param email [String]
      # @param asset [String]
      # @param amount [Float]
      # @param type [Integer] 1: transfer from subaccount's spot account to its USDT-margined futures account<br>
      #    2: transfer from subaccount's USDT-margined futures account to its spot account<br>
      #    3: transfer from subaccount's spot account to its COIN-margined futures account<br>
      #    4:transfer from subaccount's COIN-margined futures account to its spot account
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Futures-Transfer-for-Sub-account
      def sub_account_futures_transfer(email:, asset:, amount:, type:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/sub-account/futures/transfer', params: kwargs.merge(
          email: email,
          asset: asset,
          amount: amount,
          type: type
        ))
      end

      # Margin Transfer for Sub-account(For Master Account)
      #
      # POST /sapi/v1/sub-account/margin/transfer
      #
      # @param email [String]
      # @param asset [String]
      # @param amount [Float]
      # @param type [Integer] 1: transfer from subaccount's spot account to margin account<br>
      #    2: transfer from subaccount's margin account to its spot account
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Margin-Transfer-for-Sub-account
      def sub_account_margin_transfer(email:, asset:, amount:, type:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/sub-account/margin/transfer', params: kwargs.merge(
          email: email,
          asset: asset,
          amount: amount,
          type: type
        ))
      end

      # Transfer to Sub-account of Same Master(For Sub-account)
      #
      # POST /sapi/v1/sub-account/transfer/subToSub
      #
      # @param toEmail [String]
      # @param asset [String]
      # @param amount [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Transfer-to-Sub-account-of-Same-Master
      def sub_account_transfer_to_sub(toEmail:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('toEmail', toEmail)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/sub-account/transfer/subToSub', params: kwargs.merge(
          toEmail: toEmail,
          asset: asset,
          amount: amount
        ))
      end

      # Transfer to Sub-account of Same Master(For Sub-account)
      #
      # POST /sapi/v1/sub-account/transfer/subToMaster
      #
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Transfer-to-Master
      def sub_account_transfer_to_master(asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/sub-account/transfer/subToMaster', params: kwargs.merge(
          asset: asset,
          amount: amount
        ))
      end

      # Sub-account Transfer History (For Sub-account)
      #
      # GET /sapi/v1/sub-account/transfer/subUserHistory
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :type 1: transfer in, 2: transfer out
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Sub-account-Transfer-History
      def sub_account_transfer_sub_account_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/transfer/subUserHistory', params: kwargs)
      end

      # Universal Transfer (For Master Account)
      #
      # POST /sapi/v1/sub-account/universalTransfer
      #
      # You need to enable "internal transfer" option for the api key which requests this endpoint.<br>
      # Transfer between futures accounts is not supported.
      #
      # @param fromAccountType [String] "SPOT","USDT_FUTURE","COIN_FUTURE"
      # @param toAccountType [String] "SPOT","USDT_FUTURE","COIN_FUTURE"
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :fromEmail Transfer from master account by default if fromEmail is not sent.
      # @option kwargs [String] :toEmail Transfer to master account by default if toEmail is not sent.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Universal-Transfer
      def universal_transfer(fromAccountType:, toAccountType:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('fromAccountType', fromAccountType)
        Binance::Utils::Validation.require_param('toAccountType', toAccountType)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/sub-account/universalTransfer', params: kwargs.merge(
          fromAccountType: fromAccountType,
          toAccountType: toAccountType,
          asset: asset,
          amount: amount
        ))
      end

      # Query Universal Transfer History (For Master Account)
      #
      # GET /sapi/v1/sub-account/universalTransfer
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :fromEmail
      # @option kwargs [String] :toEmail
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :page
      # @option kwargs [Integer] :limit Default 500, Max 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/asset-management/Query-Universal-Transfer-History
      def universal_transfer_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/universalTransfer', params: kwargs)
      end

      # Enable Leverage Token for Sub-account (For Master Account)
      #
      # POST /sapi/v1/sub-account/blvt/enable
      #
      # @param email [String]
      # @param enableBlvt [Boolean] Only true for now
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/account-management/Enable-Leverage-Token-for-Sub-account
      def sub_account_enable_blvt(email:, enableBlvt:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('enableBlvt', enableBlvt)

        @session.sign_request(:post, '/sapi/v1/sub-account/blvt/enable', params: kwargs.merge(
          email: email,
          enableBlvt: enableBlvt
        ))
      end

      # Deposit assets into the managed sub-account (For Investor Master Account)
      #
      # POST /sapi/v1/managed-subaccount/deposit
      #
      # @param toEmail [String]
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/managed-sub-account/Deposit-Assets-Into-The-Managed-Sub-account
      def deposit_to_sub_account(toEmail:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('toEmail', toEmail)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/managed-subaccount/deposit', params: kwargs.merge(
          toEmail: toEmail,
          asset: asset,
          amount: amount
        ))
      end

      # Query managed sub-account asset details (For Investor Master Account)
      #
      # GET /sapi/v1/managed-subaccount/asset
      #
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/managed-sub-account/Query-Managed-Sub-account-Asset-Details
      def sub_account_asset_details(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v1/managed-subaccount/asset', params: kwargs.merge(email: email))
      end

      # Query Managed Sub-account Margin Asset Details(For Investor Master Account)(USER_DATA)
      #
      # GET /sapi/v1/managed-subaccount/marginAsset
      #
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :accountType No input or input "MARGIN" to get Cross Margin account details. Input "ISOLATED_MARGIN" to get Isolated Margin account details.
      # @see https://developers.binance.com/docs/sub_account/managed-sub-account/Query-Managed-Sub-account-Margin-Asset-Details
      def sub_account_margin_asset_details(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v1/managed-subaccount/marginAsset', params: kwargs.merge(email: email))
      end

      # Query Managed Sub-account Futures Asset Details(For Investor Master Account)(USER_DATA)
      #
      # GET /sapi/v1/managed-subaccount/fetch-future-asset
      #
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :accountType No input or input "USDT_FUTURE" to get UM Futures account details. Input "COIN_FUTURE" to get CM Futures account details.
      # @see https://developers.binance.com/docs/sub_account/managed-sub-account/Query-Managed-Sub-account-Futures-Asset-Details
      def sub_account_futures_asset_details(email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v1/managed-subaccount/fetch-future-asset', params: kwargs.merge(email: email))
      end

      # Withdrawl assets from the managed sub-account (For Investor Master Account)
      #
      # POST /sapi/v1/managed-subaccount/withdraw
      #
      # @param fromEmail  [String]
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :transferDate
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/managed-sub-account/Withdrawl-Assets-From-The-Managed-Sub-account
      def withdraw_from_sub_account(fromEmail:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('fromEmail', fromEmail)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/managed-subaccount/withdraw', params: kwargs.merge(
          fromEmail: fromEmail,
          asset: asset,
          amount: amount
        ))
      end

      # Query Managed Sub Account Transfer Log(For Trading Team Master Account)(USER_DATA)
      #
      # GET /sapi/v1/managed-subaccount/queryTransLogForTradeParent
      #
      # @param email [String] Managed Sub Account Email
      # @param startTime [Integer]
      # @param endTime [Integer]
      # @param page [Integer]
      # @param limit [Integer] Limit (Max: 500)
      # @param kwargs [Hash]
      # @option kwargs [String] :transfers Transfer Direction (FROM/TO)
      # @option kwargs [String] :transferFunctionAccountType Transfer function account type (SPOT/MARGIN/ISOLATED_MARGIN/USDT_FUTURE/COIN_FUTURE)
      # @see https://developers.binance.com/docs/sub_account/managed-sub-account/Query-Managed-Sub-Account-Transfer-Log-Trading-Team-Master
      def sub_account_transfer_log(email:, startTime:, endTime:, page:, limit:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('startTime', startTime)
        Binance::Utils::Validation.require_param('endTime', endTime)
        Binance::Utils::Validation.require_param('page', page)
        Binance::Utils::Validation.require_param('limit', limit)

        @session.sign_request(:get, '/sapi/v1/managed-subaccount/queryTransLogForTradeParent', params: kwargs.merge(
          email: email,
          startTime: startTime,
          endTime: endTime,
          page: page,
          limit: limit
        ))
      end

      # Query Managed Sub Account Transfer Log (For Trading Team Sub Account)(USER_DATA)
      #
      # GET /sapi/v1/managed-subaccount/query-trans-log
      #
      # @param startTime [Integer]
      # @param endTime [Integer]
      # @param page [Integer]
      # @param limit [Integer] Limit (Max: 500)
      # @param kwargs [Hash]
      # @option kwargs [String] :transfers Transfer Direction (FROM/TO)
      # @option kwargs [String] :transferFunctionAccountType Transfer function account type (SPOT/MARGIN/ISOLATED_MARGIN/USDT_FUTURE/COIN_FUTURE)
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/managed-sub-account/Query-Managed-Sub-Account-Transfer-Log-Trading-Team-Sub
      def sub_account_transfer_log_sub_account(startTime:, endTime:, page:, limit:, **kwargs)
        Binance::Utils::Validation.require_param('startTime', startTime)
        Binance::Utils::Validation.require_param('endTime', endTime)
        Binance::Utils::Validation.require_param('page', page)
        Binance::Utils::Validation.require_param('limit', limit)

        @session.sign_request(:get, '/sapi/v1/managed-subaccount/query-trans-log', params: kwargs.merge(
          startTime: startTime,
          endTime: endTime,
          page: page,
          limit: limit
        ))
      end

      # Query Managed Sub Account Transfer Log (For Investor Master Account)(USER_DATA)
      #
      # GET /sapi/v1/managed-subaccount/queryTransLogForInvestor
      #
      # @param email [String] Managed Sub Account Email
      # @param startTime [Integer]
      # @param endTime [Integer]
      # @param page [Integer]
      # @param limit [Integer] Limit (Max: 500)
      # @param kwargs [Hash]
      # @option kwargs [String] :transfers Transfer Direction (FROM/TO)
      # @option kwargs [String] :transferFunctionAccountType Transfer function account type (SPOT/MARGIN/ISOLATED_MARGIN/USDT_FUTURE/COIN_FUTURE)
      # @see https://developers.binance.com/docs/sub_account/managed-sub-account/Query-Managed-Sub-Account-Transfer-Log-Investor
      def sub_account_transfer_log_investor(email:, startTime:, endTime:, page:, limit:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('startTime', startTime)
        Binance::Utils::Validation.require_param('endTime', endTime)
        Binance::Utils::Validation.require_param('page', page)
        Binance::Utils::Validation.require_param('limit', limit)

        @session.sign_request(:get, '/sapi/v1/managed-subaccount/queryTransLogForInvestor', params: kwargs.merge(
          email: email,
          startTime: startTime,
          endTime: endTime,
          page: page,
          limit: limit
        ))
      end

      # Query Managed Sub-account List (For Investor)(USER_DATA)
      #
      # GET /sapi/v1/managed-subaccount/info
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :email Status Managed sub-account email
      # @option kwargs [Integer] :page Default: 1
      # @option kwargs [Integer] :limit Default: 10, Max: 20
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/managed-sub-account/Query-Managed-Sub-account-List
      def sub_account_list(**kwargs)
        @session.sign_request(:get, '/sapi/v1/managed-subaccount/info', params: kwargs)
      end

      # Enable or Disable IP Restriction for a Sub-account API Key (For Master Account)
      #
      # POST /sapi/v2/sub-account/subAccountApi/ipRestriction
      #
      # @param email  [String]
      # @param subAccountApiKey [String]
      # @param status [String]
      # @option kwargs [String] :ipAddress Insert static IP in batch, separated by commas.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/api-management/Add-IP-Restriction-for-Sub-Account-API-key
      def sub_account_toggle_ip_restriction(email:, subAccountApiKey:, status:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('subAccountApiKey', subAccountApiKey)
        Binance::Utils::Validation.require_param('status', status)

        @session.sign_request(:post, '/sapi/v2/sub-account/subAccountApi/ipRestriction', params: kwargs.merge(
          email: email,
          subAccountApiKey: subAccountApiKey,
          status: status
        ))
      end

      # Get IP Restriction for a Sub-account API Key (For Master Account)
      #
      # GET /sapi/v1/sub-account/subAccountApi/ipRestriction
      #
      # @param email  [String]
      # @param subAccountApiKey [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/api-management/Get-IP-Restriction-for-a-Sub-account-API-Key
      def sub_account_ip_list(email:, subAccountApiKey:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('subAccountApiKey', subAccountApiKey)

        @session.sign_request(:get, '/sapi/v1/sub-account/subAccountApi/ipRestriction', params: kwargs.merge(
          email: email,
          subAccountApiKey: subAccountApiKey
        ))
      end

      # Delete IP List For a Sub-account API Key (For Master Account)
      #
      # DELETE /sapi/v1/sub-account/subAccountApi/ipRestriction/ipList
      #
      # @param email  [String]
      # @param subAccountApiKey [String]
      # @param ipAddress [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/sub_account/api-management/Get-IP-Restriction-for-a-Sub-account-API-Key
      def sub_account_delete_ip_list(email:, subAccountApiKey:, ipAddress:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('subAccountApiKey', subAccountApiKey)
        Binance::Utils::Validation.require_param('ipAddress', ipAddress)

        @session.sign_request(:delete, '/sapi/v1/sub-account/subAccountApi/ipRestriction/ipList', params: kwargs.merge(
          email: email,
          subAccountApiKey: subAccountApiKey,
          ipAddress: ipAddress
        ))
      end
    end
  end
end
