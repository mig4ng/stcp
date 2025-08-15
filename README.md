# STCP Real-time Bus Arrivals - Porto

This is a Phoenix Framework and Elixir application designed to provide real-time arrival times for buses in Porto, Portugal, specifically for the STCP (Sociedade de Transportes Colectivos do Porto) network.

I made this with LLM's and some manual intervention to test <https://phoenix.new/>. It was a project that I had in my too do list since I was in college and I would ride these buses frequently. There was no mobile friendly website to check this out (there were apps but I did not want another app in my phone for something as simple as this).

The LLM struggled a lot with figuring out how to scrape the data from STCP website, because it populates it after the initial page render. It spent me more than $20 in tokens figuring this out. Then I gave up and found on Github a library that did that already and used it to feed to LLM, and finally it succeeded. You can check the API library here: https://github.com/mig4ng/stcp_api

There is a lot of improvement margin, but overall tools such as phoenix.new and devin.ai alongside with large language models are getting really useful. For now for very small, limited scope develpments.

## Screenshots

*(TODO: add screenshots)*

## Try it out

**[https://stcp.carneiro.pt/](https://stcp.carneiro.pt/)**

## Running locally

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
