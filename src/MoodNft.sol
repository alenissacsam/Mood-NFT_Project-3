//SPDX-Lisense-Identifier:MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory happySvgImageUri,
        string memory sadSvgImageUri
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 TokenId) public {
        _checkAuthorized(ownerOf(TokenId), msg.sender, TokenId);

        if (s_tokenIdToMood[TokenId] == Mood.HAPPY) {
            s_tokenIdToMood[TokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[TokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURImaker(
        string memory svg
    ) public view returns (string memory) {
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '", "description":"An NFT","attributes":[{"trait type": "moodiness","value": 100}], "image":"',
                                svg,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function tokenURI(
        uint256 tokenCounter
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenCounter] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        return tokenURImaker(imageURI);
    }
}
