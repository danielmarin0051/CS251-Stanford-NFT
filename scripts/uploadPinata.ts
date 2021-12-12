const pinataSDK = require('@pinata/sdk');
const IPFS = require('ipfs-core');
const fs = require('fs');

const pinata = pinataSDK(process.env.PINATA_API_KEY, process.env.PINATA_API_PRIVATE_KEY);

const metaDatafile = './metadata/metadata.json';
const metadata = JSON.parse(fs.readFileSync(metaDatafile))
const metadataOptions = {
    pinataMetadata: {
        name:"Stanford 251 NFT Metadata"
    },
    pinataOptions: {
        cidVersion: 0
    }
}

const mediaFile = './media/test.c4d';
const media = fs.createReadStream(mediaFile);
const mediaOptions = {
    pinataMetadata: metadata,
    pinataOptions: {
        cidVersion: 0
    }
};

async function main() {
    //Pin image first
    pinata.pinFileToIPFS(media, mediaOptions).then((mediaResult: any) => {
        console.log(mediaResult);

        //Pin metadata second
        metadata.image=mediaResult.IpfsHash;
        fs.writeFileSync(metaDatafile, JSON.stringify(metadata));

        pinata.pinFileToIPFS(fs.createReadStream(metaDatafile), metadataOptions).then((metadataResult: any) => {
            console.log(metadataResult);
        }).catch((err: any) => {
            console.error(err);
        });
    }).catch((err: any) => {
        console.error(err);
    });

    
}

async function uploadIPFSTest() {
    let ipfs = await IPFS.create()
    const { cid } = await ipfs.add('hello world')
    const url = `https://gateway.pinata.cloud/ipfs/${cid}`
    console.log(url)
    console.log(cid)
  }

main();