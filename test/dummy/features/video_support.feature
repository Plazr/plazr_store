Feature: Video support in front page

	I should be able to manage my advertising videos

	Stakeholder: Client
	Priority: Medium
	By: Henrique Martins

	Scenario: Sucessful upload
		Given I am authenticated
		And I have a store
		And I am in the back office
		When I select a video file to upload
		And I click submit
		Then I should see a video success message
		And I should be at video list page
		And I should to see the video

	Scenario: Listing
		Given I am authenticated
		And I have a store
		And I am in my store's back-office
		And I uploaded videos
		When go to the video index page
		Then I want to see all the videos

	Scenario: Successful removal
		Given I am authenticated
		And I have a store
		And I am in my store's back-office
		And I uploaded videos
		When I select a video
		And I choose to delete it
		Then I want to see "Deleted"
		And I want to see the video list page
		And I do not want to see the video title

	Scenario: Video is visible
		Given "video.avi" has been uploaded
		And it has been set to be visible
		When I access the front page
		Then I want to see the video playing