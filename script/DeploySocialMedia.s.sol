// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { SocialMedia } from "../src/SocialMedia.sol";
import { HelperConfig} from "./HelperConfig.s.sol";
import { CreateSubscription, FundSubscription, AddConsumer } from "./Interactions.s.sol";

contract DeploySocialMedia is Script {
    function run() external returns(SocialMedia, HelperConfig){
        HelperConfig helperConfig = new HelperConfig();
        // Destructuring our struct
        (
            address priceFeed, 
            uint256 interval,
            address vrfCoordinator,
            bytes32 gasLane,
            uint64 subscriptionId,
            uint32 callbackGasLimit,
            address link,
            uint256 deployerKey
        ) = helperConfig.activeNetworkConfig();

        if(subscriptionId == 0){
            CreateSubscription createSubscription = new CreateSubscription();
            subscriptionId = createSubscription.createSubscription(
                vrfCoordinator, deployerKey
            );

            FundSubscription fundSubscription = new FundSubscription();
            fundSubscription.fundSubscription(
                vrfCoordinator, subscriptionId, link, deployerKey
            );
        }
        
        vm.startBroadcast();
        SocialMedia socialMedia = new SocialMedia(
            priceFeed, 
            interval,
            vrfCoordinator,
            gasLane,
            subscriptionId,
            callbackGasLimit,
            link,
            deployerKey
        );
        vm.stopBroadcast();

        AddConsumer addConsumer = new AddConsumer();
        addConsumer.addConsumer(
            address(socialMedia), vrfCoordinator, subscriptionId, deployerKey
        );

        return (socialMedia, helperConfig);
    }
}