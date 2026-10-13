import 'package:flutter/material.dart';
import '../models/models.dart';

class SampleData {
  static const List<String> countries = [
    'Malaysia',
    'Singapore',
    'Indonesia',
    'Other',
  ];

  static const List<String> industries = [
    'Technology',
    'Finance & Banking',
    'Healthcare',
    'Manufacturing',
    'Education',
    'Retail',
    'Hospitality',
    'Professional Services',
    'Other',
  ];

  static const List<String> teamSizes = [
    '1–10',
    '11–50',
    '51–200',
    '201–500',
    '500+',
  ];

  static const List<String> learningAreas = [
    'Emotional Intelligence',
    'Mindfulness',
    'Leadership',
    'Communication',
    'Team Building',
    'Well-being',
  ];

  static const List<String> departments = [
    'HR Department',
    'Management Team',
    'Finance',
    'Sales',
  ];

  static const List<String> enquiryTypes = [
    'Individual Coaching',
    'Corporate Training',
    'Leadership Development',
    'Team Development',
    'Products',
    'Partnership',
    'Other',
  ];

  static const List<String> statusList = [
    'In Progress',
    'Completed',
    'Not Started',
  ];

  static const List<String> myOrders = ['In Progress', 'Completed', 'Shipped'];

  static final List<Course> courses = [
    Course(
      id: 'c1',
      title: 'Emotional Intelligence Fundamentals',
      category: 'Emotional Intelligence',
      price: 199,
      rating: 4.8,
      ratingCount: 132,
      tagline: 'Master your emotions to lead with clarity.',
      description:
          'A foundational programme that helps professionals understand, regulate and harness their emotions — turning self-awareness into a daily competitive advantage at work.',
      gradient: const [Color(0xFF1F1A8C), Color(0xFF7A6CE0)],
      instructor: 'Mabel Tan KH',
      hours: 6,
      moduleCount: 5,
      level: 'Beginner',
      certificate: true,
      objectives: [
        'Identify your emotional triggers and patterns',
        'Apply self-regulation techniques under pressure',
        'Use empathy to strengthen workplace relationships',
      ],
      modules: const [
        CourseModule('Introduction to Emotional Intelligence', locked: false),
        CourseModule('Self-Awareness', locked: false),
        CourseModule('Self-Regulation', locked: true),
        CourseModule('Empathy in Action', locked: true),
        CourseModule('Building Positive Connections', locked: true),
      ],
    ),
    Course(
      id: 'c2',
      title: 'Mindful Leadership in an AI-Driven World',
      category: 'Leadership',
      price: 299,
      rating: 4.9,
      ratingCount: 98,
      tagline: 'Lead with presence when everything is changing.',
      description:
          'Equip leaders with mindful decision-making and human-centred leadership practices to stay calm, focused and authentic in a rapidly evolving AI-driven world.',
      gradient: const [Color(0xFF8E7FE0), Color(0xFF4A3FBF)],
      instructor: 'Mabel Tan KH',
      hours: 8,
      moduleCount: 5,
      level: 'Intermediate',
      certificate: true,
      objectives: [
        'Cultivate presence and focus in volatile environments',
        'Make balanced decisions with emotional clarity',
        'Inspire authentic leadership across your teams',
      ],
      modules: const [
        CourseModule('The Mindful Leader', locked: false),
        CourseModule('Attention & Focus', locked: false),
        CourseModule('Emotional Agility', locked: true),
        CourseModule('AI & The Human Edge', locked: true),
        CourseModule('Leading with Purpose', locked: true),
      ],
    ),
    Course(
      id: 'c3',
      title: 'Mindfulness for Workplace Well-being',
      category: 'Mindfulness',
      price: 149,
      rating: 4.7,
      ratingCount: 76,
      tagline: 'Small daily practices. Calmer, healthier teams.',
      description:
          'Practical mindfulness exercises designed to reduce stress, prevent burnout and build sustainable well-being habits right in the flow of the workday.',
      gradient: const [Color(0xFF3FC1A9), Color(0xFF1F1A8C)],
      instructor: 'Mabel Tan KH',
      hours: 4,
      moduleCount: 5,
      level: 'Beginner',
      certificate: true,
      objectives: [
        'Build a 5-minute daily mindfulness routine',
        'Manage stress with breathing and body scans',
        'Prevent burnout with sustainable work habits',
      ],
      modules: const [
        CourseModule('Why Mindfulness Works', locked: false),
        CourseModule('Breathe: The 5-Minute Reset', locked: false),
        CourseModule('Body Awareness', locked: true),
        CourseModule('Mindful Working', locked: true),
        CourseModule('Your Well-being Plan', locked: true),
      ],
    ),
    Course(
      id: 'c4',
      title: 'Communication for Effective Teams',
      category: 'Communication',
      price: 179,
      rating: 4.6,
      ratingCount: 54,
      tagline: 'Fewer misunderstandings. Stronger collaboration.',
      description:
          'A practical guide to clear, empathetic and assertive communication — enabling teams to collaborate with fewer conflicts and more trust.',
      gradient: const [Color(0xFFFF9F43), Color(0xFF1F1A8C)],
      instructor: 'Mabel Tan KH',
      hours: 5,
      moduleCount: 5,
      level: 'Beginner',
      certificate: true,
      objectives: [
        'Listen actively and respond with empathy',
        'Give and receive feedback that builds trust',
        'Communicate assertively across styles and cultures',
      ],
      modules: const [
        CourseModule('Communication Basics', locked: false),
        CourseModule('Active Listening', locked: false),
        CourseModule('Feedback that Sticks', locked: true),
        CourseModule('Crucial Conversations', locked: true),
        CourseModule('Team Communication Playbook', locked: true),
      ],
    ),
  ];

  static final List<Product> products = [
    Product(
      id: 'p1',
      name: 'Emotional Clarity Workbook',
      price: 39,
      tag: 'PDF Workbook',
      type: ProductType.digital,
      gradient: const [Color(0xFF1F1A8C), Color(0xFF8E7FE0)],
      description:
          'A 60-page guided workbook of self-reflection prompts, emotional check-ins and practical exercises to turn feelings into clarity and action.',
      icon: 'description',
    ),
    Product(
      id: 'p2',
      name: 'Mindful Moments Digital Journal',
      price: 25,
      tag: 'Digital Journal',
      type: ProductType.digital,
      gradient: const [Color(0xFF8E7FE0), Color(0xFF4A3FBF)],
      description:
          'A beautifully designed 30-day digital journal with daily mindfulness prompts, gratitude pages and weekly reflection rhythms.',
      icon: 'auto_stories',
    ),
    Product(
      id: 'p3',
      name: 'EQ Conversation Cards',
      price: 69,
      tag: 'Card Deck',
      type: ProductType.physical,
      gradient: const [Color(0xFFFFE863), Color(0xFFFFB020)],
      description:
          '54 powerful questions printed on premium cards to spark meaningful EQ conversations in meetings, retreats and team sessions.',
      icon: 'style',
    ),
    Product(
      id: 'p4',
      name: 'Team Engagement Learning Kit',
      price: 189,
      tag: 'Team Kit',
      type: ProductType.physical,
      gradient: const [Color(0xFFFFB020), Color(0xFFFFE863)],
      description:
          'A complete facilitator kit with workbooks, cards and activity guides to run a full team engagement programme with your team.',
      icon: 'inventory_2',
    ),
  ];

  static const List<Order> orders = [
    Order(
      id: 'MA1001',
      amount: 120,
      status: 'Paid',
      items: [],
    ),
    Order(
      id: 'MA1002',
      amount: 85,
      status: 'Shipped',
      items: [],
    ),
  ];

  static const List<Order> confirmItems = [
    Order(id: 'MA1003', amount: 118, status: 'Payment Successful', items: []),
  ];

  static const List<EmployeeProgress> employees = [
    EmployeeProgress(
      name: 'Aisyah Rahman',
      department: 'HR',
      course: 'EQ Fundamentals',
      progress: 80,
      status: 'In Progress',
    ),
    EmployeeProgress(
      name: 'Daniel Lim',
      department: 'Finance',
      course: 'Mindful Leadership',
      progress: 100,
      status: 'Completed',
    ),
    EmployeeProgress(
      name: 'Priya Nair',
      department: 'Sales',
      course: 'Communication for Teams',
      progress: 45,
      status: 'In Progress',
    ),
    EmployeeProgress(
      name: 'Wei Jie Tan',
      department: 'Management',
      course: 'Mindfulness for Well-being',
      progress: 0,
      status: 'Not Started',
    ),
  ];

  static const List<ImpactStory> stories = [
    ImpactStory(
      title: 'Retail leadership team',
      industry: 'Retail · 3-month programme',
      outcome: 'Store-level engagement up 28% after leadership alignment sessions.',
    ),
    ImpactStory(
      title: 'Finance department reset',
      industry: 'Banking · 2-day workshop',
      outcome: 'Team trust scores rose from 52% to 79% in a 6-week follow-up.',
    ),
    ImpactStory(
      title: 'Sales team EQ boost',
      industry: 'Technology · Hybrid cohorts',
      outcome: 'Self-reported stress dropped 34% and close-rate conversations improved.',
    ),
    ImpactStory(
      title: 'Founder well-being circle',
      industry: 'SMEs · Quarterly circles',
      outcome: 'Founders reported calmer decision-making and stronger work-life balance.',
    ),
  ];

  static const List<InsightArticle> articles = [
    InsightArticle(
      title: 'Emotional Intelligence in an AI-Driven Workplace',
      summary:
          'As AI takes over routine tasks, human skills like empathy, self-regulation and judgement become the real differentiators.',
      type: 'Article',
      category: 'Emotional Intelligence',
      date: '10 Oct 2026',
      readMins: 7,
    ),
    InsightArticle(
      title: 'The 5-Minute Team Reset: A Guided Mindfulness Practice',
      summary:
          'A simple breathing and grounding sequence your team can do before meetings to lower tension and sharpen focus.',
      type: 'Guide',
      category: 'Mindfulness',
      date: '2 Oct 2026',
      readMins: 4,
    ),
    InsightArticle(
      title: 'How to Give Feedback Without Crushing Someone',
      summary:
          'The empathy-first framework for conversations that build people up instead of shutting them down.',
      type: 'Video',
      category: 'Leadership',
      date: '26 Sep 2026',
      readMins: 6,
    ),
    InsightArticle(
      title: 'Building a Culture of Psychological Safety',
      summary:
          'What psychological safety really is, why teams collapse without it, and how to start building it this quarter.',
      type: 'Article',
      category: 'Team Engagement',
      date: '18 Sep 2026',
      readMins: 9,
    ),
    InsightArticle(
      title: 'Preventing Burnout Before It Starts',
      summary:
          'Early warning signs and a practical well-being menu for busy organisations.',
      type: 'Guide',
      category: 'Well-being',
      date: '9 Sep 2026',
      readMins: 5,
    ),
    InsightArticle(
      title: 'Mindful Leadership: Making Time to Think',
      summary:
          'Why the scarcest leadership resource is thinking time — and how to protect it.',
      type: 'Video',
      category: 'Leadership',
      date: '1 Sep 2026',
      readMins: 8,
    ),
  ];

  static const List<ServiceItem> services = [
    ServiceItem(
      title: 'Well-being Assessment',
      description:
          'A confidential team diagnostic that measures stress, engagement and well-being to design the right intervention.',
      forWho: 'HR leaders and teams who want data before action.',
      gradient: [Color(0xFF3FC1A9), Color(0xFF1F1A8C)],
      icon: Icons.health_and_safety_outlined,
    ),
    ServiceItem(
      title: 'EQ & Mindfulness',
      description:
          'Workshops and coaching that build emotional intelligence and calm, focused workplaces.',
      forWho: 'Individuals and teams wanting greater self-awareness and resilience.',
      gradient: [Color(0xFF1F1A8C), Color(0xFF8E7FE0)],
      icon: Icons.self_improvement_outlined,
    ),
    ServiceItem(
      title: 'Leadership & Communication',
      description:
          'Authentic leadership development and communication skills that turn managers into coaches.',
      forWho: 'Team leads, managers and emerging leaders.',
      gradient: [Color(0xFF8E7FE0), Color(0xFF4A3FBF)],
      icon: Icons.groups_outlined,
    ),
    ServiceItem(
      title: 'Team Building',
      description:
          'Purpose-driven team days that move from activities to lasting behavioural change.',
      forWho: 'Teams ready to build trust and collaboration.',
      gradient: [Color(0xFF6A5AE0), Color(0xFF3FC1A9)],
      icon: Icons.handshake_outlined,
    ),
    ServiceItem(
      title: 'CSR & ESG',
      description:
          'Human-centred CSR and ESG programmes that engage people and community meaningfully.',
      forWho: 'Organisations embedding social value into strategy.',
      gradient: [Color(0xFF3FC1A9), Color(0xFF2E9E6B)],
      icon: Icons.volunteer_activism_outlined,
    ),
    ServiceItem(
      title: 'Customized Programmes',
      description:
          'Bespoke learning journeys designed around your culture, context and goals.',
      forWho: 'Organisations with specific people-development challenges.',
      gradient: [Color(0xFFFF9F43), Color(0xFF1F1A8C)],
      icon: Icons.category_outlined,
    ),
  ];
}
