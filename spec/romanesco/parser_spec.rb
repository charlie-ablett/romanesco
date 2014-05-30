require 'romanesco/parser'

describe Romanesco::Parser do

  subject       { Romanesco::Parser.new }

  describe '#parse' do

    context 'if the expression contains all valid characters' do

      it 'should not raise an error' do
        subject.parse('sample * 50 / (other_value + different_thing_again)')
      end

      it 'should not raise an error' do
        subject.parse('sample_thing + 53 * another_variable - 5.5')
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

    end

end

end