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

    it 'should use division and subtraction with more than two operands' do
      tree = parse('3-2-1')

      tree.evaluate.should == 0
    end

    it 'should divide successfully' do
      tree = parse('4/2')

      tree.evaluate.should == 2
    end
  end

  context 'for valid expressions with variables' do

    it 'should output the correct value for a variable' do
      tree = parse('number_of_giraffes')

      tree.evaluate(number_of_giraffes: 4).should == 4
    end
  end

  context 'for valid expressions with other trees' do

    it 'should evaluate recursively when other trees are provided' do
      tree = parse('something * something_else')
      second_tree = parse('even_more_awesomeness - sharks')

      tree.evaluate(something: 3, something_else: second_tree, even_more_awesomeness: 16, sharks: 10).should == 18.0
    end

    context 'with multiple levels' do
      let!(:m1) { parse("var_one + var_two * 100") }
      let!(:m2) { parse('metric_three + metric_four') }
      let!(:m3) { parse("var_four / 2") }
      let!(:m4) { parse("(var_three - var_two) * 1150") }

      it 'should evaluate recursively with more levels' do
        m1.evaluate({var_one: 1, var_two: 2}).should == 201.0
      end

      it 'should evaluate recursively with more levels' do
        m2.evaluate({metric_three: m3, metric_four: m4, var_one: 1, var_two: 2, var_three: 3, var_four: 4}).should == 1152.0
      end

      it 'should evaluate recursively with more levels' do
        m3.evaluate({var_four: 4}).should == 2.0
      end

      it 'should evaluate recursively with more levels' do
        m4.evaluate({var_two: 2, var_three: 3}).should == 1150.0
      end
    end

  end

  context 'for valid expressions with anything that responds to evaluate' do

    class FakeThing

      def evaluate(options={})
        100
      end

    end

    it 'should be able to use any class' do

      tree = parse('one_hundred + fifty')

      tree.evaluate(one_hundred: FakeThing.new, fifty: 50).should == 150.0

    end
  end

  context 'for valid expressions with missing variables' do

    it 'should raise an error' do
      tree = parse('twenty + 2')

      expect { tree.evaluate }.to raise_error(Romanesco::MissingVariables, "Missing variables: twenty")
    end

  end

  context 'it should detect loops' do

    it 'should throw an error if a loop is detected' do

      first_tree = parse('something * something_else')
      second_tree = parse('first_tree - sharks')

      expect{ first_tree.evaluate(something: 3, something_else: second_tree, first_tree: first_tree, sharks: 10) }.to raise_error(Romanesco::HasInfiniteLoopError, 'Cannot evaluate - infinite loop detected')

    end
  end

  context 'it should detect other missing variables' do
    it 'should throw an error if variables are missing' do
      jerk_animals = parse('jerks_of_the_animal_kingdom - magpies')
      land_animals = parse('jaguars * moose')

      expect{ jerk_animals.evaluate({jerks_of_the_animal_kingdom: land_animals}) }.to raise_error(Romanesco::MissingVariables, 'Missing variables: jaguars, moose, magpies')
    end

    it 'should provide the missing variables' do
      jerk_animals = parse('jerks_of_the_animal_kingdom - magpies')
      land_animals = parse('jaguars * moose')

      begin
        jerk_animals.evaluate({jerks_of_the_animal_kingdom: land_animals})
        fail
      rescue Romanesco::MissingVariables => e
        e.missing_variables.should == [:jaguars, :moose, :magpies]
      end
    end

    it 'should fill in with the default value if it is provided' do
      jerk_animals = parse('jerks_of_the_animal_kingdom - magpies')
      land_animals = parse('jaguars * moose')

      jerk_animals.evaluate({jerks_of_the_animal_kingdom: land_animals}, 3).should == 6.0
    end

  end
end



def parse(exp)
  Romanesco.parse(exp)
end