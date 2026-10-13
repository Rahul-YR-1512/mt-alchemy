# MT Alchemy

A mobile-first **Flutter app prototype** for MT Alchemy — a human-centred people development consultancy focused on Emotional Intelligence, Leadership Development, Team Engagement and Workplace Well-being.

> "We don't just run activities. We shift mindsets, behaviours, and team culture."

## Design system — "Calm Alchemy"

| Token | Value |
|---|---|
| Background | `#FAF9FF` soft lavender |
| Cards | White, 24px radius, soft shadow |
| Hero gradient | `#1F1A8C` deep blue → `#8E7FE0` purple |
| Primary actions | `#FFE863` yellow pill buttons |
| AppBar / primary buttons | `#1F1A8C` deep blue |
| Tags / table headers | `#EFEBFF` lavender |
| Headings | Poppins Bold |
| Body | Inter |

## Pages (21)

Home · About · Register · Login · Learning Hub · Course Detail · Course Player · Learner Dashboard · Store · Product Detail · Cart · Checkout · Order Confirmation · My Digital Products · Employer Dashboard · Add Employee · Assign Course · Reports · Services · Insights · Contact

## User journeys

- **A** — Home → Register → Learning Hub → Course Detail → Enrol → Course Player → Learner Dashboard
- **B** — Store → Product Detail → Cart → Checkout → Order Confirmation → My Digital Products
- **C** — Register (Employer) → Employer Dashboard → Add Employee → Assign Course → Reports

## Run it locally

```bash
flutter pub get
flutter run
```

Responsive layouts for phone, tablet and web. No backend required — all data is static sample data.

## GitHub Pages

Pushing to `main` triggers `.github/workflows/deploy.yml`, which builds the web app and publishes it to the `gh-pages` branch:

```
https://<username>.github.io/<repository>/
```

## Reference screenshots & diagrams

| Home | Store | Employer Dashboard |
|---|---|---|
| ![Home](docs/reference/screenshots/01_home_mobile.png) | ![Store](docs/reference/screenshots/12_store.png) | ![Employer Dashboard](docs/reference/screenshots/22_employer_dashboard.png) |

Full gallery — every screen plus the sitemap, user-journey and ERD diagrams:
**[docs/reference/REFERENCE.md](docs/reference/REFERENCE.md)**