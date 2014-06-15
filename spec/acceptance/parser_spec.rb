require 'romanesco/parser'

describe Romanesco::Parser do

  subject       { Romanesco::Parser.new }

  describe '#parse' do

    it 'should result in an expression tree' do
      tree = subject.parse('sample_thing + 53 * another_variable - 5.5')

      tree.class.should == Romanesco::ExpressionTree
    end

    context 'if the expression contains all valid characters' do

      it 'should not raise an error' do
        expect{  subject.parse('sample * 50 / (other_value + different_thing_again)')}.to_not raise_error
      end

      it 'should not raise an error' do
        expect{ subject.parse('sample_thing + 53 * another_variable - 5.5')}.to_not raise_error
      end

      it 'should parse many nested superfluous parentheses' do
        expect{ subject.parse('((((((((((3))))))))))')}.to_not raise_error
      end

      context 'for a longer expression' do
        it 'should parse' do
          expect{ subject.parse('(3*(4+5)* 6)/8-9')}.to_not raise_error
        end

        it 'should parse' do
          expect{ subject.parse('(3*(4+5)/ 7)')}.to_not raise_error
        end

        it 'should parse' do
          expect{ subject.parse('3*(4+5)* 7')}.to_not raise_error
        end

        it 'should parse commas just fine' do
          expect{ subject.parse('a/(b/10,000)') }.to_not raise_error
        end

        it 'should parse' do
          expect{ subject.parse('a/(b/10000)') }.to_not raise_error
        end

        it 'should parse' do
          expect{ subject.parse('((a-b)/c)') }.to_not raise_error
        end

        it 'should parse' do
          expect{ subject.parse('((a+b+c)/d)*100') }.to_not raise_error
        end

        it 'should parse' do
          expect{ subject.parse('((a-b)/c)*100') }.to_not raise_error
        end
      end
    end

    context 'if the expression is invalid' do

      it 'should raise an error due to being nil' do
        expect { subject.parse(nil) }.to raise_error
      end

      it 'should raise an error for invalid characters' do
        expect { subject.parse('$') }.to raise_error
      end

      it 'should raise an error for uneven parentheses' do
        expect { subject.parse('(') }.to raise_error
      end

      it 'should raise an error for uneven parentheses' do
        expect { subject.parse('))))))))))') }.to raise_error
      end

      it 'accept commas but not when the number is invalid' do
        expect{ subject.parse('(,)') }.to raise_error
      end
    end

  end

end