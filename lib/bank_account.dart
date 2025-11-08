abstract class BankAccount{
  final int _accNumber;
  final String _accHolder;
  double _balance;

  BankAccount(
    this._accHolder,
    this._accNumber,
    this._balance);

  //Abstract methods 
  double deposit(double amount);
  double withdraw(double amount);
  
  //to display account information
  void accInformation(){
    print("Account Number: $_accNumber");
    print("Account Holder: $_accHolder");
    print("Balance: $_balance");
  }

  //getter and setter for proper encapsulation
  
}