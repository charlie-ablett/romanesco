require 'romanesco/errors'

describe Romanesco::ExpressionTree do

  describe '#required_variables' do

    it 'should include all variables' do
      expression = Romanesco.parse('(lions + tigers) * bears')

      expression.required_variables.should == [:lions, :tigers, :bears]
    end

    it 'should include all variables but not constants' do
      expression = Romanesco.parse('(1 + 2) * 4')

      expression.required_variables.should == []
    end

  end

end

