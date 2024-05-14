// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { SocialMedia } from "../src/SocialMedia.sol";
import { HelperConfig} from "./HelperConfig.s.sol";

contract DeploySocialMedia is Script {
    SocialMedia socialMedia;
    HelperConfig helperConfig;

    function run() public returns(SocialMedia){
        helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        socialMedia = new SocialMedia(ethUsdPriceFeed);
        vm.stopBroadcast();

        return socialMedia;
    }
}