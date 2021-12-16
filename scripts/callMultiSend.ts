import { ethers } from "hardhat";

const RECIPIENTS: string[] = []; // TODO: paste the list of recipients

const MULTI_SENDER_CONTRACT_ADDRESS = "0xB884eD92b177D183F014071b2bAf146bE36302B3";
const VALUE_PER_PERSON = ethers.utils.parseEther("0.05");
const FIRST_N = RECIPIENTS.length;

/**
 * To run:
 *   yarn hardhat run scripts/callMultiSend.ts --network [mumbai | polygon]
 */
async function main() {
  const [caller] = await ethers.getSigners();
  if (!caller) throw new Error("No deployer account configured, check hardhat.config.ts");
  if (!caller.provider) throw new Error("No provider configured");

  console.log(`Connected to chainId: ${(await caller.provider.getNetwork()).chainId}`);
  console.log("Using account:", caller.address);
  console.log("Account balance:", (await caller.getBalance()).toString());
  console.log("Calling multiSend...");

  const MultiSender = await ethers.getContractAt("MultiSender", MULTI_SENDER_CONTRACT_ADDRESS, caller);

  // send + 1 to be safe, remaining will be reimbursed
  const tx = await MultiSender.multiSendETH(RECIPIENTS.slice(0, FIRST_N), { value: VALUE_PER_PERSON.mul(FIRST_N + 1) });
  console.log("tx.hash", tx.hash);
  await tx.wait();

  console.log("Transaction completed");
  console.log("Account balance:", (await caller.getBalance()).toString());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
