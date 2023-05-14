# website
WORTH Cloud Engineer Tech Test

This sets out to acheive the following
The site should be served to the public.
- Two marketing users Alice & Malory should have access to only add to the /news
section
- Bobby the content editor needs to be able to edit the entire website.
- Charlie works in HR and should be able to update /people.html
- Add a custom error document.
- Automation of testing & deployment of infrastructure.

# Project Directory
public: This directory contains the static assets (images, stylesheets, scripts, etc.) that will be served to the public.

views: This directory contains the EJS templates that will be used to generate HTML pages dynamically.

routes: This directory contains the Express.js route handlers that will handle incoming HTTP requests.

models: This directory contains the Mongoose models that define the data schema for the MongoDB database.

controllers: This directory contains the functions that implement the business logic of the application.

middlewares: This directory contains custom middleware functions that can be used to process incoming requests before they are handled by the route handlers.

config: This directory contains configuration files for the application.

app.js: This is the main entry point of the application. It sets up the Express.js app and connects to the MongoDB database.

package.json: This file contains metadata about the application and its dependencies.

README.md: This file contains information about the project and how to set it up.





