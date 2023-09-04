// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
import "./contracts/ERC20.sol";

/*
    - funcion de receive() para poder recibir el ether que nos envíe AAVE depues de hacer el withdraw()
    - crear nuestro token ERC20 (miniETH)
    - crear una función deposit()
        - validar datos
        - darle al usuario el token miniYearn
        - deposito en AAVE
    - crear una función withdraw()
    - saber el balance total de nuestro contrato: preguntar el balance de aTokens (aETH) que tiene el contrato MiniYearn 
    - crear una funcion para calcular el precio de un token miniYearn
*/

/*interface IPool{
    function supply (address asset, uint256 amount, address onBehalfOf, uint256 referralCode) external;
}*/

interface IWrappedTokenGetway{
    function depositETH(address pool, address onBehalfOf, uint16 referralCode) external payable;
    function withdrawETH(address pool, uint256 amount, address to) external;
}

interface IAToken{
    function balanceOf(address user) external returns (uint256);
    function scaledBalanceOf(address user) external returns(uint256);
    function approve(address _spender, uint256 value) external returns (bool success);
}
contract MiniYearn is ERC20{
    
    IWrappedTokenGetway gateway; //WETH Gateway 0xD322A49006FC828F9B5B37Ab215F99B4E5caB19C
    address pool; //0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2
    IAToken aETH; //0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8
    
    constructor (address, address , address) ERC20("MiniYearn", "MYT", 18){
        pool = 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;
        gateway = IWrappedTokenGetway(0xD322A49006FC828F9B5B37Ab215F99B4E5caB19C);
        aETH = IAToken(_aETH);
    }

    
    constructor (address _pool, address _gateway, address _aETH) ERC20("MiniYearn", "MYT", 18){
        pool = _pool;
        gateway = IWrappedTokenGetway(_gateway);
        aETH = IAToken(_aETH);
    }


    error NoPuedeSerCero();
    error MasDeLoQueTienes();


    ///CEI: Checks, Effects, Interactions

    function deposit() payable external{
        ///Checks:  msg.value must be >0
        if (msg.value == 0){
            revert NoPuedeSerCero();
        }

        ///Efects: mint ERC20
        _mint(msg.sender, msg.value);
        ///Interactions: Deposit on AAVE
        gateway.depositETH{value: msg.value}(pool, address(this), 0);
    }



    function withdraw(uint256 amount) public{
        //Checks

        if (amount > balanceOf[msg.sender]){
            revert MasDeLoQueTienes();
        }
        //Effetcs
        _burn(msg.sender, amount);

        aETH.approve(address(gateway), amount); //Allowance

        //Interacts
        gateway.withdrawETH(pool, amount, msg.sender);


    }

    function getPrice() public returns(uint256){
        return aETH.scaledBalanceOf(address(this)) * 10 ** 18 / totalSupply;

    }

    function getUnderlying() public returns (uint256){
        return aETH.balanceOf(address(this));
    }

}

    