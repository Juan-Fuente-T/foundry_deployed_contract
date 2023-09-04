// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
pragma experimental ABIEncoderV2;

import {Test, console, console2} from "../lib/forge-std/src/Test.sol";
import {MiniYearn} from "../src/miniYearn.sol";
import {IWrappedTokenGateway} from "../src/contracts/IWrappedTokenGateway.sol";
import {IAToken} from "../src/contracts/IAToken.sol";

contract MiniYearnTest is Test {
    MiniYearn miniYearn;
    //uint256 TOTAL_SUPPLY = 20;
   


    address pool  = 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;
    
    IWrappedTokenGateway gateway;

    IAToken aETH = 0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8;
    address public alice; 

    function setUp() public {
        miniYearn = new MiniYearn(pool, gateway, aETH);
        address(gateway) = 0xD322A49006FC828F9B5B37Ab215F99B4E5caB19C;

        /* bank = new Bank(); // hacemos deploy del contrato bank
        vm.deal(address(bank), 10 ether); // el banco pasa a tener 10 ethers
        assertEq(address(bank).balance, 10 ether); // checkeamos que el balance del banco sea de 10 ethers

        alice = makeAddr("alice"); // creamos la direccion de alice

        vm.startPrank(alice);
        vm.deal(alice, 10 ether); // alice pasa a tener 10 ethers
        assertEq(alice.balance, 10 ether);

        attacker = */
        alice = makeAddr("alice");
        //poolAddr = makeAddr("poolAddr");
        //aEthAddr = makeAddr("aEthAddr");
        //gatewayAddr = makeAddr("poolAddr");





        /*constructor (address _pool, address _gateway, address _aETH) ERC20("MiniYearn", "MYT", 18){
            pool = _pool;
            gateway = IWrappedTokenGetway(_gateway);
            aETH = IAToken(_aETH);
        }*/
    }

    function TestMiniYearn() public{ 
        //assertEq(pool, 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2);
        //assertEq(gateway, 0xD322A49006FC828F9B5B37Ab215F99B4E5caB19C);
        //assertEq(aEth, 0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8);
       
        //function transfer(address(token), {value:25 ether}) public;
        //token.transfer(address(0),25 );
        //token.balanceOf(address(this));
        vm.startPrank(alice);
        miniYearn.deposit{value: 0}();
        vm.expectRevert(abi.encodeWithSignature("NoPuedeSerCero()"));
        miniYearn.deposit{value: 10}();
        assertEq(uint(alice.balance),10);
        

        miniYearn.withdraw(11);
        vm.expectRevert(abi.encodeWithSignature("MasDeLoQueTienes()"));

        miniYearn.withdraw(9);
        assertEq(uint(alice.balance),1);
        vm.stopPrank();

    }

}

    /*function withdraw(uint256 amount) public{
        //Checks

        if (amount > balanceOf[msg.sender]){
            revert MasDeLoQueTienes();
        }
        //Effetcs
        _burn(msg.sender, amount);

        aETH.approve(address(gateway), amount);

        //Interacts
        gateway.withdrawETH(pool, amount, msg.sender);


    }

    function getPrice() public returns(uint256){
        return aETH.scaledBalanceOf(address(this)) * 10 ** 18 / totalSupply;

    }

    function getUnderlying() public returns (uint256){
        return aETH.balanceOf(address(this));
    }
//ALLOWANCE listo
}*/
 
