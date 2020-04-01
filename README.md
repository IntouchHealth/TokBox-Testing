# TokBox-Testing
Repo with all the related scripts/jsons to test TokBox sessions data pulled via the API on a vacuum.
The official TokBox API documentation can be found at: https://tokbox.com/developer/guides/insights/
# Environment Setup

 - Run `gem install bundler` and `bundle install`. This will install the required libraries to run the `get_params.rb` script
 - In the `get_params.rb` file, replace `PROJECT_KEY` on line 18 for the `Username` as string and `PROJECT_SECRET` on line 24 for the `Password`, these credentials can be found in the Data Team LastPass vault under the name of `Tokbox Insights API Creds - Consumer Production Project.`
# Running the script
1) Change the `START_TIME` and `END_TIME` to specify the period for which you want the sessionsIds for. DO NOT change the `.iso8601.to_s` part, that's the format specified in the TokBok API documentation, it also supports datetimes as integers so you can also do `.iso8601.to_i`.
2) Run `ruby ./get_params.rb` to get the `start_time`, `end_time` and `Token` required for posting the TokBox API, keep in mind that the token has a lifetime of three minutes.
# Getting sessionIds
1) If you don't have the Postman app installed, you can find it here: https://www.postman.com/.
2) In Postman:
 - Set the POST url as  https://insights.opentok.com/graphql
 - In the Headers section, set Content-Type as application/json, and paste the generated token in the X-OPENTOK-AUTH field.
 - In the body section, paste the content of the get_sessions.json file with `PROJECT_KEY` replaced for the project key as an integer, `START_TIME` and `END_TIME` with the ones generated with the script.
NOTE: For the way the TokBox API works it will only return the first 1000 sessionIds for the specified period, so if you want to get more you will need to keep posting specifying a `endCursor` on the `sessionSummaries` field (after the first:1000) with `endCursor` of the last respond each time until the `hasNextPage` field of the response is `false`.
# Getting sessions details
In Postman: 
1) Set the POST url as  https://insights.opentok.com/graphql.
2) In the Headers section, set `Content-Type` as `application/json` and paste the generated token in the `X-OPENTOK-AUTH` field. 
3) In the Body section, paste the content of the `get_sessions_details.json` file with `PROJECT_KEY` replaced for the project key as an integer and in the sessionIds section paste the sessionIds you want to get the details from.
NOTE: For the way the TokBox API works, it will only return the details for the first 50 sessionIds specified, so don't do more than 50 at a time.

