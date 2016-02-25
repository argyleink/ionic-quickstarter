## Firebase swapped for Kinto
- app.config.json
- config.js
- app.js (line 90)
- user/services/user.service.js
- user/services/firebase/*
- user.service.firebaseImpl.js (line 540)

## Utils in question
- stopWatch.service.js
- tracking.service.logentriesImpl.js
- tracking.service.dummy.js

## style updates
- all module api return statements are inline objects and not vars
- remove starting semicolon from modules