require "jsduck/aggregator"
require "jsduck/source_file"

describe JsDuck::Aggregator do
  def parse(string)
    agr = JsDuck::Aggregator.new
    agr.aggregate(JsDuck::SourceFile.new(string))
    agr.result
  end

  shared_examples_for "constructor" do
    it "has one method" do
      methods.length.should == 1
    end

    it "has method with name 'constructor'" do
      methods[0][:name].should == "constructor"
    end

    it "has method with needed parameters" do
      methods[0][:params].length.should == 1
    end

    it "has method with default return type Object" do
      methods[0][:return][:type].should == "Object"
    end
  end

  describe "class with @constructor" do
    let(:methods) do
      parse(<<-EOS)[0][:members][:method]
        /**
         * @class MyClass
         * Comment here.
         * @constructor
         * This constructs the class
         * @param {Number} nr
         */
      EOS
    end

    it_should_behave_like "constructor"
  end

  describe "class with method named constructor" do
    let(:methods) do
      parse(<<-EOS)[0][:members][:method]
        /**
         * Comment here.
         */
        MyClass = {
            /**
             * @method constructor
             * This constructs the class
             * @param {Number} nr
             */
        };
      EOS
    end

    it_should_behave_like "constructor"
  end

end
