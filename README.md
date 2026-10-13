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

Static design reference for every screen (phone width unless `desktop`). Source images live in `docs/reference/`. A standalone gallery is also available at **[docs/reference/REFERENCE.md](docs/reference/REFERENCE.md)**.

### Diagrams

| Sitemap | User Journeys | ERD |
|---|---|---|
| ![Sitemap](docs/reference/diagrams/sitemap.png) | ![Journeys](docs/reference/diagrams/journeys.png) | ![ERD](docs/reference/diagrams/erd.png) |

### Home & Navigation

| Home | Home (scrolled) | Drawer |
|---|---|---|
| ![Home](docs/reference/screenshots/01_home_mobile.png) | ![Home scrolled](docs/reference/screenshots/01b_home_mobile_scrolled.png) | ![Drawer](docs/reference/screenshots/02_drawer.png) |

### Register & Login

| Register (validation) | Register (filled) | Register (employer) | Login |
|---|---|---|---|
| ![Register validation](docs/reference/screenshots/03_register_validation.png) | ![Register filled](docs/reference/screenshots/04_register_filled.png) | ![Register employer](docs/reference/screenshots/21_register_employer.png) | ![Login](docs/reference/screenshots/05b_login.png) |

### Learning

| Learning Hub | Course Detail | Enrol Dialog |
|---|---|---|
| ![Learning Hub](docs/reference/screenshots/05_learning_hub.png) | ![Course Detail](docs/reference/screenshots/08_course_detail.png) | ![Enrol Dialog](docs/reference/screenshots/09_enrol_dialog.png) |

| Course Player | Player Controls | Learner Dashboard |
|---|---|---|
| ![Course Player](docs/reference/screenshots/10_course_player.png) | ![Player Controls](docs/reference/screenshots/10b_course_player_controls.png) | ![Learner Dashboard](docs/reference/screenshots/11_learner_dashboard.png) |

### Store & Checkout

| Store | Product Detail | Cart |
|---|---|---|
| ![Store](docs/reference/screenshots/12_store.png) | ![Product Detail](docs/reference/screenshots/13_product_detail.png) | ![Cart](docs/reference/screenshots/14_cart.png) |

| Checkout | Checkout (payment) | Checkout (validation) |
|---|---|---|
| ![Checkout](docs/reference/screenshots/15_checkout.png) | ![Checkout payment](docs/reference/screenshots/16b_checkout_payment.png) | ![Checkout validation](docs/reference/screenshots/16_checkout_validation.png) |

| Order Confirmation | Digital Library |
|---|---|
| ![Order Confirmation](docs/reference/screenshots/17_order_confirmation.png) | ![Digital Library](docs/reference/screenshots/18_digital_library.png) |

### Employer

| Employer Dashboard | Add Employee | Employee List |
|---|---|---|
| ![Employer Dashboard](docs/reference/screenshots/22_employer_dashboard.png) | ![Add Employee](docs/reference/screenshots/23_add_employee.png) | ![Employee List](docs/reference/screenshots/23b_employee_list.png) |

| Assign Course | Assign Dialog | Reports |
|---|---|---|
| ![Assign Course](docs/reference/screenshots/24_assign_course.png) | ![Assign Dialog](docs/reference/screenshots/25_assign_dialog.png) | ![Reports](docs/reference/screenshots/26_reports.png) |

### Services, Insights, Contact & About

| Services | Insights | Contact (validation) | Contact (success) | About |
|---|---|---|---|---|
| ![Services](docs/reference/screenshots/07_services.png) | ![Insights](docs/reference/screenshots/27_insights.png) | ![Contact validation](docs/reference/screenshots/19_contact_validation.png) | ![Contact success](docs/reference/screenshots/20_contact_success.png) | ![About](docs/reference/screenshots/06_about.png) |

### Admin (bonus) & Desktop

| Admin Dashboard | Admin Courses | Admin Products |
|---|---|---|
| ![Admin Dashboard](docs/reference/screenshots/33_admin_dashboard.png) | ![Admin Courses](docs/reference/screenshots/34_admin_courses.png) | ![Admin Products](docs/reference/screenshots/35_admin_products.png) |

| Home (desktop) | Learning (desktop) | Player (desktop) |
|---|---|---|
| ![Home desktop](docs/reference/screenshots/30_home_desktop.png) | ![Learning desktop](docs/reference/screenshots/31_learning_desktop.png) | ![Player desktop](docs/reference/screenshots/32_player_desktop.png) |