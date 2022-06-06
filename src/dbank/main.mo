import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

// create a DBank canister, a container that is able to persist a record of state changes
actor DBank {
  // add orthogonal persistance using stable var
  stable var currentValue: Float = 300;
  // currentValue := 100;

  // create a stable var to start time in nanoseconds
  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));

  let id = 293874298347;
  // Debug.print(debug_show(id));

  // update method to top up balance
  // update calls require blockchain consensus and have changes persisted
  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  // update method to width-drawl from balance
  public func widthdrawl(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
    currentValue -= amount;
    // Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount too large, curentValue should be greater than zero.")
    }
  };

  // query call to check balance, faster than update methods
  // +info: https://internetcomputer.org/docs/current/concepts/canisters-code/#query-update
  public query func checkBalance(): async Float {
    return currentValue;
  };

  // query call to check current Time
  public func compound() {
    let currentTime = Time.now();
    // calculate time elapsed from the last compound calculation
    let timeElapsedNS = currentTime - startTime;
    // convert time elapsed from nanoseconds to seconds (1 sec equals 1 american bilion nanosec)
    let timeElapsedS = timeElapsedNS / 1000000000;
    // calculate compound interest
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    // reset startTime with the currentTime for a future compound calculation
    // notice that currentTime is a stable var (orthogonal persistance)
    startTime := currentTime;
  };

  // topUp();
}