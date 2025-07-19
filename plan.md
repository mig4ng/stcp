# STCP Bus Stops App Plan

- [x] Generate Phoenix LiveView project called `stcp_stops` (no database)
- [x] Fix build issues and create plan.md
- [x] Start the server and replace default home page with static mockup
- [x] Add Floki dependency for HTML parsing (needed for STCP API)
- [x] Create StopsAPI module with bus fetching logic
  - Adapt existing code to use Req instead of HTTPoison
  - Parse STCP widget HTML to extract bus stop data
  - Handle errors gracefully
- [x] Create BusStopsLive LiveView module
  - Extract stop code from URL params (/MTB1, /CMP4, etc)
  - Fetch bus data on mount using StopsAPI
  - Handle loading and error states
- [x] Create bus_stops_live.html.heex template
  - Clean, minimal mobile-friendly table design
  - Show bus lines, destinations, and arrival times
  - Handle empty states gracefully
- [x] Update router to handle dynamic routes like /:stop_code
  - Remove default home route, replace with our bus stops route
- [x] Match layouts to clean & minimal design
  - Update app.css theme to minimal palette
  - Update root.html.heex to force light theme
  - Update Layouts.app to remove default header/nav
- [x] Visit app to verify functionality with test stops (MTB1, CMP4)

## ✅ SUCCESS! 
The app is working perfectly - fetched real STCP bus data for MTB1 showing:
- Bus line: 2M
- Destination: H.S.JOÃO URG  
- Arrival: 03:24 - 10min
- Clean, minimal mobile-friendly design

