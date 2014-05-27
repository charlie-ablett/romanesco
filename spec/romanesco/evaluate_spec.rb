require 'romanesco'

describe '#evaluate' do
  context 'for valid expressions' do
    it 'should output the correct value for a constant' do
      tree = parse('1')

      tree.evaluate.should == 1
    end

    it 'should output the correct value with parentheses' do
      tree = parse('(3)')

      tree.evaluate.should == 3
    end

    it 'should output the correct value for a simple equation 5+7' do
      tree = parse('5+7')

      tree.evaluate.should == 12
    end

    it 'should output the correct value and use parentheses' do
      tree = parse('(1+10)*3')

      tree.evaluate.should == 33
    end

    it 'should respect order of operations' do
      tree = parse("1+10*3")

      tree.evaluate.should == 31
    end

    it 'should respect parentheses' do
      tree = parse('1+(10*3)')

      tree.evaluate.should == 31
    end
  end

  context 'for valid expressions with variables' do

    it 'should output the correct value for a variable' do
      tree = parse('number_of_giraffes')

      tree.evaluate(number_of_giraffes: 4).should == 4
    end
  end
end

def parse(exp)
  Romanesco::Romanesco.parse(exp)
end