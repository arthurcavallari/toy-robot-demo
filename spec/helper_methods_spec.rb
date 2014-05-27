require 'spec_helper'

shared_examples_for HelperMethods do
    context '#numeric?' do
        before(:each) do
            @obj = obj unless obj.nil?
        end

        it 'returns true when given a parameter that can be converted to Integer' do
            @obj.numeric?("1").should be_true
        end

        it 'returns false when given a parameter that cannot be converted to Integer' do
            @obj.numeric?("one").should be_false
        end
    end

    context '#to_numeric!' do
        before(:each) do
            @obj = obj unless obj.nil?
        end

        it 'returns the parameter converted to Integer if given a valid value' do
            @obj.to_numeric!("95").should eq 95
        end

        it 'returns false when given a parameter that cannot be converted to Integer' do
            @obj.to_numeric!("one").should be_false
        end
    end
end

# Now list every model in your app to test them properly

describe ToyRobot do
    it_behaves_like HelperMethods do
    let(:obj) { ToyRobot.new(nil, nil, nil, Table.new(5,5)) }
  end
end

describe Table do
    it_behaves_like HelperMethods do
    let(:obj) { Table.new(5,5) }
  end
end