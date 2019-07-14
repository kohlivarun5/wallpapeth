pragma solidity >=0.4.22 <0.6.0;
contract Wallpaper {

    address payable d_owner;
    mapping(address => bool) d_buyers;
    
    string d_title;
    
    string d_fullImage;
    string d_sampleImage;
    
    uint256 d_price;
    
    event WallpaperCreated(
        address indexed owner,
        string          title
    );
    
    event WallpaperBought(
        address indexed buyer,
        string          title
    );
    
    constructor(string memory fullImage,string memory sampleImage,uint256 price,string memory title) public {
        d_owner = msg.sender;
        d_fullImage=fullImage;
        d_sampleImage=sampleImage;
        d_price=price;
        d_title=title;
        emit WallpaperCreated(d_owner,d_title);
    }
    
    function price() public view returns (uint256) {
        return d_price;
    }
    
    function sampleImage() public view returns (string memory) {
        return d_sampleImage;
    }
    
    function fullImage() public view returns (string memory) {
        require(msg.sender == d_owner || d_buyers[msg.sender] == true,"Only owner or buyers can see full image");
        return d_fullImage;
    }
    
    function buy() public payable {
        require(d_buyers[msg.sender]== false, "Can only buy a wallpaper once");
        require(msg.value >= d_price, "Amount less than wallpaper price");
        d_buyers[msg.sender] = true;
    }
    
    // Owner functions
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
  
    function withdraw() public {
        require(msg.sender == d_owner,"You are not the owner");
        address(d_owner).transfer(getBalance());
    }
    
    function updatePrice(uint256 price) public {
        require(msg.sender == d_owner,"You are not the owner");
        d_price = price;
    }
}

