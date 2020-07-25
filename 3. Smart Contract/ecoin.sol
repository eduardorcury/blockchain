pragma solidity ^0.6.6;

// Ecoins ICO

contract ecoin_ico {
    
    // Máximo número de ecoins disponível
    uint public max_ecoins = 1000000;
    
    // Conversão dólar para ecoins
    uint public usd_to_ecoins = 1000;
    
    // Número de ecoins comprado pelos investidores
    uint public total_ecoins_bought = 0;
    
    // Valor do investidor em dólar e ecoins
    mapping(address => uint) equity_ecoins;
    mapping(address => uint) equity_usd;
    
    // Checar se o investidor pode comprar ecoins
    modifier can_buy_ecoin(uint usd_invested) {
        require (usd_invested * usd_to_ecoins + total_ecoins_bought <= max_ecoins);
        _;
    }
    
    // Valor em ecoins de um investidor
    function equity_in_ecoins(address investor) external view returns (uint) {
        return equity_ecoins[investor];
    }
    
    // Valor em dólar de um investidor
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }
    
    // Função para comprar ecoins
    function buy_ecoin(address investor, uint usd_invested) external
    can_buy_ecoin(usd_invested) {
        uint ecoins_bought = usd_invested * usd_to_ecoins;
        equity_ecoins[investor] += ecoins_bought;
        equity_usd[investor] = equity_ecoins[investor] / usd_to_ecoins;
        total_ecoins_bought += ecoins_bought;
    }
    
    // Função para vender ecoins
    function sell_ecoin(address investor, uint ecoins_sold) external {
        equity_ecoins[investor] -= ecoins_sold;
        equity_usd[investor] = equity_ecoins[investor] / usd_to_ecoins;
        total_ecoins_bought -= ecoins_sold;
    } 
    
}
