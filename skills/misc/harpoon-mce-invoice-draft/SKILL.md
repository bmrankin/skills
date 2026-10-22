---
name: harpoon-mce-invoice-draft
description: Build Bryan's semi-monthly MCE draft invoice in Harpoon by importing unbilled time grouped by task, for a billing period he names (1–15 or 16–EOM).
disable-model-invocation: true
argument-hint: "Billing period, e.g. 10/1 - 10/15"
---

# MCE semi-monthly draft invoice (Harpoon)

MCE is billed twice a month: the **1st–15th** and the **16th–end of month**. This skill builds one DRAFT invoice for a single period. The time entries are imported through the Harpoon web app in Claude in Chrome, where Bryan is already logged in, and grouped by task.

## Inputs
- **Billing period**: ALWAYS ask Bryan which period, unless he named it in the request. Never infer it from today's date.
- **Expected figures** (optional): per-task hours and amounts, plus the total. If Bryan gives them, check the draft against them as well.

## Hard rules
- Leave the invoice as a **draft**. Never send it, email it or mark it sent.
- Never delete anything.
- **Saving marks the imported time entries as billed.** Before clicking Save, always show Bryan the draft (lines, totals, subject, project) and wait for an explicit yes.
- Don't change the rate, issue date, due date / Payment Due, discount, shipping or any other setting unless Bryan says so.
- If any figure doesn't match, stop and report the differences. Never adjust anything to make the numbers match.
- If something is ambiguous, ask instead of guessing.

## Fixed values
- Client: **MCE** (there is one exact match). Project: **MCE**.
- Subject: the period as `M/D - M/D`, e.g. `10/1 - 10/15` or `10/16 - 10/31`.
- Each line description is just the task name in brackets, e.g. `[IT - General]` or `[ERP - Development]`.

## Steps
1. **Pre-check with the connector.** Call `mcp__Harpoon_App__list-time-entries` with the period's start_date/end_date, client MCE (id 42812) and billed_status `unbilled`. Total the hours and value per task and overall. These are the expected figures. If Bryan supplied figures and they differ from these, stop and report the difference before building anything.
2. In Chrome, go to **Invoices** and click **Create New Invoice** (top right).
3. Open the **Client** dropdown, type `MCE` and select **MCE**.
4. Open the **Project** dropdown and select **MCE**.
5. Type the period into **Subject** (format above).
6. Below the line items, click **Add Recorded Hours** and wait for "Loading recorded hours…" to finish.
7. The dialog lists ALL unbilled MCE entries, including old ones from 2017–2025, and **has no date filter**. Do NOT use "Select all". Tick only the rows whose DATE (MM/DD/YY) falls inside the period. The most reliable way is a JS pass over the dialog's `tr` rows: match column 1 against the period's dates and `.click()` each unchecked checkbox. Then confirm the count of checked rows equals the connector count from step 1.
8. Under "How would you like to display these hours?", select **Group by task**. The dialog moves up the screen after rows are ticked, so take a fresh screenshot or use `find` before clicking. Confirm the banner reads "N entries selected, adding T line items", where T is the number of distinct tasks (usually 2), and that its Total matches step 1.
9. Click **Add Selected (N)**. The grouped lines replace the empty default line.
10. **Trim the descriptions.** The fields are contenteditable DIVs, and Ctrl+A does NOT select their text: typing just puts the new text in front of the old. For each `[contenteditable=true]` that starts with `[Task]`: focus it, select its contents with a Range, then run `document.execCommand('insertText', false, '[Task]')`. Read the fields back to confirm each contains exactly `[Task]`.
11. **Verify the form**: client MCE, project MCE, subject, one line per task with hours, $75 rate and amounts matching step 1 (and Bryan's figures if he gave any), and Subtotal/Total. Issue date, Payment Due, discount and shipping stay at their defaults.
12. **Stop and ask Bryan** before saving. Show the lines and totals and say that Save will mark the N entries as billed.
13. Once he says yes, click **Save**. The page goes to Invoice Details with status **DRAFT**.
14. **Post-save check**: call `list-time-entries` for the period again. All N entries should show `billed_status: billed`, with totals equal to the invoice. Entries outside the period must still be unbilled.

## Report back
Give the invoice number, status (Draft), the lines table and the totals. Confirm the entries were marked billed. List any discrepancies or anything that behaved unexpectedly.