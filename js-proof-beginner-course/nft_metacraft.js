/*
Assessment Requirements
1. Create a variable that can hold a number of NFT's. What type of variable might this be?
2. Create an object inside your mintNFT function that will hold the metadata for your NFTs. 
   The metadata values will be passed to the function as parameters. When the NFT is ready, 
   you will store it in the variable you created in step 1
3. Your listNFTs() function will print all of your NFTs metadata to the console (i.e. console.log("Name: " + someNFT.name))
4. For good measure, getTotalSupply() should return the number of NFT's you have created
*/

// create a variable to hold your NFT's

// this function will take in some values as parameters, create an
// NFT object using the parameters passed to it for its metadata, 
// and store it in the variable above.

const nfts = [];

function mintNFT (nftName, description, nftRarity, artistName, nftSupply) {
    class NFT {
        constructor(nftName,description, nftRarity, artistName, nftSupply) {
        this.nftName = nftName;
        this.description = description;
        this.nftRarity = nftRarity;
        this.artistName = artistName;
        this.nftSupply = nftSupply;
        }
    }
    const newNFT = new NFT(nftName, description, nftRarity, artistName, nftSupply);
    nfts.push(newNFT);
}

// create a "loop" that will go through an "array" of NFT's
// and print their metadata with console.log()
function listNFTs (nfts) {
    for(key in nfts){
        if(nfts.hasOwnProperty(key)){
            const value = nfts[key];
            
            console.log(`NFT #${parseInt(key) + 1} : ${JSON.stringify(value, null, 2)}`);
        }
    }
}

// print the total number of NFTs we have minted to the console
function getTotalSupply(nfts) {
    console.log(`\nTotal number of NFTs is ${nfts.length}\n`)
}

/* prints true if an nft's rarity is legendary 
we assume that all nfts that are less than or equal to 100 in supply are legendary*/
function isLegendary(nfts){
    for(i = 0; i<nfts.length; i++){
        console.log((nfts[i]["nftSupply"] <= 100) ? `${nfts[i]["nftName"]} is Legendary` : `${nfts[i]["nftName"]} not Legendary`);
    }
}
// call your functions below this line
mintNFT("little Cattos", "kittens that playing on a yarn", "Legendary", "Leonardo Da Vinci", "50");
mintNFT("The Dream of a Fiend", "a depiction of a serial killer\'s dream", "Epic", "Salvador Dali", "1,000");
mintNFT("The Archer", "a man with a bow aiming at an apple", "Common", "Salvador Dali", "5,000");

listNFTs(nfts);

getTotalSupply(nfts);

isLegendary(nfts);
