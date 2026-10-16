# Voice Interview Simulator

**Node.js · Express · Anthropic API · Web Speech API**

A browser-based interview practice tool. You speak your answer, it transcribes via the Web Speech
API, sends it to Claude for evaluation, and returns feedback — built to prepare for a specific
role rather than as a generic question bank.

## How it works

```
Browser (Web Speech API)  ──speech→text──►  Express server
                                                  │
                                            Anthropic API
                                                  │
         feedback  ◄───────────────────────────────┘
```

## Stack
Node.js, Express (100-line server), vanilla JS front end, Web Speech API for voice input,
Anthropic API for response evaluation.

## Design notes
Voice input rather than typing, because the failure mode in a real interview is verbal — rambling,
filler, losing the thread — and none of that shows up when you type an answer you can edit.

Requires Chrome or Edge; the Web Speech API is not supported in Safari or Firefox.

The API key is read from the `ANTHROPIC_API_KEY` environment variable.

## Setup
```bash
npm install
export ANTHROPIC_API_KEY=your_key_here
node server.js   # → http://localhost:3000
```
