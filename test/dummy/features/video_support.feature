Feature: Video support in store front pages
	In order to advertise an event
	As a client
	I want to be able to add, remove and change videos to, from and in my store's front page.

	Stakeholder: Client
	Priority: Medium
	By: Henrique Martins

	Scenario: Sucessful upload
		Given I am authenticated
		And I have a store
		And I am in my store's back-office
		When I select "video.avi"
		And submit
		Then I want to see "Uploaded"
		And I want to see the video list page
		And I want to see the video title

	Scenario: Listing
		Given I am authenticated
		And I have a store
		And I am in my store's back-office
		And I uploaded videos
		When I access the video list page
		Then I want to see all the titles

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