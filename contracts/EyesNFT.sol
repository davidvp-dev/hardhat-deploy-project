// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EyesNFT is ERC721Enumerable, Ownable {
    
    /* Using Strings library for NFT baseURI */
    using Strings for uint256;

    /* NFT properties */
    uint8 constant public MAX_SUPPLY = 20;
    uint public floorPrice = 0.0005 ether;
    string private baseURI;
    mapping(address => bool) private hasMinted;

    /* Whitelist properties */
    uint8 constant public WHITELIST_SIZE = 20;
    address[] private whitelistAddresses;
    mapping(address => bool) public isWhitelisted;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _initBaseURI
    ) ERC721(_name, _symbol) {
        setBaseURI(_initBaseURI);
    }

    /******************************
            Whitelist functions
    *******************************/

    modifier onlyWhitelisted() {
        require(isWhitelisted[msg.sender], "You are not in the whitelist!");
        _;
    }

    function addAddressList(address[] memory _addresses) public onlyOwner {
        require(_addresses.length <= WHITELIST_SIZE - whitelistAddresses.length, "The whitelist is full or the amount of addresses is too big!");
        for (uint8 i = 0; i < _addresses.length; i++) {
            require(isWhitelisted[_addresses[i]] == false, "The addresss is already included in the whitelist");
            whitelistAddresses.push(_addresses[i]);
            isWhitelisted[_addresses[i]] = true;
        }
    }

    function addAddress(address _user) public onlyOwner {
        require(whitelistAddresses.length <= WHITELIST_SIZE, "The whitelist is full");
            require(isWhitelisted[_user] == false, "The addresss is already included in the whitelist");
            whitelistAddresses.push(_user);
            isWhitelisted[_user] = true;
    }

    function clearWhitelist() public onlyOwner {
        for (uint8 i = 0; i < whitelistAddresses.length; i++) {
            isWhitelisted[whitelistAddresses[i]] = false;
        }
        delete whitelistAddresses;
    }

    function transferOwnership(address newOwner) public override {
        require(isWhitelisted[newOwner] == false, "The new owner can not be included in the whitelist!");
        transferOwnership(newOwner);
    }

    function whitelistedAddresses() public view onlyOwner returns (address[] memory) {
        return whitelistAddresses;
    }

    function addressesAmount() public view onlyOwner returns (uint256) {
        return whitelistAddresses.length;
    }

    /******************************
            NFT functions
    *******************************/

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }
    
    function mint(uint _mintAmount) public payable onlyWhitelisted {
        require(_mintAmount == 1, "You can only mint 1 NFT");
        require(msg.value >= floorPrice, "Insufficient value");
        require(hasMinted[msg.sender] == false, "You already minted 1 NFT");

        uint256 supply = totalSupply();
        require(supply < MAX_SUPPLY, "Mint is over, the 20 NFTs are already minted");

        hasMinted[msg.sender] = true;
        _safeMint(msg.sender, supply + 1);
    }

    function setFloorPrice(uint256 amount) public onlyOwner() {
        floorPrice = amount;
    }

    function walletTotalTokens(address account) public view returns (uint256[] memory) {
        uint256 totalTokens = balanceOf(account);
        uint256[] memory tokenIds = new uint256[](totalTokens);
        for(uint256 i = 0; i < totalTokens; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(account, i);
        }
        return tokenIds;
    }

	function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
		require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

		return bytes(baseURI).length > 0
			? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
			: "";
	}

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function hasAlreadyMinted(address account) public view returns (bool) {
        return hasMinted[account];
    }

}