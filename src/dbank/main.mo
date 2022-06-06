import Debug "mo:base/Debug"
// create a DBank canister, a container that is able to persist a record of state changes
actor DBank {
  var currentValue = 300;
  currentValue := 100;

  let id = 293874298347;
  // Debug.print(debug_show(id));

  // update method to top up balance
  // update calls require blockchain consensus and have changes persisted
  public func topUp(amount: Nat) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  // update method to width-drawl from balance
  public func widthdrawl(amount: Nat) {
    let tempValue: Int = currentValue - amount;
    if (tempValue >= 0) {
    currentValue -= amount;
    Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount too large, curentValue should be greater than zero.")
    }
  };

  // query call to check balance, faster than update methods
  // +info: https://internetcomputer.org/docs/current/concepts/canisters-code/#query-update
  public query func checkBalance(): async Nat {
    return currentValue;
  };

  // topUp();
}