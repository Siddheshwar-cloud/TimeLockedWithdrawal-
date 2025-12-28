const hre = require("hardhat");

async function main() {
  const unlockTime =
    Math.floor(Date.now() / 1000) + 60 * 60; // 1 hour

  const TimeLock = await hre.ethers.getContractFactory(
    "TimeLockedWithdrawal"
  );

  const timeLock = await TimeLock.deploy(unlockTime);
  await timeLock.waitForDeployment();

  console.log("Deployed to:", await timeLock.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
