# frozen_string_literal: true

module Binance
  class Spot
    # Margin endpoints
    # @see https://developers.binance.com/docs/margin_trading/Introduction
    module Margin
      # Get All Margin Assets (MARKET_DATA)
      #
      # GET /sapi/v1/margin/allAssets
      #
      # @see https://developers.binance.com/docs/margin_trading/market-data/Get-All-Margin-Assets
      def margin_all_assets
        @session.limit_request(path: '/sapi/v1/margin/allAssets')
      end

      # Get All Margin Pairs (MARKET_DATA)
      #
      # GET /sapi/v1/margin/allPairs
      #
      # @see https://developers.binance.com/docs/margin_trading/market-data/Get-All-Cross-Margin-Pairs
      def margin_all_pairs
        @session.limit_request(path: '/sapi/v1/margin/allPairs')
      end

      # Query Margin PriceIndex (MARKET_DATA)
      #
      # GET /sapi/v1/margin/priceIndex
      #
      # @see https://developers.binance.com/docs/margin_trading/market-data/Query-Margin-PriceIndex
      def margin_price_index(symbol:)
        Binance::Utils::Validation.require_param('symbol', symbol)
        @session.limit_request(path: '/sapi/v1/margin/priceIndex', params: { symbol: symbol })
      end

      # Query Margin Available Inventory(USER_DATA)
      #
      # GET /sapi/v1/margin/available-inventory
      #
      # @param type [String] MARGIN or ISOLATED
      # @see https://developers.binance.com/docs/margin_trading/market-data/Query-margin-avaliable-inventory
      def margin_available_inventory(type:)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:get, '/sapi/v1/margin/available-inventory', params: { type: type })
      end

      # Query Liability Coin Leverage Bracket in Cross Margin Pro Mode(MARKET_DATA)
      #
      # GET /sapi/v1/margin/leverageBracket
      #
      # @see https://developers.binance.com/docs/margin_trading/market-data/Query-Liability-Coin-Leverage-Bracket-in-Cross-Margin-Pro-Mode
      def margin_leverage_bracket
        @session.limit_request(path: '/sapi/v1/margin/leverageBracket')
      end

      # Margin Account New Order (TRADE)
      #
      # POST /sapi/v1/margin/order
      #
      # @param symbol [String]
      # @param side [String]
      # @param type [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [Float] :quantity
      # @option kwargs [Float] :quoteOrderQty
      # @option kwargs [Float] :price
      # @option kwargs [Float] :stopPrice Used with STOP_LOSS, STOP_LOSS_LIMIT, TAKE_PROFIT, and TAKE_PROFIT_LIMIT orders.
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Float] :icebergQty Used with LIMIT, STOP_LOSS_LIMIT, and TAKE_PROFIT_LIMIT to create an iceberg order.
      # @option kwargs [String] :newOrderRespType
      # @option kwargs [String] :sideEffectType NO_SIDE_EFFECT, MARGIN_BUY, AUTO_REPAY; default NO_SIDE_EFFECT.
      # @option kwargs [String] :timeInForce GTC,IOC,FOK
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Margin-Account-New-Order
      def margin_new_order(symbol:, side:, type:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/margin/order', params: kwargs.merge(
          symbol: symbol,
          side: side,
          type: type
        ))
      end

      # Margin Account Cancel Order (TRADE)
      #
      # DELETE /sapi/v1/margin/order
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [String] :orderId
      # @option kwargs [String] :origClientOrderId
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Margin-Account-New-Order
      def margin_cancel_order(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/sapi/v1/margin/order', params: kwargs.merge(
          symbol: symbol
        ))
      end

      # Margin Account Cancel all Open Orders on a Symbol (TRADE)
      #
      # DELETE /sapi/v1/margin/openOrders
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Margin-Account-Cancel-All-Open-Orders
      def margin_cancel_all_order(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/sapi/v1/margin/openOrders', params: kwargs.merge(
          symbol: symbol
        ))
      end

      # Get Cross Margin Transfer History (USER_DATA)
      #
      # GET /sapi/v1/margin/transfer
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :type
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [String] :archived Default: false. Set to true for archived data from 6 months ago
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/transfer/Get-Cross-Margin-Transfer-History
      def margin_transfer_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/transfer', params: kwargs)
      end

      # Get Interest History (USER_DATA)
      #
      # GET /sapi/v1/margin/interestHistory
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [String] :archived Default: false. Set to true for archived data from 6 months ago
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/borrow-and-repay/Get-Interest-History
      def margin_interest_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/interestHistory', params: kwargs)
      end

      # Margin account borrow/repay (MARGIN)
      #
      # POST /sapi/v1/margin/borrow-repay
      #
      # @param asset [String]
      # @param isIsolated [String] TRUE for Isolated Margin, FALSE for Cross Margin, Default FALSE
      # @param symbol [String]
      # @param amount [String]
      # @param type [String] BORROW, REPAY
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/borrow-and-repay/Margin-Account-Borrow-Repay
      def margin_borrow_repay(asset:, isIsolated:, symbol:, amount:, type:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('isIsolated', isIsolated)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/margin/borrow-repay', params: kwargs.merge(
          asset: asset,
          isIsolated: isIsolated,
          symbol: symbol,
          amount: amount,
          type: type
        ))
      end

      # Query borrow/repay records in Margin account (USER_DATA)
      #
      # GET /sapi/v1/margin/borrow-repay
      #
      # @param type [String] BORROW or REPAY
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :isIsolated
      # @option kwargs [String] :txId
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/borrow-and-repay/Query-Borrow-Repay
      def margin_borrow_repay_record(type:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:get, '/sapi/v1/margin/borrow-repay', params: kwargs.merge(type: type))
      end

      # Get Force Liquidation Record (USER_DATA)
      #
      # GET /sapi/v1/margin/forceLiquidationRec
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Get-Force-Liquidation-Record
      def margin_force_liquidation_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/forceLiquidationRec', params: kwargs)
      end

      # Query Cross Margin Account Details (USER_DATA)
      #
      # GET /sapi/v1/margin/account
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Query-Cross-Margin-Account-Details
      def margin_account(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/account', params: kwargs)
      end

      # Query Margin Account's Order (USER_DATA)
      #
      # GET /sapi/v1/margin/order
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [Integer] :orderId
      # @option kwargs [String] :origClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Query-Margin-Account-Order
      def margin_order(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/sapi/v1/margin/order', params: kwargs.merge(symbol: symbol))
      end

      # Query Margin Account's Open Order (USER_DATA)
      #
      # GET /sapi/v1/margin/openOrders
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Query-Margin-Account-Open-Orders
      def margin_open_orders(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/openOrders', params: kwargs)
      end

      # Query Margin Account's All Order (USER_DATA)
      #
      # GET /sapi/v1/margin/allOrders
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [String] :orderId
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit Default 500; max 1000.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Query-Margin-Account-All-Orders
      def margin_all_orders(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/sapi/v1/margin/allOrders', params: kwargs.merge(symbol: symbol))
      end

      # Margin Account New OCO (TRADE)
      #
      # POST /sapi/v1/margin/order/oco
      #
      # @param symbol [String]
      # @param side [String]
      # @param quantity [Float]
      # @param price [Float]
      # @param stopPrice [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [String] :listClientOrderId
      # @option kwargs [String] :limitClientOrderId
      # @option kwargs [Float] :limitIcebergQty
      # @option kwargs [String] :stopClientOrderId
      # @option kwargs [Float] :stopLimitPrice If provided, stopLimitTimeInForce is required.
      # @option kwargs [Float] :stopIcebergQty
      # @option kwargs [String] :stopLimitTimeInForce Valid values are GTC/FOK/IOC
      # @option kwargs [String] :newOrderRespType
      # @option kwargs [String] :sideEffectType NO_SIDE_EFFECT, MARGIN_BUY, AUTO_REPAY; default NO_SIDE_EFFECT.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Margin-Account-New-OCO
      def margin_oco_order(symbol:, side:, quantity:, price:, stopPrice:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('quantity', quantity)
        Binance::Utils::Validation.require_param('price', price)
        Binance::Utils::Validation.require_param('stopPrice', stopPrice)

        @session.sign_request(:post, '/sapi/v1/margin/order/oco', params: kwargs.merge(
          symbol: symbol,
          side: side,
          quantity: quantity,
          price: price,
          stopPrice: stopPrice
        ))
      end

      # Margin Account Cancel OCO (TRADE)
      #
      # DELETE /sapi/v1/margin/orderList
      #
      # Canceling an individual leg will cancel the entire OCO
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated
      # @option kwargs [Integer] :orderListId Either orderListId or listClientOrderId must be provided
      # @option kwargs [String] :listClientOrderId Either orderListId or listClientOrderId must be provided
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Margin-Account-Cancel-OCO
      def margin_cancel_oco(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/sapi/v1/margin/orderList', params: kwargs.merge(
          symbol: symbol
        ))
      end

      # Query Margin Account's OCO (USER_DATA)
      #
      # GET /sapi/v1/margin/orderList
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [String] :isIsolated
      # @option kwargs [Integer] :orderListId Either orderListId or origClientOrderId must be provided
      # @option kwargs [String] :origClientOrderId Either orderListId or origClientOrderId must be provided
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Query-Margin-Account-OCO
      def margin_get_oco(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/orderList', params: kwargs)
      end

      # Query Margin Account's all OCO (USER_DATA)
      #
      # GET /sapi/v1/margin/allOrderList
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [String] :isIsolated
      # @option kwargs [Integer] :fromId If supplied, neither startTime nor endTime can be provided
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Query-Margin-Account-All-OCO
      def margin_get_all_oco(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/allOrderList', params: kwargs)
      end

      # Query Margin Account's Open OCO (USER_DATA)
      #
      # GET /sapi/v1/margin/openOrderList
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [String] :isIsolated
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Query-Margin-Account-Open-OCO
      def margin_get_open_oco(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/openOrderList', params: kwargs)
      end

      # Query Margin Account's Trade List (USER_DATA)
      #
      # GET /sapi/v1/margin/myTrades
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [String] :orderfromIdId
      # @option kwargs [Integer] :limit Default 500; max 1000.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Query-Margin-Account-Trade-List
      def margin_my_trades(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/sapi/v1/margin/myTrades', params: kwargs.merge(symbol: symbol))
      end

      # Margin Manual Liquidation
      #
      # POST /sapi/v1/margin/manual-liquidation
      #
      # @param type [String] MARGIN or ISOLATED
      # @param kwargs [Hash]
      # @param kwargs [String] :symbol When type selects ISOLATED, symbol must be filled in
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/trade/Margin-Manual-Liquidation
      def margin_manual_liquidation(type:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/margin/manual-liquidation', params: kwargs.merge(type: type))
      end

      # Query Max Borrow (USER_DATA)
      #
      # GET /sapi/v1/margin/maxBorrowable
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/borrow-and-repay/Query-Max-Borrow
      def margin_max_borrowable(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/margin/maxBorrowable', params: kwargs.merge(asset: asset))
      end

      # Query Max Transfer-Out Amount (USER_DATA)
      #
      # GET /sapi/v1/margin/maxTransferable
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/transfer/Query-Max-Transfer-Out-Amount
      def margin_max_transferable(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/margin/maxTransferable', params: kwargs.merge(asset: asset))
      end

      # Query Isolated Margin Account Info (USER_DATA)
      #
      # GET /sapi/v1/margin/isolated/account
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbols Max 5 symbols can be sent; separated by ",". e.g. "BTCUSDT,BNBUSDT,ADAUSDT"
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Query-Isolated-Margin-Account-Info
      def get_isolated_margin_account(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/isolated/account', params: kwargs)
      end

      # Disable Isolated Margin Account (TRADE)
      #
      # DELETE /sapi/v1/margin/isolated/account
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Disable-Isolated-Margin-Account
      def disable_isolated_margin_account(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/sapi/v1/margin/isolated/account', params: kwargs.merge(symbol: symbol))
      end

      # Enable Isolated Margin Account (TRADE)
      #
      # POST /sapi/v1/margin/isolated/account
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Enable-Isolated-Margin-Account
      def enable_isolated_margin_account(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:post, '/sapi/v1/margin/isolated/account', params: kwargs.merge(symbol: symbol))
      end

      # Query Enabled Isolated Margin Account Limit (USER_DATA)
      #
      # GET /sapi/v1/margin/isolated/accountLimit
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Query-Enabled-Isolated-Margin-Account-Limit
      def get_isolated_margin_account_limit(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/isolated/accountLimit', params: kwargs)
      end

      # Get All Isolated Margin Symbol(USER_DATA)
      #
      # GET /sapi/v1/margin/isolated/allPairs
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/market-data/Get-All-Isolated-Margin-Symbol
      def get_all_isolated_margin_pairs(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/isolated/allPairs', params: kwargs)
      end

      # Toggle BNB Burn On Spot Trade And Margin Interest (USER_DATA)
      #
      # POST /sapi/v1/bnbBurn
      #
      # "spotBNBBurn" and "interestBNBBurn" should be sent at least one.
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :spotBNBBurn "true" or "false"; Determines whether to use BNB to pay for trading fees on SPOT
      # @option kwargs [String] :interestBNBBurn "true" or "false"; Determines whether to use BNB to pay for margin loan's interest
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Toggle-BNB-Burn-On-Spot-Trade-And-Margin-Interest
      def toggle_bnb_burn(**kwargs)
        @session.sign_request(:post, '/sapi/v1/bnbBurn', params: kwargs)
      end

      # Get BNB Burn Status (USER_DATA)
      #
      # GET /sapi/v1/bnbBurn
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Get-BNB-Burn-Status
      def get_bnb_burn(**kwargs)
        @session.sign_request(:get, '/sapi/v1/bnbBurn', params: kwargs)
      end

      # Query Margin Interest Rate History (USER_DATA)
      #
      # GET /sapi/v1/margin/interestRateHistory
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option vipLevel [Integer] Default: user's vip level
      # @option startTime [Integer] Default: 7 days ago
      # @option endTime [Integer] Default: present. Maximum range: 3 months.
      # @option limit [Integer] Default: 20. Maximum: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/borrow-and-repay/Query-Margin-Interest-Rate-History
      def get_margin_interest_rate_history(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/margin/interestRateHistory', params: kwargs.merge(asset: asset))
      end

      # Query Cross Margin Fee Data (USER_DATA)
      #
      # GET /sapi/v1/margin/crossMarginData
      #
      # @param kwargs [Hash]
      # @option vipLevel [Integer] Default: user's vip level
      # @option coin [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Query-Cross-Margin-Fee-Data
      def get_cross_margin_data(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/crossMarginData', params: kwargs)
      end

      # Query Isolated Margin Fee Data (USER_DATA)
      #
      # GET /sapi/v1/margin/isolatedMarginData
      #
      # @param kwargs [Hash]
      # @option vipLevel [Integer] Default: user's vip level
      # @option symbol [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Query-Isolated-Margin-Fee-Data
      def get_isolated_margin_data(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/isolatedMarginData', params: kwargs)
      end

      # Query Isolated Margin Tier Data (USER_DATA)
      #
      # GET /sapi/v1/margin/isolatedMarginTier
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option tier [Integer]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/market-data/Query-Isolated-Margin-Tier-Data
      def get_isolated_margin_tier(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/sapi/v1/margin/isolatedMarginTier', params: kwargs.merge(symbol: symbol))
      end

      # Query Current Margin Order Count Usage (TRADE)
      #
      # GET /sapi/v1/margin/rateLimit/order
      #
      # @param kwargs [Hash]
      # @option isIsolated [String]
      # @option symbol [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/margin_trading/account/Query-Isolated-Margin-Fee-Data
      def get_margin_order_usage(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/rateLimit/order', params: kwargs)
      end
    end
  end
end
