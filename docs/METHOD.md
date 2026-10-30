# Method: the criteria inside the agents

The detailed rules behind the [README](../README.md). The skills themselves are in Spanish; see the [glossary](../GLOSSARY.md). · [Versión en español](METODO.md)

## 1. One shared severity scale

Each level means the same in every discipline.

| Level | Meaning |
|---|---|
| 🔴 4 · Critical | Prevents an essential task, or may cause a serious or hard-to-reverse consequence |
| 🟠 3 · Major | The task can be completed only with great difficulty or a relevant risk of error |
| 🟡 2 · Moderate | Noticeable friction; the task is completed with extra effort or a workaround |
| ⚪ 1 · Minor | Low impact on the task (not "cosmetic", not "compliant") |
| 🟢 0 · No issues detected | Evaluated with the available evidence; nothing found within scope. Not a certification |
| ⚫ Not evaluated | Not enough evidence to judge |

## 2. Four shared approval states, separate approval rules

**Approved · Approved with observations · Pending verification · Not approved.**

Severity and approval are separate dimensions:

- **Heuristics:** an isolated 🟡 2 means *Approved with observations*. A confirmed red line means *Not approved*.
- **Accessibility:** any confirmed WCAG 2.2 A/AA failure means *Not approved*, even at ⚪ 1. Conformance is not graded; severity only sets remediation priority.

## 3. Coverage

Every evaluation declares what it actually covered: **Evaluated · Partially evaluated · Not evaluated · Not applicable**. "Not applicable" is never assumed: a person confirms it when signing the scope. Until then, it stays *Not evaluated*.

## 4. Evidence rules

- **Missing information is not suspicious.** What the brief does not provide goes to *Required evidence*, never to a finding.
- **An assumption never confirms a finding.** Without observed evidence, a red line can be at most a *grounded indication*.
- **Calculated, not estimated.** Contrast ratios come from a script on the declared colours.
- **Traceability.** Every report states date, skill version, object evaluated and reviewer.
- **Independence.** Every audit starts from scratch; previous reports are never read.

## 5. Red lines

Problems that block approval by themselves, whatever else is right on the screen. Heuristics has 14 (critical usability and deceptive patterns: moving money without a summary, an error with no way out, an uncertain result, hidden costs, forced consent…). Accessibility treats failures that block an essential step, such as invisible focus on the only field of a signing step, as red lines.

## 6. Product risk is not WCAG

Banking risks that are not WCAG criteria (fraud exposure, uncertain states, pre-ticked consents…) are recorded separately with severity and risk category (economic, legal, operational). They never appear as WCAG failures and never change the accessibility approval state.

## 7. How the orchestrator aggregates

- **Most restrictive wins:** Not approved > Pending verification > Approved with observations > Approved.
- **No averaging, no compensation** between disciplines.
- It names **which evaluation determines** the global result, and keeps every pending item and observation from the others.
- **The same problem seen by several frameworks is counted once**, keeping the strictest gate.

## 8. Risk acceptance

- A 🟠 3 product risk blocks by default. It can only be accepted with an accountable owner, rationale, scope and conditions.
- A 🔴 4 cannot be released by an ordinary product sign-off.
- **Accepting a risk does not resolve it**, and never unblocks a red line from heuristics or accessibility.
- The orchestrator **never signs on a human's behalf**.

## 9. Permissions

*Evaluate, save and commit are three separate permissions.* An agent asked to evaluate does not write files or touch git unless asked.

## 10. How the tests were designed

- **Answer keys written before testing:** a screen seeded with 15 problems ([`demo/problemas-sembrados.md`](../demo/problemas-sembrados.md)), a correct screen, edge cases and a case where the agent must *not* activate.
- **A fresh session per case.**
- **A sandboxed test environment** for heuristics ([`evals/`](../evals)): no previous reports, no answer keys, no git, and a trace of every file read and action attempted.
- **Skill tests declare the discipline**; neutral prompts are reserved for routing tests.
- **When a test fails, I first check the exam.** Two exams were ambiguous (accessibility case D, heuristics case A); they were corrected and re-run rather than forcing the skill to pass.
- **End-to-end test** of the orchestrator against 10 acceptance gates defined in advance. Accepted with one contained incident (see the README).
