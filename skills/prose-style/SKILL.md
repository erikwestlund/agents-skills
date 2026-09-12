---
name: prose-style
description: Erik's prose style: the LLM-isms he bans, plus register, voice, and sentence construction. Load before drafting or editing any prose, and check every draft against the DO NOT list — Erik catalogued these from real drafts and they are firm.
---

# Erik's prose style

Rules for any prose Erik reads, in any project. The Better Shoes sections
further down (numbers, page architecture, argument construction, figure
conventions, house terms, approved phrasings) are one project's application of
them, not a limit on where the rest applies.

Erik drafts in `~/Docs/Better Shoes/prose/`. Numbers come from
`prose/numbers.json`, which the pipeline generates: articles cite them with
`{{num:key}}`, and an unknown key fails the render. Never hand-edit it or
carry a number in from elsewhere — if a value isn't there, re-run the pipeline
rather than putting a number on the page.

## The Trend Behind Every Rule (read this first)

Erik's corrections all point one direction: strip away the writer
performing until what remains is a reader using. Three strands:

1. **The page is a reference document, not an essay.** Nothing on the page
   performs — no cleverness, drama, self-commentary, callbacks, or
   metaphors. Content is organized for use: principles up front, evidence in
   the middle, technical detail in the FAQ, advice at the end.
2. **Structure and figures persuade, not sentences.** Figures are the most
   important element of these pages. Where a figure exists, the section
   leads with it and the prose walks the reader through what they are
   looking at ("Figure 3 shows... If the dots sat on the diagonal..."). A
   sentence that has to be persuasive on its own rhetoric is a sentence to
   cut. Organization carries the argument.
3. **Respect the reader; don't manage them.** No overselling, no
   over-defending, no pedantic hand-holding, no emotional framing of
   findings. State the claim, show the data, move on. The reader is a
   skeptical, intelligent runner.

When a new sentence or structure choice is in doubt, ask: is the writer
performing, or is the reader using? Keep only the second.

## Register

Dispassionate and lightly academic, not punchy. The page can function as
marketing, but it must not read like marketing. When choosing between a
conversational construction and a formal one, choose the formal one:

- Wrong: "We can put numbers on that worry, because we have studied it in
  our own data."
- Right: "We have quantified this concern using our data and statistical
  methods."

Lean academic over clever everywhere, including figure titles and captions.

## Voice (observed from Erik's own drafting)

- Openings are scenario-based and third person: describe the runner's
  situation plainly ("Runners often find themselves..."), then "Consider
  these two scenarios." with concrete cases, then the advice. Scenarios stay
  at the product level ("well-rated by initial anonymous reviewers on retail
  sites") and never quote the site's own scores; our ratings and their
  numbers enter only after the reader has been told what they are. Advisory register
  is direct: "We suggest using the ratings on this site, including the Shoe
  Finder, to help you in this process."
- Explain-then-example beats compressed parallelism. The triplet "Some
  advice holds up, such as X. Some does not, such as Y. Some needs
  refining, such as Z." was rejected as not-Erik; the fix walks through the
  same content in ordinary sequential sentences, one claim per sentence,
  ending with "We cover each of these questions below, with the evidence."
- Introduce a concept by teaching it, then attach the example: "Every
  rating comes with a range showing how much evidence supports it. A new
  shoe with few reviews has a wide range... In the scenario above, the
  Clifton 11's 89 spans 49 to 99."

- Plain declarative sentences. State the fact; do not perform it.
- Address the skeptical experienced runner. Third person for runners in
  general, second person at decision moments.
- Rhetorical questions in runs of two or three are fine: "And how different
  is a 4.6 from a 4.7 when there's 10 reviews? What about when there's 1,000?"
- First person plural throughout.
- Transitions Erik uses: "Moreover," "Yet," "Nevertheless," "On top of that."
- Headers in Title Case, framed as plain topics or problems, never as
  cleverness.
- Bullets are for enumerations with parallel stems; arguments are paragraphs.

## DO NOT — LLM-isms (all catalogued by Erik from real drafts)

Each entry: the pattern, an offending example, the fix.

- **"{X}, not {Y}" antithesis.** "They are a starting point, not a vote."
  State the fact once, plainly: say what the thing is and stop.
- **"It is not X. It is Y." dramatic reversal.** "So an average is not the
  cautious choice. It is the risky one." Same fix.
- **Cute contrast headers: "Same X, Different Y".** "Same Score, Different
  Confidence." Use a plain topic header instead.
- **Cute contrast figure titles: "One X, one Y" / "Plenty of X, or almost
  none" / "X, or Y".** "One shoe, one source of evidence at a time."
  Figure titles are descriptive and academic: say what the figure shows.
- **"The {X}" definite-article headers.** "The Five Sub-Ratings" → 
  "Sub-ratings" or "Accounting for Sub-ratings."
- **"So..." and other informal header openers.** "So How Should You Buy?" →
  "An Evidence-Based Shoe-Buying Strategy."
- **Callback narration** — prose that references the page's own structure
  ("Back to the question we opened with:") is "too cute". Just ask or state
  the thing directly; the reader remembers the opening without being told.
- **Self-approving narration** — commentary telling the reader why the
  sentence they are reading matters. "...because the handling is where the
  trust is earned" ("annoying as shit" — Erik). Never narrate the prose's own
  virtues; just present the material.
- **Sloganized advice closers.** "Pick from the top of the list, and let
  comfort on your own feet decide among them." — "marketing shit" (Erik).
  When a paragraph's information is done, stop; do not append a
  call-to-action rhythm line restating it.
- **Epigram pairs and coined metaphors.** "The brand is a prior; the shoe
  is the evidence." / "The ceiling is available at every price." / "the glow
  a fresh shoe carries" — all removed in the register audit. If a sentence
  or coinage can be deleted or replaced with a plain term ("baseline",
  "new-shoe boost") without changing the meaning, it is register, not
  content: remove it.
- **Standfirst register.** Two failure modes, both Erik-flagged. The tease
  ("…now run past $180. We checked what the extra money buys." — "gross")
  withholds the topic for drama. The rhetorical-question pivot ("Every
  runner has a brand loyalty. Does the data support one?" — "again,
  annoying") performs curiosity. The house form is one plain declarative
  of what we do: "We explore whether any brands truly stand out among
  their peers." Questions in standfirsts only when Erik writes them
  himself.
- **"The question is…" pivots.** Erik replaced these twice with the same
  form: state the article's task directly ("We explore whether brands
  serve as a useful shortcut when buying shoes."). Introductions pivot
  with "We explore/measure/test whether X", never by naming the question.
- **Throat-clearing openers.** "The first thing to know about X is that…" /
  "The question worth answering is…" / "One point of care applies in
  reading this." / "The catch is that…" — all removable without changing
  meaning, so remove them ("there is no point to this" — Erik). Start the
  sentence at its content.
- **Punchy closing kickers.** "The discount is the part you control." —
  "annoying AI-ease" (Erik). End paragraphs on the information, never on a
  drum hit.
- **Comma overuse.** "you liked this one, and it's still for sale" → "you
  like this shoe and it's still for sale" ("you use too many commas" —
  Erik). Short paired clauses join with a bare "and"; save commas for
  sentences that need them. Erik has also asked for fewer colons and
  semicolons.
- **Em dash overuse.** Prefer a second sentence or parentheses.
  An em dash is occasional, not a house style.
- **Relationship/defensive framing toward the reader.** "Reorder a list
  behind your back" ("we're not in a relationship" — Erik). Describe
  operations factually: lists update daily from data without human
  intervention, except legitimacy screening of reviews.
- **Metaphors for statistical concepts.** "Split reviews into two juries" →
  raters, reviewers, samples. Plain terms only.
- **Mechanism metaphors.** "The rating is the one lever with a measured
  effect" — "a rating is not a lever, stop it. NO LEVERS" (Erik). State the
  relationship: "The only thing that consistently predicts a better shoe is
  a better rating."
- **Heading capitalization: capitalize all words**, consistently, including
  short ones ("Principles Of An Evidence-Based Buying Strategy").
- **Self-assuring headers: "Why This Result Is Believable".** The header
  argues for the prose instead of stating a topic. Say what the section
  does instead ("Ruling Out A Weak Test").
- **Question headers as a habit.** "Could The Test Be Too Weak?" — "lazy"
  (Erik). Headers say what the section does; a question header is allowed
  only when the question really, really beats any statement of the job
  ("Is This AI Slop?" qualifies; most do not). Never more than one or two
  question headers on a page.
- **"How We Measured This" appendix sections.** Erik: it reads like a
  measurement (instrumentation) claim while meaning "how we analyzed", and
  the details belong inline anyway. Articles carry no methods appendix:
  each methodological detail lives in the section that makes the claim it
  supports, or it goes.
- **Paired-concern headers.** "Who Our Reviewers Are, and How We Get Paid" —
  separate distinct concerns into their own sections.

## Sentence construction (from diffing Erik's line edits against drafts)

- A count gets its own short declarative sentence. Never append it as a
  trailing appositive: "...in the world, more than fifteen thousand of them
  so far" → "...in the world. So far, we have collected over 15,000 reviews."
- No trailing flourishes. "and still arriving" was cut; a sentence ends when
  the information does.
- An intro names the kinds of data, not every count. Secondary
  quantification (a comparison count and its elaboration) was deleted from
  the opening; that detail belongs in the section that uses it.

## Structure

- Address each concern in ONE place, never in detail in two places. If a
  topic (star-rating limitations, an input's handling, uncertainty) appears
  twice, one occurrence is the home and the other shrinks to a sentence or
  disappears.
- Front matter is motivation only; it stays lean. Analytic detail about an
  input lives in the section that handles that input (e.g. star-rating
  clustering and its figure belong in the head-to-head comparisons step,
  where the model addresses it, not in the introductory limitations
  section).
- Lead with how the model is built before discussing how to read its
  outputs; the confidence-range explanation comes after the build
  walkthrough, once the reader has watched ranges narrow in the figures.
- Corpus detail (counts, elaborations like "each one from a single runner")
  does not belong in the introduction.
- Reader-facing parentheticals with survey internals ("about 450 answers in
  its first ten weeks, 91% of them yes") are too much detail. Erik also cut
  the replacement qualifier "(a newer question we treat as a minor input)":
  list bullets stay clean, with no parenthetical qualifiers at all.
- Erik's later line edits, worth generalizing: "It is a forecast from the
  family's record rather than a verdict" became "It is a forecast based upon
  the product line's history" (another antithesis removed; also prefer the
  concrete term "product line" over "family"); "The best way to see" became
  "The easiest way to see" (claim ease, not superiority).

## Explaining statistical machinery

- Name the overall approach once, in one line, trusting the reader's general
  sense of the term: "The approach is Bayesian: the model starts from a
  prior based on the product line's history and retailer ratings, then
  updates it as our reviewers' ratings and comparisons arrive." No further
  formalism.
- Name the problem plainly, then say "The model accounts for this." Never
  describe estimation mechanics. "The model evaluates each comparison
  relative to that baseline rather than at face value" was rejected as
  unclear ("i dont know what this means"); the fix: "Comparisons have a
  known bias: most runners who switch shoes report liking the new one,
  whatever it is. The model accounts for this."
- When evidence risks sounding boastful or extreme in prose (an
  instance-level "our runners put them 40 points apart, the runners win"
  aside "may make us look crazy" — Erik cut it), let a figure carry the
  example quietly instead of asserting it in prose. The policy statement
  (how inputs are weighted) is enough in the text.

## Page architecture (trust page decisions, generalize to other pages)

- The main body is non-technical. On the trust page, the FAQ at the bottom
  is the home for statistical detail (model type, reliability numbers,
  validation results): the body argues, the FAQ documents. The buying guide
  carries NO FAQ (Erik removed it): overflow detail goes to the
  special-topic articles instead, and evidence that justifies a claim
  appears briefly in the body with its figure. A taste of the stats is good for this audience, but only
  numbers that carry an argument stay in the body (e.g. a range of 49 to 99
  stays; split-half reliabilities move to the FAQ).

- A concept referenced in passing (the range, in the walkthrough steps) gets
  one priming sentence at first use, with the full treatment staying in its
  own later section. Never let a forward reference dangle.
- The buying handoff closes the page. Housekeeping sections (list
  maintenance, compensation, AI use) cluster together before it.
- "Is This AI Slop?" is an approved header: a blunt question the reader is
  actually asking may be a header, answered with "No." and a factual list.
  This differs from the banned informal openers ("So...") because the
  bluntness is the reader's, not the writer's chumminess.
- "widely used" beats "state-of-the-art" (marketing register); headers
  addressing the site's work use gerunds ("Using Data Science To..."), not
  imperatives ("Use...") which read as instructions to the reader.

## Argument construction (buying guide decisions)

- Lead evidence with the concrete lived scenario, then widen to the general
  result. The pronation argument goes: shop diagnoses overpronation and
  sells a stability shoe → the data says overpronators do not rate them
  better, no shoe does better with overpronators, they actually favor
  neutral shoes → link the detailed analysis → THEN "pronation is not a
  special case" and the eight-traits null. Never open with the abstract
  eight-traits result.
- A defense of a principle is a subsection (###) under that principle's
  section, never a peer section.
- Guides are principles-first: core principle in bold, numbered supporting
  principles, then body sections justifying them in order, closing with a
  short prose restatement. One list per page, at the top.
- A rationally obvious principle (rebuy what works) does not need evidence
  hedging; "some runners need the reminder" is reason enough to state it.

## Positioning: respect the model's own inputs

- No inside baseball. Model-history asides (a removed popularity term, what
  the changelog says) do not belong on reader-facing pages — "who cares, cut
  it" (Erik). The page describes the model as it is; history lives in the
  changelog itself.
- Do not disparage inputs the model depends on. Star ratings are an input to
  our ratings; prose that makes them sound worthless undermines our own
  method. Frame their limitation as missing context (how many, from whom,
  compared to what), which the model supplies. The "shoe explains ~2% of a
  single rating" stat was cut everywhere for this reason.
- No rehabilitative oversell either: "Star ratings are not the problem; they
  are the foundation of our ratings" was rejected ("foundation oversell",
  "I hate 'are not the problem'"). State the balanced position flatly:
  "Star ratings remain a useful signal, and they are one of the inputs to
  our own model."
- Section headers stay measured: "Limitations of Star Ratings", not "The
  Problem With Star Ratings" and not "What Star Ratings Alone Cannot Tell
  You".

## Figure design conventions

- Figure titles, subtitles, and legends are CENTERED (titles/subtitles are
  HTML in the x-data-figure component; legends are centered inside the
  R-generated SVGs). Captions stay left-aligned below the figure.
- Figure references in prose read ", as shown in Figure N below", not
  "(see Figure N)".
- Where a figure exists for a section, the section leads with it and the
  prose walks the reader through it.
- Paired figures share a layout when they carry a contrast (stability lower
  for every group / cushioning higher for every group use the same dot-plot
  design).

## Figures: no frequentist intervals

Erik (2026-08-30): do not show frequentist intervals (95% CIs, standard
error bars) in any public figure. Show the estimates. Bayesian posterior
ranges (score ranges, the per-shoe effect ribbon) and permutation/chance
bands (the trait-agreement gray band) are fine: those are the site's own
uncertainty language, not error bars.

## American English

All reader-facing prose uses American spellings: catalog (not catalogue),
color, gray, artifact, favor. Erik flagged catalogue directly; sweep for
the rest.

## Numbers

- Rounded numbers are still numerals: "over 15,000," not "more than fifteen
  thousand." Round the value; do not spell it out in words.
- Round large corpus/inventory numbers: "hundreds of thousands of outside
  ratings," never "more than 250,000"; never precise-to-one-shoe counts like
  "386."
- Source of truth: `~/Docs/Better Shoes/prose/numbers.json`, generated by
  `R/work/philosophy/16_numbers.R`. Never hand-edit it, and never carry a
  value in by hand; re-run the pipeline instead.
- Instance-level facts stay instance-level (retail rates Pegasus 41 over
  Clifton 9; never generalize to "retail can't tell shoes apart" — tested,
  false).
- Say median when the copy means "typical" and the distribution is skewed.

## Business sensitivity: small review counts

Many catalogue shoes have roughly 8 reviews, and recent pushes got top shoes
to only 15–20. Do not foreground how unreliable an 8-review average is as if
8 reviews were laughably few — that describes our own inventory. Small-sample
honesty goes in its own later section (e.g. "What About Shoes With Fewer
Reviews?") framed as what the model does about it: priors, product-line
record, and external data support low-review ratings; the naked average is
what fails at small n, not our rating.

## Approved phrasings (use these or close variants)

- "We will not claim to be able to pinpoint a single shoe that is perfect
  for you, but we will help you make a scientifically informed choice that
  is more likely to be right."
- Section headers Erik has chosen: "Building a Baseline Estimate From Real
  Data" (was "The Starting Estimate"), "Include Reviewer Ratings" (was "Our
  Star Ratings"), "Head-to-Head Shoe Comparisons" (always include the word
  "shoe"), "Assessing the Accuracy and Effectiveness of Our Approach" (was
  "Does It Work?"), "An Evidence-Based Shoe-Buying Strategy" (was "So How
  Should You Buy?", then "A Rational Shoe-Buying Strategy").

## House terms

- **"Evidence-based", never "rational".** Erik (2026-09-02): "we will prefer
  the phrase evidence-based for now." The buying strategy and the guide that
  carries it are evidence-based. "Rational" is out of reader-facing prose as
  the framing word for our method, headings included. Where "rational" was
  carrying the ordinary sense of reasonable or justified, do not substitute
  "evidence-based" — it reads badly; rewrite the sentence ("whether brand is a
  useful basis for deciding which shoes to buy", "product line loyalty is
  better justified").

- **External sources are linked, never formally cited.** Erik (2026-09-02):
  "Don't use a formal citation, just link to the paper." Link a descriptive
  phrase inside the sentence, exactly the way the site links its own analyses,
  so an outside source and an internal one read identically to a reader. No
  author-year, no author names, no journal titles, and no DOI strings in the
  visible text, and no References or Sources section. The rule was set when the
  buying guide became the first page on the site to reference outside
  literature: before that, every link under `content/` was internal. Where a
  cited figure comes from outside work, make that unmistakable in the sentence
  so no reader takes it for one of ours (see the Numbers section).

## Other bans (from earlier feedback)

- No equations in public prose, and no p-values either; a figure showing the observed value against the chance band carries the same argument.
- Don't repeat a point across sections; reference it or trust it.
- No fragment-style drama; write complete sentences.

## Concrete subjects, not abstractions

Don't make an abstract noun the subject of a sentence ("The certainty comes
from the 21 reader ratings behind it" — Erik: "sounds so stupid"). Make the
concrete thing the subject and attach the reason: "This shoe has above-average
certainty because 21 runners have rated it." Applies to UI captions as much as
articles.
