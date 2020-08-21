# Github Shoutout

## Introduction
This is a demo application which main purpose is to provide list view of affinities between contributors of the `rails/rails` repository.
For now, affinities between users are determined on one specific interaction: pull request comment.

For a more detailed plan, please follow [this link](https://docs.google.com/document/d/1ro_LATcl1rGkFakaJCy_ta-0mx2OOKfsFNEuiDEYZ8o/edit?usp=sharing).

![image](https://user-images.githubusercontent.com/3678598/90801497-57b72100-e2ec-11ea-83f5-6a730627bd27.png)

## Specs
- Ruby: v2.6.3
- Rails: v6.0.x
- React: v16.13.x
- SQLLite: v3

## Ruby Libraries Used
- [pry-rails](https://github.com/rweng/pry-rails) for an enhanced development experience.
- [oktokit.rb](https://github.com/octokit/octokit.rb) to pull data from github.
- [rake-progressbar](https://github.com/ondrejbartas/rake-progressbar) to render progress bars in rake tasks.
- [tty-spinner](https://github.com/piotrmurach/tty-spinner) to render loading spinners in rake tasks.

## Frontend Libraries Used
* [react-table](https://github.com/tannerlinsley/react-table/tree/v6) to render the table view
* [react-typeahead](https://github.com/fmoo/react-typeahead) to render the users picker
* [react-datepicker](https://github.com/Hacker0x01/react-datepicker) to render the date picker

## Configuration
After checking out the project, run these two commands to install all dependencies:
1) run `bundle install`
2) run `yarn install`

## Database creation
Run `rails db:migrate` to create the database.

## Database initialization
There are two options:
1) Run `rails db:seed` to seed the database with stubbed some data.
2) Run `$ rails github:poll\[rails/rails\]` to poll data from the [rails repository](https://github.com/rails/rails).
![github_polling](https://user-images.githubusercontent.com/3678598/90932135-6a0c8a00-e3d4-11ea-962c-f24e06097092.gif)

## Running in development
1) Run `rails server` to start the backend server.
2) Run `bin/webpack-dev-server` to enable webpack hot reloading.
3) Navigate to `localhost:3000/challenge` to see the project running.

## How to run the test suite
Run `rails test` to run unit/integration tests

## Roadmap
- Create a cron job to run the github polling on a daily basis and make sure it only processes pull requests from the execution day.
- Create integration tests for the frontend (use [Cypress](https://github.com/cypress-io/cypress))
- Add continuous integration (circle ci)
