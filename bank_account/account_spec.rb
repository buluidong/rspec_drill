require "rspec"
 
require_relative "account"
 
describe Account do

  let(:acc_num) { "0123456789" }
  let(:account) { Account.new(acc_num) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new account with valid acc number with a balance" do
        expect(account.acct_number).to eq("******6789")
      end

      it "creates new account with just acc number" do
        expect { Account.new(acc_num) }.to_not raise_error
      end 

      it "should have a starting balance of 0" do
        account.balance.should eq(0)
      end
    end

    context "with invalid input" do
      it "throws an argument error when not given a type of argument" do
        expect { Account.new }.to raise_error(ArgumentError)
      end

      it "throws an error when incorrect format" do
        expect { Account.new("mixed chars or alphabets") }.to raise_error(InvalidAccountNumberError)
        expect { Account.new("numbers more/less than 10") }.to raise_error(InvalidAccountNumberError)
      end
    end
  end
 
  describe "#transactions" do
    context "when cucuk or bank in" do
      it "show the amount withdrawn or deposited" do
        account.deposit!(100)
        account.withdraw!(50)
        account.transactions.should eq([0,100,-50])
      end
    end
  end
 
  describe "#balance" do
    it "should reflect correct balance after deposit/withdraw" do
      account.deposit!(500)
      account.withdraw!(300)
      account.balance.should eq(200)
    end
  end
 
  describe "#account_number" do
    it "shows only the last 4 digits" do
      account.acct_number.should eq "******6789"
    end
  end
 
  describe "deposit!" do
    context "when deposit money" do
      it "balance should increase" do
        account.deposit!(100)
        account.balance.should eq(100) 
      end
    end
  end
 
  describe "#withdraw!" do
    context "when withdraw money" do
      it "balance should decrease" do
        account.deposit!(100)
        account.withdraw!(80) 
        account.balance.should eq(20)
      end
    end

    context "when balance is 0" do
      it "throws a Overdraft Error" do
        account.balance < 0
        expect { account.withdraw!(100) }.to raise_error(OverdraftError)
      end
    end
  end
end