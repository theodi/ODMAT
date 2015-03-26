require 'spec_helper'

describe Assessment do

  context "when completing" do
    
    before(:each) do
      config = File.join( __dir__, "..", "lib", "test-survey.xls" )    
      QuestionnaireImporter.load(1, config)    
    end

    let(:assessment) { FactoryGirl.create :unfinished_assessment }
    let!(:assessment_answer) { AssessmentAnswer.create( assessment: assessment, question: Question.first, answer: Answer.find_by_code("Q1.2") ) }
          
    it "should identify when complete" do
      assessment = FactoryGirl.create(:assessment)
      expect( assessment.status ).to eql(:complete)
    end
    
    it "should identify when incomplete" do
      expect( assessment.status ).to eql(:incomplete)
    end
    
    it "should set completion date" do
      assessment.complete
      expect( assessment.completion_date ).to_not be_nil
      expect( assessment.status ).to eql(:complete)      
    end
    
    it "should only complete if allowed" do
      AssessmentAnswer.destroy_all
      assessment.complete
      expect( assessment.status ).to eql(:incomplete)   
    end
    
    it "should store scores" do
      assessment.complete
      expect( assessment.scores.length ).to eql(1)
      expect( Score.first.score ).to eql(1)
    end

    describe "#update_targets" do 
      it "should change all the scores for an assessment" do
        score_targets = {}
        assessment.complete
        Rails.logger.info("\n #{assessment.scores.count} scores to change \n")
        assessment.scores.each { |s| score_targets.merge!(s.id.to_s => rand(1..5)) }
        assessment.update_targets(score_targets)
        scores_changed = true
        score_targets.each {|score_id, target| scores_changed = false if Score.find(score_id).target != target }
        expect(scores_changed).to eq(true)
      end
    end

    describe "#next_activity" do
      it "should return the next unstarted activity" do
        activity = Activity.first
        AssessmentAnswer.destroy_all
        expect( assessment.next_activity ).to eql(activity)
      end

      it "should return the next started but unfinished activity" do
        activity = Activity.first
        assessment_answer.update_attribute(:answer_id, Answer.find_by_code("Q1.1").id)
        expect( assessment.next_activity ).to eql(activity)
      end
    end
  end 

end
