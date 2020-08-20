# Github Shoutout 


## Introduction
This is a demo application which main purpose is to provide list view of affinities between contributors of the `rails/rails` repository.
For now, affinities between users are determined on one specific interaction: pull request comment.

![image](https://user-images.githubusercontent.com/3678598/90800595-41f52c00-e2eb-11ea-9edf-94376b97e18a.png)

## Specs

- Ruby: v2.6.3
- Rails: v6.0.x
- React: v16.13.x
- SQLLite: v3

## Configuration
After checking out the project, run these two commands to install all dependencies:
1) run `bundle install`
2) run `yarn install`

## Database creation
Run `rails db:migrate` to create the database.

## Database initialization
Run `rails db:seed` to seed some data.

## Running the project in development
1) Run `rails server` to start the rails server. 
2) Run `bin/webpack-dev-server` to enable webpack hot reloading.

## How to run the test suite
Run `rails test` to run unit/integration tests

## Roadmap
- Create a rake task that seeds the database from the `rails/rails` repository (use [oktokit](https://github.com/octokit/octokit.rb))
- Create integration tests for the frontend (use [Cypress](https://github.com/cypress-io/cypress))
- Add continuous integration (circle ci)
