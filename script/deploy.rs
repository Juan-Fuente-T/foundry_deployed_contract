use foundry::prelude::*;

#[foundry::contract]
mod miniyearn {
    //#[foundry::contract(file = "C:\Users\Juan\Desktop\Programación\Foundry\script\MiniYearn")]
    #[foundry::contract(file = ".src/MiniYearn.sol")]
    pub struct MiniYearn {
        // Definir los campos y métodos del contrato MiniYearn
    }

    /*#[foundry::contract]
    pub struct TokenMiniYearn {
        // Definir los campos y métodos del contrato TokenMiniYearn
    }*/
}

#[foundry::init]
fn deploy() -> miniyearn::MiniYearn {
    miniyearn::MiniYearn::deploy()
}

fn main() {
    foundry::run(deploy)
}

// nodo alchemy https://eth-sepolia.g.alchemy.com/v2/QF_rlvr4V0ZORimK7ysBA4mJvl0Bk47c
//forge script script/Contract.s.sol:ContractScript --rpc-url "https://eth-mainnet.alchemyapi.io/v2/YOUR_API_KEY" --private-key "YOUR_PRIVATE_KEY" --broadcast
//clave 9c3790c487329060a51a2f01557ad544565a63c063fcb2a4b4b71346dccb27bc


//forge script script/miniYearn.sol --rpc-url "https://eth-sepolia.g.alchemy.com/v2/QF_rlvr4V0ZORimK7ysBA4mJvl0Bk47c" --private-key "9c3790c487329060a51a2f01557ad544565a63c063fcb2a4b4b71346dccb27bc" --broadcast

