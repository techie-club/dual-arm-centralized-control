import React from 'react';
import CourseCard from './CourseCard';
import { Cpu, Globe, Code, Database, Wifi, Lock, FileCode, Server } from 'lucide-react';

const Courses: React.FC = () => {
  const courses = [
    {
      id: 1,
      title: "Cyber Basics Starter Pack",
      icon: <Cpu className="h-12 w-12 text-green-500" />,
      description: "Perfect for absolute beginners to build a strong foundation in computer fundamentals, operating systems, and networking.",
      startingPrice: "₹200",
      duration: "Self-paced",
      features: [
        "Computer Fundamentals",
        "Operating Systems",
        "Networking Basics",
        "Cybersecurity Introduction"
      ],
      level: "Beginner",
      color: "green"
    },
    {
      id: 2,
      title: "Zero to Hero in Ethical Hacking",
      icon: <Lock className="h-12 w-12 text-blue-500" />,
      description: "Comprehensive ethical hacking course taking you from beginner to advanced levels with hands-on practical exercises.",
      startingPrice: "₹1000",
      duration: "12 weeks",
      features: [
        "Footprinting & Reconnaissance",
        "Scanning & Vulnerability Assessment",
        "Exploitation Techniques",
        "Web Application Hacking",
        "WiFi Attacks & Security",
        "Certificate & Career Guidance"
      ],
      level: "Beginner to Advanced",
      color: "blue"
    }
  ];

  const topics = [
    { icon: <Globe size={28} />, name: "Footprinting" },
    { icon: <Code size={28} />, name: "Scanning" },
    { icon: <Database size={28} />, name: "Vulnerabilities" },
    { icon: <FileCode size={28} />, name: "Web Hacking" },
    { icon: <Wifi size={28} />, name: "WiFi Attacks" },
    { icon: <Server size={28} />, name: "Network Security" }
  ];

  return (
    <div className="container mx-auto px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto text-center mb-16">
        <h2 className="text-3xl md:text-4xl font-bold mb-4 text-glow-green">
          Our Courses
        </h2>
        <div className="w-24 h-1 bg-green-500 mx-auto mb-8"></div>
        <p className="text-gray-300 mb-8">
          Master the art of cybersecurity with our specialized courses designed for all skill levels
        </p>
        
        <div className="flex flex-wrap justify-center gap-4 mb-12">
          {topics.map((topic, index) => (
            <div 
              key={index}
              className="flex items-center gap-2 bg-gray-800/40 backdrop-blur-sm px-4 py-2 rounded-full
                        border border-gray-700 hover:border-green-500/50 transition-all duration-300
                        hover:bg-gray-800/60 text-gray-300 hover:text-green-300"
            >
              <span className="text-green-500">{topic.icon}</span>
              <span>{topic.name}</span>
            </div>
          ))}
        </div>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
        {courses.map(course => (
          <CourseCard key={course.id} course={course} />
        ))}
      </div>
      
      <div className="text-center mt-12">
        <a 
          href="https://forms.gle/MbbUszbygFy9aHdz5" 
          target="_blank" 
          rel="noopener noreferrer" 
          className="btn-neon-green inline-block"
        >
          View All Courses
        </a>
      </div>
    </div>
  );
};

export default Courses;