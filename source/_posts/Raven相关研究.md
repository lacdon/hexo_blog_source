---
title: Raven相关研究
date: 2019-12-13 18:16:56
tags: 
- blockchain
- cryptocoin 

---


## 主要信息

1. 出块时间 : 1分钟

2. 块奖励 : 5000 //Jan 4, 2018 1:11:34 AM 创世块头，约2022年减半

3. 难度调整周期 ：

   - 未启用黑暗重力波(DGW h < 338778) : 2016个块, 取余
   - 启用黑暗重力波动(DGW h >= 338778) : 逐个块调整, 180块
4. 减半周期 : 2,100,000个块, 约4年

5. POW limit : 00000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

6. P2P 通讯版本号 : 70025  `X16RV2_VERSION`

7. magic number : 

   - 主网 : 
     * 倒 :  0x4e564152 // 'N' 'V' 'A' 'R'
     * 正 :  0x5241564e // 'R' 'A' 'V' 'N'
   - 测试网 : 
     - 倒 :  0x544e5652 // 'T' 'N' 'V' 'R'
     - 正 :  0x52564e54 // 'R' 'V' 'N' 'T'

8. 块头 和比特币一样 80bytes

   ```c++
   class CBlockHeader
   {
   public:
       // header
       int32_t nVersion;        // 4
       uint256 hashPrevBlock;   // 32
       uint256 hashMerkleRoot;  // 32
       uint32_t nTime;          // 4
       uint32_t nBits;          // 4
       uint32_t nNonce;         // 4
   }
   ```

9. 算法 

   1. x16r算法 第二代

      | Number=Hashing algorithm |
      | :----------------------- |
      | 0=Blake                  |
      | 1=BMW                    |
      | 2=Groestl                |
      | 3=Jh                     |
      | 4=Keccak                 |
      | 5=Skein                  |
      | 6=Luffa                  |
      | 7=Cubehash               |
      | 8=Shavite                |
      | 9=Simd                   |
      | A=Echo                   |
      | B=Hamsi                  |
      | C=Fugue                  |
      | D=Shabal                 |
      | E=Whirlpool              |
      | F=SHA-512                |

## 参数相关代码

```c++
Pow limit = 00000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

    CMainParams() {
        strNetworkID = "main";
        consensus.nSubsidyHalvingInterval = 2100000;  //~ 4 yrs at 1 min block time. 2,100,000
        consensus.nBIP34Enabled = true;
        consensus.nBIP65Enabled = true; // 000000000000000004c2b624ed5d7756c508d90fd0da2c7c679febfa6c4735f0
        consensus.nBIP66Enabled = true;
        consensus.nSegwitEnabled = true;
        consensus.nCSVEnabled = true;
        consensus.powLimit = uint256S("00000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
        consensus.nPowTargetTimespan = 2016 * 60; // 1.4 days 120960秒，2016分钟,也就是2016/60=33.6小时，1.4天2016个块
        consensus.nPowTargetSpacing = 1 * 60; // 60秒一个块 ， 1分钟一个块
        consensus.fPowAllowMinDifficultyBlocks = false; //只有测试网允许
        consensus.fPowNoRetargeting = false;
        consensus.nRuleChangeActivationThreshold = 1814; // Approx 90% of 2016
        consensus.nMinerConfirmationWindow = 2016; // nPowTargetTimespan / nPowTargetSpacing // 确认时间= 难度调整周期
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].bit = 28;
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].nStartTime = 1199145601; // January 1, 2008
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].nTimeout = 1230767999; // December 31, 2008
        consensus.vDeployments[Consensus::DEPLOYMENT_ASSETS].bit = 6;  //Assets (RIP2)
        consensus.vDeployments[Consensus::DEPLOYMENT_ASSETS].nStartTime = 1540944000; // Oct 31, 2018
        consensus.vDeployments[Consensus::DEPLOYMENT_ASSETS].nTimeout = 1572480000; // Oct 31, 2019


        // The best chain should have at least this much work.
        consensus.nMinimumChainWork = uint256S("0x00"); // 最小工作量
        // By default assume that the signatures in ancestors of this block are valid.
        consensus.defaultAssumeValid = uint256S("0x00");

        // The best chain should have at least this much work.
        //TODO: This needs to be changed when we re-start the chain
        //consensus.nMinimumChainWork = uint256S("0x000000000000000000000000000000000000000000000000000000000c000c00");
        //TODO - Set this to genesis block
        // By default assume that the signatures in ancestors of this block are valid.
        //consensus.defaultAssumeValid = uint256S("0x0000000000000000003b9ce759c2a087d52abc4266f8f4ebd6d768b89defa50a"); //477890
        /**
         * The message start string is designed to be unlikely to occur in normal data.
         * The characters are rarely used upper ASCII, not valid as UTF-8, and produce
         * a large 32-bit integer with any alignment.
         */
	// magic number
	
	//主网络
	MainNetBitcoinNet=0x4e564152//'N''V''A''R'
	//测试网
	TestNetBitcoinNet=0x544e5652//'T''N''V''R'
	
        pchMessageStart[0] = 0x52; // R
        pchMessageStart[1] = 0x41; // A
        pchMessageStart[2] = 0x56; // V
        pchMessageStart[3] = 0x4e; // N
        nDefaultPort = 8767;
        nPruneAfterHeight = 100000;
        genesis = CreateGenesisBlock(1514999494, 25023712, 0x1e00ffff, 4, 5000 * COIN);
        consensus.hashGenesisBlock = genesis.GetX16RHash();
        assert(consensus.hashGenesisBlock == uint256S("0000006b444bc2f2ffe627be9d9e7e7a0730000870ef6eb6da46c8eae389df90"));
        assert(genesis.hashMerkleRoot == uint256S("28ff00a867739a352523808d301f504bc4547699398d70faf2266a8bae5f3516"));
        vSeeds.emplace_back("seed-raven.bitactivate.com", false);
        vSeeds.emplace_back("seed-raven.ravencoin.com", false);
        vSeeds.emplace_back("seed-raven.ravencoin.org", false);
        base58Prefixes[PUBKEY_ADDRESS] = std::vector<unsigned char>(1,60);
        base58Prefixes[SCRIPT_ADDRESS] = std::vector<unsigned char>(1,122);
        base58Prefixes[SECRET_KEY] =     std::vector<unsigned char>(1,128);
        base58Prefixes[EXT_PUBLIC_KEY] = {0x04, 0x88, 0xB2, 0x1E};
        base58Prefixes[EXT_SECRET_KEY] = {0x04, 0x88, 0xAD, 0xE4};
        vFixedSeeds = std::vector<SeedSpec6>(pnSeed6_main, pnSeed6_main + ARRAYLEN(pnSeed6_main));
        fDefaultConsistencyChecks = false;
        fRequireStandard = true;
        fMineBlocksOnDemand = false;
        fMiningRequiresPeers = true;
        checkpointData = (CCheckpointData) {
            {
                { 535721, uint256S("0x000000000001217f58a594ca742c8635ecaaaf695d1a63f6ab06979f1c159e04")},
            }
        };
        chainTxData = ChainTxData{
            // Update as we know more about the contents of the Raven chain
            // Stats as of 000000000000a72545994ce72b25042ea63707fca169ca4deb7f9dab4f1b1798 window size 43200
            1543817453, // * UNIX timestamp of last known number of transactions
            2033711,    // * total number of transactions between genesis and that timestamp
                        //   (the tx=... number in the SetBestChain debug.log lines)
            0.1         // * estimated number of transactions per second after that timestamp
        };
        /** RVN Start **/
        // Burn Amounts
        nIssueAssetBurnAmount = 500 * COIN;
        nReissueAssetBurnAmount = 100 * COIN;
        nIssueSubAssetBurnAmount = 100 * COIN;
        nIssueUniqueAssetBurnAmount = 5 * COIN;
        // Burn Addresses
        strIssueAssetBurnAddress = "RXissueAssetXXXXXXXXXXXXXXXXXhhZGt";
        strReissueAssetBurnAddress = "RXReissueAssetXXXXXXXXXXXXXXVEFAWu";
        strIssueSubAssetBurnAddress = "RXissueSubAssetXXXXXXXXXXXXXWcwhwL";
        strIssueUniqueAssetBurnAddress = "RXissueUniqueAssetXXXXXXXXXXWEAe58";
        //Global Burn Address
        strGlobalBurnAddress = "RXBurnXXXXXXXXXXXXXXXXXXXXXXWUo9FV";
        // DGW Activation
        nDGWActivationBlock = 338778;
        nX16RV2ActivationTime = 1569945600; //Tue Oct 01 2019 16:00:00 UTC
        nMaxReorganizationDepth = 60; // 60 at 1 minute block timespan is +/- 60 minutes.
        nMinReorganizationPeers = 4;
        nMinReorganizationAge = 60 * 60 * 12; // 12 hours
        /** RVN End **/
    }
};
```



```c++
//Version.h
//当前版本号为 70025
static const int PROTOCOL_VERSION = 70025;
//! initial proto version, to be increased after version/verack negotiation
static const int INIT_PROTO_VERSION = 209;
//! In this version, 'getheaders' was introduced.
static const int GETHEADERS_VERSION = 31800;
//! assetdata network request is allowed for this version
static const int ASSETDATA_VERSION = 70017;
//! disconnect from peers older than this proto version
static const int MIN_PEER_PROTO_VERSION = ASSETDATA_VERSION;
//! nTime field added to CAddress, starting with this version;
//! if possible, avoid requesting addresses nodes older than this
static const int CADDR_TIME_VERSION = 31402;
//! BIP 0031, pong message, is enabled for all versions AFTER this one
static const int BIP0031_VERSION = 60000;
//! "filter*" commands are disabled without NODE_BLOOM after and including this version
static const int NO_BLOOM_VERSION = 70011;
//! "sendheaders" command and announcing blocks with headers starts with this version
static const int SENDHEADERS_VERSION = 70012;
//! "feefilter" tells peers to filter invs to you by fee starts with this version
static const int FEEFILTER_VERSION = 70013;
//! short-id-based block download starts with this version
static const int SHORT_IDS_BLOCKS_VERSION = 70014;
//! not banning for invalid compact blocks starts with this version
static const int INVALID_CB_NO_BAN_VERSION = 70015;
//! getassetdata reutrn asstnotfound, and assetdata doesn't have blockhash in the data
static const int ASSETDATA_VERSION_UPDATED = 70020;
//! getassetdata reutrn asstnotfound, and assetdata doesn't have blockhash in the data
static const int X16RV2_VERSION = 70025;

```

## 难度调整代码

```c++
// pow.cpp
unsigned int static DarkGravityWave(const CBlockIndex* pindexLast, const CBlockHeader *pblock, const Consensus::ConsensusParams& params) {
    /* current difficulty formula, dash - DarkGravity v3, written by Evan Duffield - evan@dash.org */
    assert(pindexLast != nullptr);

    unsigned int nProofOfWorkLimit = UintToArith256(params.powLimit).GetCompact();
    const arith_uint256 bnPowLimit = UintToArith256(params.powLimit);
    int64_t nPastBlocks = 180; // ~3hr

    // make sure we have at least (nPastBlocks + 1) blocks, otherwise just return powLimit
    if (!pindexLast || pindexLast->nHeight < nPastBlocks) {
        return bnPowLimit.GetCompact();
    }

    if (params.fPowAllowMinDifficultyBlocks && params.fPowNoRetargeting) {
        // Special difficulty rule:
        // If the new block's timestamp is more than 2 * 1 minutes
        // then allow mining of a min-difficulty block.
        if (pblock->GetBlockTime() > pindexLast->GetBlockTime() + params.nPowTargetSpacing * 2)
            return nProofOfWorkLimit;
        else {
            // Return the last non-special-min-difficulty-rules-block
            const CBlockIndex *pindex = pindexLast;
            while (pindex->pprev && pindex->nHeight % params.DifficultyAdjustmentInterval() != 0 &&
                   pindex->nBits == nProofOfWorkLimit)
                pindex = pindex->pprev;
            return pindex->nBits;
        }
    }

    const CBlockIndex *pindex = pindexLast;
    arith_uint256 bnPastTargetAvg;

    for (unsigned int nCountBlocks = 1; nCountBlocks <= nPastBlocks; nCountBlocks++) {
        arith_uint256 bnTarget = arith_uint256().SetCompact(pindex->nBits);
        if (nCountBlocks == 1) {
            bnPastTargetAvg = bnTarget;
        } else {
            // NOTE: that's not an average really...
            bnPastTargetAvg = (bnPastTargetAvg * nCountBlocks + bnTarget) / (nCountBlocks + 1);
        }

        if(nCountBlocks != nPastBlocks) {
            assert(pindex->pprev); // should never fail
            pindex = pindex->pprev;
        }
    }

    arith_uint256 bnNew(bnPastTargetAvg);

    int64_t nActualTimespan = pindexLast->GetBlockTime() - pindex->GetBlockTime();
    // NOTE: is this accurate? nActualTimespan counts it for (nPastBlocks - 1) blocks only...
    int64_t nTargetTimespan = nPastBlocks * params.nPowTargetSpacing;

    if (nActualTimespan < nTargetTimespan/3)
        nActualTimespan = nTargetTimespan/3;
    if (nActualTimespan > nTargetTimespan*3)
        nActualTimespan = nTargetTimespan*3;

    // Retarget
    bnNew *= nActualTimespan;
    bnNew /= nTargetTimespan;

    if (bnNew > bnPowLimit) {
        bnNew = bnPowLimit;
    }

    return bnNew.GetCompact();
}

```


