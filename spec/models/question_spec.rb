require 'spec_helper'

describe Question do
  describe '.all_questions' do
    before(:each) do
      Question.delete_all
    end

    it 'should load all questions from csv when no questions exist in the db' do
      CSV.should_receive(:read).and_return([['0','1','2','3','4']])

      questions = Question.all_questions

      questions.size.should == 1
      question = questions.first
      question[:question].should == '1'
      question[:correct_choice].should == '2'
      question[:choices].should be_include('2')
      question[:choices].should be_include('3')
      question[:choices].should be_include('4')
      Question.find_by_sql('select count(*) as num from questions').first.num.should == 1
    end

    it 'should not load questions from csv when questions exist in the db' do
      Question.create(:question => 1, :correct_answer => 2, :incorrect_answer_1 => 3, :incorrect_answer_2 => 4)
      CSV.should_not_receive(:read)

      questions = Question.all_questions

      questions.size.should == 1
      question = questions.first
      question[:question].should == '1'
      question[:correct_choice].should == '2'
      question[:choices].should be_include('2')
      question[:choices].should be_include('3')
      question[:choices].should be_include('4')
    end
  end

  describe '#json_format' do
    it 'should come out in this very specific format' do
      question = Question.create(:question => '1', :correct_answer => '2',
                                 :incorrect_answer_1 => '3', :incorrect_answer_2 => '4')
      question_json = question.json_format

      question_json[:question_id].should == question.id
      question_json[:question].should == '1'
      question_json[:correct_choice].should == '2'
      question_json[:choices].should be_include('2')
      question_json[:choices].should be_include('3')
      question_json[:choices].should be_include('4')
    end
  end
end
