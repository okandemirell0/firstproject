# ERC-20 Staking Smart Contract 🏦

Bu proje, kullanıcıların ellerindeki ERC-20 tokenlarını kilitleyerek (stake ederek) zamanla ödül tokenı (Reward Token) kazanmalarını sağlayan, Solidity tabanlı bir akıllı sözleşme sistemidir.

## 🚀 Proje Hakkında

Bu merkeziyetsiz uygulama (dApp) mantığı, DeFi ekosisteminin temel taşlarından biri olan "Staking" mekanizmasını simüle eder. Kullanıcılar sisteme güvenli bir şekilde token yatırır, yatırdıkları süre ve miktar oranında ödül kazanır ve istedikleri zaman anaparalarını + ödüllerini çekerler.

### Temel Özellikler
- **Stake (Yatırma):** Kullanıcılar belirli bir miktar tokenı kontrata kilitler.
- **Withdraw (Çekme):** Kullanıcılar istedikleri zaman stake ettikleri tokenları geri alabilirler.
- **Claim Reward (Ödül Toplama):** Biriken ödüller, stake bozulmadan da talep edilebilir.
- **Reward Calculation (Ödül Hesaplama):** Ödüller, saniye başına veya blok başına belirlenen bir oran üzerinden hesaplanır.
- **Güvenlik:** Reentrancy (yeniden giriş) saldırılarına karşı korumalıdır.

## 🛠️ Teknolojiler

Bu projede aşağıdaki teknolojiler ve standartlar kullanılmıştır:

* **Solidity:** ^0.8.0 (Akıllı sözleşme dili)
* **OpenZeppelin:** `ERC20` ve `ReentrancyGuard` kütüphaneleri (Güvenlik standartları için)
* **Remix IDE / Hardhat:** Geliştirme ve test ortamı

## 📂 Dosya Yapısı

* `Staking.sol`: Ana staking mantığını barındıran kontrat. Kullanıcı bakiyelerini ve ödül hesaplamalarını yönetir.
* `RewardToken.sol`: Ödül olarak dağıtılan ERC-20 token kontratı.

## ⚙️ Nasıl Çalışır?

1.  **Dağıtım (Deploy):** Önce `RewardToken` dağıtılır, ardından bu tokenın adresi ile `Staking` kontratı dağıtılır.
2.  **Ödül Yüklemesi:** Staking kontratının ödül dağıtabilmesi için, kontrat adresine bir miktar RewardToken transfer edilir.
3.  **Kullanım:**
    * Kullanıcı `stake(amount)` fonksiyonunu çağırır.
    * Zaman geçer... ⏳
    * Kullanıcı `claimReward()` ile ödülünü alır veya `withdraw(amount)` ile sistemden çıkar.

## 📦 Kurulum ve Test (Local)

Projeyi bilgisayarınıza klonlamak için:

```bash
git clone [https://github.com/okandemirell0/Staking.git](https://github.com/okandemirell0/Staking.git)
cd Staking
------------------------------------------------------------------------------------------------------------------------------------------------------------
ENGLISH:
# ERC-20 Staking Smart Contract 🏦

This project is a Solidity-based smart contract system that allows users to lock (stake) their ERC-20 tokens to earn reward tokens over time.

## 🚀 About the Project

This decentralized application (dApp) logic simulates one of the core mechanisms of the DeFi ecosystem: Staking. Users can securely deposit tokens into the system, earn rewards based on the duration and amount staked, and withdraw their principal plus rewards whenever they choose.

### Key Features
- **Stake:** Users can lock a specific amount of tokens in the contract.
- **Withdraw:** Users can unstake their tokens along with earned rewards at any time.
- **Claim Reward:** Accumulated rewards can be claimed without unstaking the principal.
- **Reward Calculation:** Rewards are calculated dynamically based on a fixed rate per second/block.
- **Security:** Protected against Reentrancy attacks using OpenZeppelin standards.

## 🛠️ Built With

* **Solidity:** ^0.8.0
* **OpenZeppelin:** `ERC20` and `ReentrancyGuard` libraries
* **Remix IDE / Hardhat:** Development and testing environment

## 📂 File Structure

* `Staking.sol`: The main contract managing staking logic, user balances, and reward calculations.
* `RewardToken.sol`: The ERC-20 token contract used for distributing rewards.

## ⚙️ How It Works

1.  **Deployment:** First, the `RewardToken` is deployed. Then, the `Staking` contract is deployed using the RewardToken's address.
2.  **Funding:** The Staking contract is funded with RewardTokens to ensure it can pay out rewards.
3.  **Interaction:**
    * User calls `stake(amount)`.
    * Time passes... ⏳
    * User calls `claimReward()` to harvest rewards or `withdraw(amount)` to exit the system.

## 📦 Installation & Testing (Local)

To clone this repository to your local machine:

```bash
git clone [https://github.com/okandemirell0/Staking.git](https://github.com/okandemirell0/Staking.git)
cd Staking
