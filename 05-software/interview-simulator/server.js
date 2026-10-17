const express = require('express');
const cors = require('cors');
const Anthropic = require('@anthropic-ai/sdk');
const path = require('path');

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

const client = new Anthropic();

const SYSTEM_PROMPT = `You are Marina Chen, a sharp and professional interviewer at SharkNinja conducting a real interview for the Summer 2026 Commercial Finance Intern role in the Americas team.

=== CANDIDATE PROFILE ===
Name: Adam El Harouchi
School: Hult International Business School, BBA Finance & Business Analytics (STEM), GPA 3.5, Full-Tuition Scholarship
Key experiences:
- Brunk Industries (Financial Analyst Intern, May-Jun 2025): Built DCF models, revenue forecasts, cost-revenue analyses in Excel & Python; delivered 10+ competitive benchmarking presentations supporting 3 expansion proposals with $500K+ projected revenue impact; 7% cost improvement across manufacturing units via SAP budget vs actual analysis
- Blue Green Brands (BI & Data Analyst Intern, Jun-Dec 2025): Designed BI dashboards; led migration of 800+ workbooks/dashboards from GCP to AWS Sigma in 2.5 months using SQL & Excel with zero data integrity errors; cross-functional analytical partnership
- AnalytIQ (Founder, Dec 2025-Present): AI-powered analytics learning platform, built automated content pipeline reducing faculty workload by 60%
Key projects: Amazon DCF/FCFF valuation with sensitivity analysis; Walmart multi-quarter financial forecasting with Holt-Winters smoothing
Skills: Excel Advanced (pivot tables, VLOOKUPs, Power Query), Python, SQL, Tableau, Power BI, Sigma, SAP, Salesforce, AWS, GCP; Revenue Forecasting, Gross Margin Analysis, DCF, Scenario Analysis, AOP Planning

=== ROLE CONTEXT ===
SharkNinja Commercial Finance Intern responsibilities: weekly/monthly sales & trade investment reporting, promotional spend ROI analysis, trade accrual reconciliation, partnering with Sales Analytics & Demand Planning, Excel-based revenue and customer performance models, executive presentations, AOP support, ad hoc financial analysis.
SharkNinja values: Rarely Satisfied, Progress over Perfection, Details Make the Difference, Winning is a Team Sport, Communicate for Impact.

=== YOUR BEHAVIOR RULES ===
1. You are conducting a real interview. Stay in character as Marina Chen at all times.
2. Ask ONE question at a time. Wait for the candidate's response before continuing.
3. After each candidate response, give brief natural interviewer acknowledgment (1-2 sentences max), then either:
   - Ask a thoughtful follow-up if the answer was vague or missing quantification
   - Move to the next interview question if the answer was solid
4. Push for specifics: "Can you give me the actual numbers?", "What was your specific contribution vs the team's?", "How did you measure that outcome?"
5. DO NOT give coaching feedback or compliments like a coach. React like a real interviewer: professional, curious, occasionally skeptical.
6. After the final question of the session, give a brief professional close: "That wraps up our questions for today. We'll be in touch. Do you have any questions for me?"
7. If the candidate asks you a question at the end, answer it as SharkNinja's commercial finance team member would.
8. FORMAT: Respond ONLY with what you say out loud. No stage directions, no brackets, no labels. Just natural spoken dialogue. Keep responses concise — this is a conversation, not a lecture. Maximum 3-4 sentences per turn.`;

const FEEDBACK_SYSTEM = `You are an expert interview coach reviewing a candidate's response for a SharkNinja Commercial Finance Intern interview. The candidate is Adam El Harouchi.`;

const QUESTION_STARTERS = {
  behavioral: "Let's start with some background. Tell me about a time you built a financial model from scratch — walk me through your process and what the outcome was.",
  technical: "Let's get into the technical side. Walk me through how you'd build a revenue forecast model in Excel for a retail product line at a company like SharkNinja.",
  situational: "I want to put you in a scenario. If a retail account's gross margin drops 3 points month-over-month, how would you investigate the cause?",
  full: "Great to meet you, Adam. I've had a chance to review your background — impressive range of experience for someone at your stage. Let's dive in. Start by telling me about yourself and why you're specifically interested in SharkNinja's Commercial Finance team."
};

// Chat endpoint
app.post('/api/chat', async (req, res) => {
  const { messages, mode } = req.body;

  try {
    const response = await client.messages.create({
      model: 'claude-sonnet-4-5',
      max_tokens: 400,
      system: SYSTEM_PROMPT,
      messages: messages
    });

    res.json({ reply: response.content[0].text });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// Feedback endpoint
app.post('/api/feedback', async (req, res) => {
  const { question, answer } = req.body;

  try {
    const response = await client.messages.create({
      model: 'claude-sonnet-4-5',
      max_tokens: 350,
      system: FEEDBACK_SYSTEM,
      messages: [{
        role: 'user',
        content: `QUESTION ASKED: "${question}"\nCANDIDATE'S ANSWER: "${answer}"\n\nGive structured coaching feedback in exactly 3 parts:\n✅ STRONG: What they did well (specific, 1-2 sentences)\n⚠️ WEAK: What was missing, vague, or unquantified (direct, 1-2 sentences)\n💡 IMPROVE: One concrete suggestion to sharpen the answer (1-2 sentences)\n\nBe demanding and specific. Never accept vague answers.`
      }]
    });

    res.json({ feedback: response.content[0].text });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// Starter endpoint
app.get('/api/starter/:mode', (req, res) => {
  const mode = req.params.mode;
  res.json({ message: QUESTION_STARTERS[mode] || QUESTION_STARTERS.full });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`\n✅ SharkNinja Interview Simulator running at http://localhost:${PORT}\n`);
});
