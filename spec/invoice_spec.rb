require 'spec_helper'

describe SalesEngine::Invoice do
  describe "#transactions" do
    let(:transaction) { mock(SalesEngine::Transaction) }
    let(:transaction2) { mock(SalesEngine::Transaction) }
    let(:other_transaction) { mock(SalesEngine::Transaction) }

    before(:each) do
      transaction.stub(:invoice_id).and_return(1)
      transaction2.stub(:invoice_id).and_return(2)
      other_transaction.stub(:invoice_id).and_return(1)
      SalesEngine::Database.stub(:transactions).and_return([transaction, transaction2, other_transaction])
    end
    context "the invoice has many associated transactions" do
      it "returns an array of all associated transactions" do
        invoice = SalesEngine::Invoice.new(1, "", "", "", Date.today, Date.today)
        invoice.transactions.should == [transaction, other_transaction]
      end
    end
    context "the invoice has one associated transaction" do
      it "returns an array containing the associated transaction" do
        invoice = SalesEngine::Invoice.new(2, "", "", "", Date.today, Date.today)
        invoice.transactions.should == [transaction2]
      end
    end
    context "the invoice has no associated transactions" do
      it "returns an empty array" do
        invoice = SalesEngine::Invoice.new(3, "", "", "", Date.today, Date.today)
        invoice.transactions.should == []
      end
    end
  end

  describe "#invoice_items" do
    let(:invoice_item) { mock(SalesEngine::InvoiceItem) }
    let(:invoice_item2) { mock(SalesEngine::InvoiceItem) }
    let(:other_invoice_item) { mock(SalesEngine::InvoiceItem) }

    before(:each) do
      invoice_item.stub(:invoice_id).and_return(1)
      invoice_item2.stub(:invoice_id).and_return(2)
      other_invoice_item.stub(:invoice_id).and_return(1)
      SalesEngine::Database.stub(:invoice_items).and_return([invoice_item, invoice_item2, other_invoice_item])
    end
    context "the invoice has many associated invoice_items" do
      it "returns an array of all associated invoice_items" do
        invoice = SalesEngine::Invoice.new(1, "", "", "", Date.today, Date.today)
        invoice.invoice_items.should == [invoice_item, other_invoice_item]
      end
    end
    context "the invoice has one associated invoice_item" do
      it "returns an array containing the associated invoice_item" do
        invoice = SalesEngine::Invoice.new(2, "", "", "", Date.today, Date.today)
        invoice.invoice_items.should == [invoice_item2]
      end
    end
    context "the invoice has no associated invoice_items" do
      it "returns an empty array" do
        invoice = SalesEngine::Invoice.new(3, "", "", "", Date.today, Date.today)
        invoice.invoice_items.should == []
      end
    end
  end

  describe "#items" do
    let(:item) { mock(SalesEngine::Item) }
    let(:item2) { mock(SalesEngine::Item) }
    let(:other_item) { mock(SalesEngine::Item) }

    let(:invoice_item) { mock(SalesEngine::InvoiceItem)}
    let(:invoice_item2) { mock(SalesEngine::InvoiceItem)}
    let(:other_invoice_item) { mock(SalesEngine::InvoiceItem)}

    before(:each) do
      invoice_item.stub(:invoice_id).and_return(1)
      invoice_item2.stub(:invoice_id).and_return(2)
      other_invoice_item.stub(:invoice_id).and_return(1)
      invoice_item.stub(:item).and_return(item)
      invoice_item2.stub(:item).and_return(item2)
      other_invoice_item.stub(:item).and_return(other_item)

      SalesEngine::Database.stub(:invoice_items).and_return([invoice_item, invoice_item2, other_invoice_item])
    end

    context "the invoice has many associated items" do
      it "returns an array of all associated items" do
        invoice = SalesEngine::Invoice.new(1, "", "", "", Date.today, Date.today)
        invoice.items.should == [item, other_item]
      end
    end
    context "the invoice has one associated item" do
      it "returns an array containing the associated item" do
        invoice = SalesEngine::Invoice.new(2, "", "", "", Date.today, Date.today)
        invoice.items.should == [item2]
      end
    end
    context "the invoice has no associated items" do
      it "returns an empty array" do
        invoice = SalesEngine::Invoice.new(3, "", "", "", Date.today, Date.today)
        invoice.items.should == []
      end
    end
  end

  describe "#customer" do
    let(:invoice) { SalesEngine::Invoice.new(1, 1, "", "", Date.today, Date.today) }
    let(:customer) { mock(SalesEngine::Customer) }
    let(:other_customer) { mock(SalesEngine::Customer) }

    before(:each) do
      customer.stub(:id).and_return(1)
      other_customer.stub(:id).and_return(2)
      SalesEngine::Database.stub(:customers).and_return([customer, other_customer])
    end
    
    it "returns the customer with matching customer_id" do
      invoice.customer.should == customer
    end
  end
end