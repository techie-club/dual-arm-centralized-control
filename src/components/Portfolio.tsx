import React, { useState } from 'react';
import { Code, FileCode, Server } from 'lucide-react';

const Portfolio: React.FC = () => {
  const [activeTab, setActiveTab] = useState('projects');

  const projects = [
    {
      title: "Network Scanner Tool",
      type: "Student Project",
      description: "A Python-based network scanning tool for identifying open ports and services.",
      tags: ["Python", "Networking", "Security"],
      iconColor: "text-blue-500"
    },
    {
      title: "Password Strength Analyzer",
      type: "Security Tool",
      description: "Web application to analyze password strength and suggest improvements.",
      tags: ["JavaScript", "Cryptography", "Web Security"],
      iconColor: "text-green-500"
    },
    {
      title: "Vulnerability Scanner",
      type: "Mini Tool",
      description: "Automated vulnerability scanner for web applications.",
      tags: ["Python", "Web Security", "Automation"],
      iconColor: "text-purple-500"
    },
    {
      title: "Phishing Awareness Trainer",
      type: "Educational Tool",
      description: "Interactive tool to train users on identifying phishing attempts.",
      tags: ["HTML/CSS", "JavaScript", "Education"],
      iconColor: "text-green-500"
    }
  ];

  const testimonials = [
    {
      name: "Priya S.",
      role: "Computer Science Student",
      content: "The Zero to Hero course completely transformed my understanding of cybersecurity. The hands-on approach made complex concepts accessible and practical.",
      avatar: "PS"
    },
    {
      name: "Rahul M.",
      role: "IT Professional",
      content: "Techie-Club's internship program provided me with real-world experience that was immediately applicable in my job. The mentorship was exceptional.",
      avatar: "RM"
    },
    {
      name: "Kavitha R.",
      role: "Security Enthusiast",
      content: "The membership benefits are incredible! The weekly giveaways and community support have accelerated my learning journey tremendously.",
      avatar: "KR"
    }
  ];

  const achievements = [
    {
      title: "50+ Successful Workshops",
      description: "Conducted across various colleges and tech events",
      icon: <Server className="h-8 w-8" />
    },
    {
      title: "200+ Students Trained",
      description: "Successfully completed our courses and internships",
      icon: <FileCode className="h-8 w-8" />
    },
    {
      title: "15+ Industry Partnerships",
      description: "Collaborations with leading tech companies",
      icon: <Code className="h-8 w-8" />
    }
  ];

  return (
    <div className="container mx-auto px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto text-center mb-16">
        <h2 className="text-3xl md:text-4xl font-bold mb-4 text-glow-green">
          Our Portfolio
        </h2>
        <div className="w-24 h-1 bg-green-500 mx-auto mb-8"></div>
        <p className="text-gray-300 mb-8">
          Explore our student projects, success stories, and achievements
        </p>
      </div>
      
      <div className="mb-8">
        <div className="flex justify-center space-x-4 mb-8">
          <TabButton 
            active={activeTab === 'projects'} 
            onClick={() => setActiveTab('projects')}
          >
            Student Projects
          </TabButton>
          <TabButton 
            active={activeTab === 'testimonials'} 
            onClick={() => setActiveTab('testimonials')}
          >
            Testimonials
          </TabButton>
          <TabButton 
            active={activeTab === 'achievements'} 
            onClick={() => setActiveTab('achievements')}
          >
            Achievements
          </TabButton>
        </div>
        
        <div className="min-h-[400px]">
          {activeTab === 'projects' && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {projects.map((project, index) => (
                <div key={index} className="glass-card p-6 transition-all duration-300 hover:scale-[1.02]">
                  <div className="flex items-start">
                    <div className={`p-3 rounded-lg bg-gray-800/50 mr-4 ${project.iconColor}`}>
                      <FileCode className="h-6 w-6" />
                    </div>
                    <div>
                      <div className="text-xs font-medium text-gray-400 mb-1">{project.type}</div>
                      <h3 className="text-lg font-semibold mb-2">{project.title}</h3>
                      <p className="text-gray-300 text-sm mb-4">{project.description}</p>
                      <div className="flex flex-wrap gap-2">
                        {project.tags.map((tag, tagIndex) => (
                          <span 
                            key={tagIndex}
                            className="bg-gray-800 text-gray-300 text-xs px-2 py-1 rounded"
                          >
                            {tag}
                          </span>
                        ))}
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
          
          {activeTab === 'testimonials' && (
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {testimonials.map((testimonial, index) => (
                <div key={index} className="glass-card p-6 flex flex-col h-full">
                  <div className="flex-grow">
                    <p className="text-gray-300 mb-4 italic">"{testimonial.content}"</p>
                  </div>
                  <div className="flex items-center mt-4">
                    <div className="w-10 h-10 rounded-full bg-purple-900 flex items-center justify-center text-white font-semibold mr-3">
                      {testimonial.avatar}
                    </div>
                    <div>
                      <h4 className="font-medium">{testimonial.name}</h4>
                      <p className="text-gray-400 text-sm">{testimonial.role}</p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
          
          {activeTab === 'achievements' && (
            <div className="glass-card p-8">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                {achievements.map((achievement, index) => (
                  <div key={index} className="text-center">
                    <div className="mb-4 inline-block p-4 bg-green-900/30 rounded-full border border-green-500/30 text-green-400">
                      {achievement.icon}
                    </div>
                    <h3 className="text-xl font-bold mb-2">{achievement.title}</h3>
                    <p className="text-gray-400">{achievement.description}</p>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>
      
      <div className="text-center mt-12">
        <a 
          href="https://docs.google.com/forms/d/e/1FAIpQLSctyMPTACMW109G3AU1FcOcg4vRYW1cEi-gCRHbg8zhO1zSSQ/viewform?usp=dialog" 
          target="_blank" 
          rel="noopener noreferrer" 
          className="btn-neon-green inline-block"
        >
          Start Your Project
        </a>
      </div>
    </div>
  );
};

interface TabButtonProps {
  active: boolean;
  onClick: () => void;
  children: React.ReactNode;
}

const TabButton: React.FC<TabButtonProps> = ({ active, onClick, children }) => {
  return (
    <button
      onClick={onClick}
      className={`px-4 py-2 rounded-md transition-all duration-300 ${
        active 
          ? 'bg-green-500/20 text-green-400 border border-green-500/50' 
          : 'bg-gray-800/30 text-gray-400 hover:bg-gray-800/50 hover:text-gray-300'
      }`}
    >
      {children}
    </button>
  );
};

export default Portfolio;