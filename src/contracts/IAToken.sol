// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
//pragma experimental ABIEncoderV2;
interface IAToken{
    function balanceOf(address user) external returns (uint256);
    function scaledBalanceOf(address user) external returns(uint256);
    function approve(address _spender, uint256 value) external returns (bool success);
}