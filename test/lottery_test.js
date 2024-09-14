const LotteryTest = artifacts.require("Lottery");

contract("LotteryTest", function () {
  it("should assert true", async function () {
    await LotteryTest.deployed();
    return assert.isTrue(true);
  });
});
