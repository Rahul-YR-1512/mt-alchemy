import 'package:flutter/material.dart';

class CourseModule {
  final String title;
  final bool locked;

  const CourseModule(this.title, {this.locked = true});
}

class Course {
  final String id;
  final String title;
  final String category;
  final double price;
  final double rating;
  final int ratingCount;
  final String tagline;
  final String description;
  final List<Color> gradient;
  final String instructor;
  final int hours;
  final int moduleCount;
  final String level;
  final bool certificate;
  final List<String> objectives;
  final List<CourseModule> modules;

  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.ratingCount,
    required this.tagline,
    required this.description,
    required this.gradient,
    required this.instructor,
    required this.hours,
    required this.moduleCount,
    required this.level,
    required this.certificate,
    required this.objectives,
    required this.modules,
  });
}

enum ProductType { digital, physical }

class Product {
  final String id;
  final String name;
  final double price;
  final String tag;
  final ProductType type;
  final List<Color> gradient;
  final String description;
  final String icon;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.tag,
    required this.type,
    required this.gradient,
    required this.description,
    required this.icon,
  });

  String get typeLabel => type == ProductType.digital ? 'Digital' : 'Physical';
}

class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, this.quantity);

  double get lineTotal => product.price * quantity;
}

class Order {
  final String id;
  final double amount;
  final String status;
  final List<Product> items;

  const Order({
    required this.id,
    required this.amount,
    required this.status,
    required this.items,
  });
}

class EmployeeProgress {
  final String name;
  final String department;
  final String course;
  final double progress;
  final String status;

  const EmployeeProgress({
    required this.name,
    required this.department,
    required this.course,
    required this.progress,
    required this.status,
  });
}

class InsightArticle {
  final String title;
  final String summary;
  final String type; // Article, Guide, Video
  final String category;
  final String date;
  final int readMins;

  const InsightArticle({
    required this.title,
    required this.summary,
    required this.type,
    required this.category,
    required this.date,
    required this.readMins,
  });
}

class ServiceItem {
  final String title;
  final String description;
  final String forWho;
  final List<Color> gradient;
  final IconData icon;

  const ServiceItem({
    required this.title,
    required this.description,
    required this.forWho,
    required this.gradient,
    required this.icon,
  });
}

class ImpactStory {
  final String title;
  final String industry;
  final String outcome;

  const ImpactStory({
    required this.title,
    required this.industry,
    required this.outcome,
  });
}