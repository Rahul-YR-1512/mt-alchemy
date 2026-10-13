import 'package:flutter/material.dart';
import 'models/models.dart';
import 'pages/about_page.dart';
import 'pages/add_employee_page.dart';
import 'pages/assign_course_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/contact_page.dart';
import 'pages/course_detail_page.dart';
import 'pages/course_player_page.dart';
import 'pages/employer_dashboard_page.dart';
import 'pages/home_page.dart';
import 'pages/insights_page.dart';
import 'pages/learner_dashboard_page.dart';
import 'pages/learning_hub_page.dart';
import 'pages/login_page.dart';
import 'pages/my_digital_products_page.dart';
import 'pages/order_confirmation_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/register_page.dart';
import 'pages/reports_page.dart';
import 'pages/services_page.dart';
import 'pages/store_page.dart';

class Routes {
  static const home = '/';
  static const about = '/about';
  static const services = '/services';
  static const upskilling = '/upskilling';
  static const store = '/store';
  static const insights = '/insights';
  static const contact = '/contact';
  static const cart = '/cart';
  static const login = '/login';
  static const register = '/register';
  static const employerDashboard = '/employer-dashboard';
  static const learnerDashboard = '/learner-dashboard';
  static const courseDetail = '/course-detail';
  static const coursePlayer = '/course-player';
  static const productDetail = '/product-detail';
  static const checkout = '/checkout';
  static const orderConfirmation = '/order-confirmation';
  static const myDigitalProducts = '/my-digital-products';
  static const addEmployee = '/add-employee';
  static const assignCourse = '/assign-course';
  static const reports = '/reports';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case Routes.about:
      return MaterialPageRoute(builder: (_) => const AboutPage());
    case Routes.services:
      return MaterialPageRoute(builder: (_) => const ServicesPage());
    case Routes.upskilling:
      return MaterialPageRoute(builder: (_) => const LearningHubPage());
    case Routes.store:
      return MaterialPageRoute(builder: (_) => const StorePage());
    case Routes.insights:
      return MaterialPageRoute(builder: (_) => const InsightsPage());
    case Routes.contact:
      return MaterialPageRoute(builder: (_) => const ContactPage());
    case Routes.cart:
      return MaterialPageRoute(builder: (_) => const CartPage());
    case Routes.login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case Routes.register:
      final useEmployer = settings.arguments is bool
          ? settings.arguments as bool
          : false;
      return MaterialPageRoute(
        builder: (_) => RegisterPage(startAsEmployer: useEmployer),
      );
    case Routes.employerDashboard:
      return MaterialPageRoute(builder: (_) => const EmployerDashboardPage());
    case Routes.learnerDashboard:
      return MaterialPageRoute(builder: (_) => const LearnerDashboardPage());
    case Routes.courseDetail:
      return MaterialPageRoute(
        builder: (_) => CourseDetailPage(course: settings.arguments as Course),
      );
    case Routes.coursePlayer:
      return MaterialPageRoute(
        builder: (_) => CoursePlayerPage(course: settings.arguments as Course),
      );
    case Routes.productDetail:
      return MaterialPageRoute(
        builder: (_) =>
            ProductDetailPage(product: settings.arguments as Product),
      );
    case Routes.checkout:
      return MaterialPageRoute(builder: (_) => const CheckoutPage());
    case Routes.orderConfirmation:
      return MaterialPageRoute(builder: (_) => const OrderConfirmationPage());
    case Routes.myDigitalProducts:
      return MaterialPageRoute(builder: (_) => const MyDigitalProductsPage());
    case Routes.addEmployee:
      return MaterialPageRoute(builder: (_) => const AddEmployeePage());
    case Routes.assignCourse:
      return MaterialPageRoute(builder: (_) => const AssignCoursePage());
    case Routes.reports:
      return MaterialPageRoute(builder: (_) => const ReportsPage());
    default:
      return MaterialPageRoute(builder: (_) => const HomePage());
  }
}