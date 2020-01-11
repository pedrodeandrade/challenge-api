# ChallengeApi

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## API endpoints 
  
  *  POST  /signup - requeste example: `{"user": {"name": "foo", "cpf": "1235678901", "age": "10", "email": "exemplo@gmail.com", "password": "12345678"}}`

  *  POST /signin - requeste example: `{"email": "exemplo@gmail.com", "password": "12345678"}`

  *  POST /users/u_id/articles - requeste example: `{"title": "title", "text": "text", "event_id": "1"}`

  *  POST /events - requeste example: `{"event": {"name": "evento", "description": "descricao de evento", "date": "27/02/2019"}}`

  *  GET /events 

  *  GET /events/id
