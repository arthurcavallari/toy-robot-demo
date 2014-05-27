require 'spec_helper'

describe Table do
    before :each  do
        @table = Table.new 5, 5
    end
    
    describe "#new" do
        it "returns a new Table object" do
            @table.should be_an_instance_of Table 
        end
        
        it "throws an ArgumentError when given fewer than 2 parameters" do
            lambda { Table.new 5 }.should raise_exception ArgumentError
        end

        it "throws a TypeError when given non-integer parameters" do
           lambda { Table.new 5, "five" }.should raise_exception TypeError 
        end
    end
end