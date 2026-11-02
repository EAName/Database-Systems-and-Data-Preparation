# Normalization through business rules

Source: [`Normalization through Business Rules.pdf`](../Normalization%20through%20Business%20Rules.pdf) (3 pages). Most of the relations in the PDF are spreadsheet screenshots; they were transcribed here by reading the page images. Dependency notation follows the submission (`A -> B` means A determines B).

The assignment had two parts: a hotel staffing agency table and the Wellmeadows Hospital patient medication form (a textbook case study). Each part takes an unnormalized sample to 1NF, then 2NF, then 3NF, with business rules and dependencies written out at each step.

## Part I: agency staff working at hotels

An agency supplies part-time and temporary staff to hotels in Scotland. The National Insurance Number (NIN) is unique for every member of staff.

Sample data:

| NIN | contractNo | hours | eName | hNo | hLoc |
|-----|-----------|-------|-------|-----|------|
| 1135 | C1024 | 16 | Smith J | H25 | East Killbride |
| 1057 | C1024 | 24 | Hocine D | H25 | East Killbride |
| 1068 | C1025 | 28 | White T | H4 | Glasgow |
| 1135 | C1025 | 15 | Smith J | H4 | Glasgow |

1NF: `(NIN, contractNo), hours, eName, hNo, hLoc`

### Business rules and dependencies (as submitted)

- `hLoc` (non-prime) depends on `hNo`.
- `eName`, `hours`, and `contractNo` depend on `NIN`.
- These are the partial dependencies: `hNo -> hLoc` and `NIN -> eName, hours, contractNo`.
- Transitive dependency: `NIN -> hNo -> hLoc`.

### 2NF (partial dependencies removed)

- Staff assignment: `NIN (PK), contractNo, hours, eName, hNo (FK)`
- Hotel: `hNo (PK), hLoc`

### 3NF (transitive dependency removed)

- Staff assignment: `NIN (PK), contractNo, hours, eName, hNo (FK)`
- Hotel: `hNo (PK), hLoc`
- NIN: `NIN (PK), hNo (PK), hLoc`

Reviewer note (added now, not in the original submission): in the sample, NIN 1135 appears twice with different contracts and hours, so `NIN` alone cannot be the primary key of the assignment relation; `(NIN, contractNo)` from the 1NF step is the real key, and `hours` depends on the full key. `eName` depends on `NIN` alone and `hNo`/`hLoc` on `contractNo`, which is where the partial dependencies actually sit. The third "NIN" relation in the submitted 3NF also repeats `hLoc`, which reintroduces the transitive dependency it was meant to remove. A cleaner 3NF is `Staff(NIN, eName)`, `Contract(contractNo, hNo)`, `Hotel(hNo, hLoc)`, `Assignment(NIN, contractNo, hours)`.

## Part II: Wellmeadows Hospital patient medication form

Wellmeadows Hospital has 17 wards with 240 beds and an outpatient clinic. Each ward has a number (for example ward 11) and a name (for example Orthopaedic). Patients get a unique patient number on referral. When medication is prescribed the hospital records patient name and number, drug number and name, units per day, method of administration (oral or IV), and start and finish dates. The sample form is for patient P10034, Robert MacDonald, ward 11 (Orthopaedic), bed 84:

| Drug Number | Name | Description | Dosage | Method of Admin | Units per Day | Start Date | Finish Date |
|-------------|------|-------------|--------|-----------------|---------------|------------|-------------|
| 10223 | Morphine | Pain Killer | 10mg/ml | Oral | 50 | 24/03/13 | 24/04/14 |
| 10334 | Tetracyclene | Antibiotic | 0.5mg/ml | IV | 10 | 24/03/13 | 17/04/13 |
| 10223 | Morphine | Pain Killer | 10mg/ml | Oral | 10 | 25/04/14 | 02/05/15 |

1NF with a combined primary key:
`(patientNo, drugNo, startDate), fullName, wardNo, wardName, bedNo, drugName, description, dosage, methodOfAdmin, unitsPerDay, finishDate`

### Partial dependencies (as submitted)

1. `patientNo -> fullName, finishDate`
2. `wardNo -> wardName`
3. `drugNo -> drugName, description, methodOfAdmin`
4. `startDate -> finishDate, drugNo, patientNo`

### Transitive dependencies (as submitted)

1. `patientNo -> wardNo -> bedNo`
2. `patientNo -> drugNo -> drugName`
3. `drugNo -> dosage -> unitsPerDay`
4. `patientNo -> startDate, drugNo -> finishDate`

### 2NF

- Patient: `patientNo, fullName, startDate, finishDate, drugNo, wardName`
- Ward: `wardNo, wardName, bedNo`
- Drug: `drugNo, drugName, description, methodOfAdmin`

### 3NF (keys as submitted)

- Patient: `patientNo (PK), fullName, startDate, finishDate, drugNo (FK), wardNo (FK)`
- Ward: `wardNo (PK), wardName, bedNo`
- Drug: `drugNo (PK), drugName, description, methodOfAdmin`
- Treatment: `patientNo (PK), startDate (PK), dosage, drugNo (FK)`

Reviewer note (added now): with hindsight, a few of these dependencies come from the three sample rows rather than from the business rules. `bedNo` belongs to the patient's stay, not the ward (a ward has many beds), and `finishDate` and `unitsPerDay` belong to a specific prescription, not to the patient or the dosage. A tighter 3NF keys the medication fact on `(patientNo, drugNo, startDate)` with `unitsPerDay` and `finishDate` on it, keeps `bedNo` and `wardNo` on the patient, and leaves `dosage` on the drug if the form's dosage is a property of the drug formulation.
