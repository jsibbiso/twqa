require 'spec_helper'

describe AttemptedQuestion do
  before(:each) do
    AttemptedQuestion.delete_all
  end
  
  describe "creation" do
    it "should have question id and player id as composite primary key" do
      AttemptedQuestion.primary_key.should include(:question_id)
      AttemptedQuestion.primary_key.should include(:player_id)
    end

    it "should not allow same question id and player id" do
      question = Question.create(:question => "Is panda cute?",
                                 :correct_answer => "Definitely!",
                                 :incorrect_answer_1 => "No",
                                 :incorrect_answer_2 => "It depends")
      player = Player.create(:first_name => "Teddy",
                             :last_name => "Bear",
                             :email => "teddybear@home.com",
                             :mobile_number => "123",
                             :city => "melb",
                             :company_name => "Home",
                             :role => "housekeeper")
      attempt1 = AttemptedQuestion.create(:question_id => question.id,
                                          :player_id => player.id,
                                          :answered_correctly => false)
      attempt1.should be_valid
      attempt2 = AttemptedQuestion.create(:question_id => question.id,
                                          :player_id => player.id,
                                          :answered_correctly => false)
      attempt2.should_not be_valid
    end
  end
  
  describe "csv_data" do
    it "should generate attempted question data to csv format" do
      question1 = Question.create(:question => "Is panda cute?",
                                 :correct_answer => "Definitely!",
                                 :incorrect_answer_1 => "No",
                                 :incorrect_answer_2 => "It depends")
     question2 = Question.create(:question => "Are kittens cute?",
                                :correct_answer => "Definitely!",
                                :incorrect_answer_1 => "No",
                                :incorrect_answer_2 => "It depends")
      player1 = Player.create(:first_name => "Teddy",
                             :last_name => "Bear",
                             :email => "teddybear@home.com",
                             :mobile_number => "123",
                             :city => "melb",
                             :company_name => "Home",
                             :role => "housekeeper")
     player2 = Player.create(:first_name => "Teddy",
                            :last_name => "Bear",
                            :email => "fredbear@home.com",
                            :mobile_number => "123",
                            :city => "melb",
                            :company_name => "Home",
                            :role => "housekeeper")
      attempt1 = AttemptedQuestion.create(:question_id => question1.id,
                                          :player_id => player1.id,
                                          :answered_correctly => false)
      attempt2 = AttemptedQuestion.create(:question_id => question1.id,
                                          :player_id => player2.id,
                                          :answered_correctly => true)        
      attempt3 = AttemptedQuestion.create(:question_id => question2.id,
                                          :player_id => player1.id,
                                          :answered_correctly => true)
      attempt4 = AttemptedQuestion.create(:question_id => question2.id,
                                          :player_id => player2.id,
                                          :answered_correctly => true)                          
     expected_csv_string = <<-data
QUESTION,PERCENTAGE_CORRECT_FIRST_ATTEMPT
Is panda cute?,50
Are kittens cute?,100
        data
        AttemptedQuestion.csv_data.should == expected_csv_string
      end
    end

  it "should order by question id by default" do
    attempt1 = AttemptedQuestion.create(:question_id => 3,
                                        :player_id => 1,
                                        :answered_correctly => false)
    attempt2 = AttemptedQuestion.create(:question_id => 1,
                                        :player_id => 1,
                                        :answered_correctly => false)
    attempt3 = AttemptedQuestion.create(:question_id => 2,
                                        :player_id => 1,
                                        :answered_correctly => false)
    all_attempts = AttemptedQuestion.all
    all_attempts[0].should == attempt2
    all_attempts[1].should == attempt3
    all_attempts[2].should == attempt1
  end
  
  
end
