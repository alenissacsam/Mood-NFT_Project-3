//SPDX-Lisense-Identifier:MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {MoodNft} from "../../src/MoodNft.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testDeployMoodNft() public {
        MoodNft moodNft = deployer.run();
        assertTrue(
            address(moodNft) != address(0),
            "MoodNft contract should be deployed"
        );
        console.log("MoodNft contract deployed at:", address(moodNft));
    }

    function testSvgToUri() public view {
        string
            memory svg = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500" height="500"><text x="0" y="15" fill="black">Hi! Your browser decoded this</text></svg>';
        string
            memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+PHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9ImJsYWNrIj5IaSEgWW91ciBicm93c2VyIGRlY29kZWQgdGhpczwvdGV4dD48L3N2Zz4=";
        string memory uri = deployer.svgToImageURI(svg);

        assert(
            keccak256(abi.encodePacked(uri)) ==
                keccak256(abi.encodePacked(expectedUri))
        );
    }
}
