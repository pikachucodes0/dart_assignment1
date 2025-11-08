abstract class BankAccount{
  final int _accNumber;
  String _accHolder;
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
 
  int get getAccNumber{
    return _accNumber;
  }

  String get getAccHolder{
    return _accHolder;
  }

  set setAccHolder(String accHolder){
    _accHolder = accHolder;
  }

  double get getBalance{
    return _balance;
  }

  set setBalance(double balance){
    _balance = balance;
  }

}

//abstract class InterestBearing

abstract class InterestBearing{
  void calculateInterest();
}

// Implement three types of accounts that inherit from Bank account

class SavingsAccount extends BankAccount implements InterestBearing {

  final double _minBalance = 500;
  final double _interestRate = 0.02;
  int _withdrawCount = 0;
  final int _withdrawLimit = 3;
  SavingsAccount(
    super._accHolder,
    super._accNumber,
    super._balance
    );


  @override
  double deposit(double amount) {
    if(amount > 0){
      _balance += amount;
      print("Deposit Amount: $amount \nNew Balance: $_balance");
    }else{
      print("Invalid Amount");
    }
    return _balance;
  }

  @override
  double withdraw(double amount) {
    if(_withdrawCount >= _withdrawLimit){
      print("Withdrawal Limit Exceeded");
    }
    else if(_balance - amount < _minBalance){
      print("Minimun Balance of $_minBalance must be maintained");
    }
    else{
      _balance -= amount;
      _withdrawCount++;
      print("Withdrawn $amount \nNew Balance: $_balance");
    }
    return _balance;
  }

  @override
  void calculateInterest() {
    double interest = _balance * _interestRate;
    _balance += interest;
    print("Interest of $interest added \nNew Balance: $_balance");
  }
}

class CheckingAccount extends BankAccount{
  final double _overdraftFee = 35;
  CheckingAccount(
    super._accHolder,
    super._accNumber,
    super._balance
  );
    
  @override
  double deposit(double amount) {
    if(amount > 0){
      _balance += amount;
      print("Deposit Amount: $amount \nNew Balance: $_balance");
      }else{
        print("Invalid Amount");
      }
      return _balance;
    }

  @override
  double withdraw(double amount) {
  if(amount <= 0){
    print("Invalid Withdrawal Amount");
    return _balance;
  }
  _balance -= amount;
  if(_balance < 0 ){
    _balance -= _overdraftFee;
    print("Overdraft Fee of $_overdraftFee applied");
  }
      
  print("Withdrawn $amount \nNew Balance: $_balance");
  return _balance;
  
  }
}

class PremiumAccount extends BankAccount implements InterestBearing{
  final double _minBalance = 10000;
  final double _interestRate = 0.05;
  PremiumAccount(
    super._accHolder,
    super._accNumber,
    super._balance
  );

 
  @override
  double deposit(double amount) {
    if(amount > 0){
      _balance += amount;
      print("Deposit Amount: $amount \nNew Balance: $_balance");
    }else{
      print("Invalid Amount");
    }
    return _balance;
  }


  @override
  double withdraw(double amount) {
    if (amount <= 0) {
      print("Invalid withdrawal amount.");
    } else if (_balance - amount < _minBalance) {
      print(
        "Cannot withdraw. Minimum balance of \$$_minBalance must be maintained.",
      );
    } else {
      _balance = _balance - amount;
      print("Withdrawn $amount. \nCurrent Balance: $_balance");
    }
    return _balance;
  }

   @override
  void calculateInterest() {
    double interest = _balance *_interestRate;
    _balance += interest;
    print("Interest of $interest has been added.\nNew balance: $_balance");
  }

}


class Bank{
  List<BankAccount> _accounts = [];

  //Create accounts
  void createAccount(BankAccount account){
    _accounts.add(account);
    print("${account._accNumber} has been created");
  }

  //Find accounts by account number

  BankAccount? findAccount(int accNumber){
    for(var account in _accounts){
      if(accNumber == account._accNumber){
        return account;
      }
    }
    print("Account not found");
    return null;
  }

  //Transfer money between accounts
  void transfer(int senderAccNo, int recieverAccNo, double amount){
    var senderAcc = findAccount(senderAccNo);
    var recieverAcc = findAccount(recieverAccNo);

    if(senderAcc == null || recieverAcc == null){
      print("Invalid Account Number");
    }
    else{
      senderAcc.withdraw(amount);
      recieverAcc.deposit(amount);
      print("$amount has been transfered from ${senderAcc.getAccHolder} to ${recieverAcc.getAccHolder}");
    }
  }
  
  void accountReport(){
    print("Report of All Accounts");
    for(var acc in _accounts){
      acc.accInformation();
    }

  }
}

void main(){  
  Bank bank = Bank();
  

  //create accounts
  SavingsAccount saving = SavingsAccount("Aryan", 1111, 2000);
  CheckingAccount checking = CheckingAccount("Amit", 2222, 1000);
  PremiumAccount premium = PremiumAccount("Asrim", 3636, 25000);

  bank.createAccount(saving);
  bank.createAccount(checking);
  bank.createAccount(premium);

  //report
  bank.accountReport();

  // deposits
  saving.deposit(500);
  checking.deposit(1500);
  premium.deposit(2000);

  //withdrawls
  saving.withdraw(1000);
  saving.withdraw(3000);
  checking.withdraw(4000);
  premium.withdraw(15000);

  //transfer money
  bank.transfer(3636, 1111, 500);

  bank.accountReport();

  saving.calculateInterest();
  bank.accountReport();


}

