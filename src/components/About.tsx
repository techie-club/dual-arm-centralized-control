import React, { useEffect, useRef } from 'react';
import { Shield, Users, Award } from 'lucide-react';

const About: React.FC = () => {
  const sectionRef = useRef<HTMLDivElement>(null);
  
  useEffect(() => {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.classList.add('opacity-100', 'translate-y-0');
          }
        });
      },
      { threshold: 0.1 }
    );
    
    const elements = sectionRef.current?.querySelectorAll('.animate-on-scroll');
    elements?.forEach(el => {
      observer.observe(el);
    });
    
    return () => {
      elements?.forEach(el => {
        observer.unobserve(el);
      });
    };
  }, []);

  return (
    <div ref={sectionRef} className="container mx-auto px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto text-center mb-16">
        <h2 className="text-3xl md:text-4xl font-bold mb-4 text-glow-purple animate-on-scroll opacity-0 translate-y-8 transition-all duration-700">
          About Us
        </h2>
        <div className="w-24 h-1 bg-purple-500 mx-auto mb-8 animate-on-scroll opacity-0 translate-y-8 transition-all duration-700 delay-300"></div>
      </div>
      
      <div className="glass-card-purple p-8 rounded-lg animate-on-scroll opacity-0 translate-y-8 transition-all duration-700 delay-500">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-12">
          <div className="space-y-6">
            <div className="flex items-center mb-4">
              <Shield className="h-8 w-8 text-purple-500 mr-3" />
              <h3 className="text-2xl font-bold text-purple-400">Techie-Club</h3>
            </div>
            
            <p className="text-gray-300 leading-relaxed">
              Techie-Club is a government-registered cybersecurity startup providing online education 
              and practical internships. We focus on real-world, hands-on training in ethical hacking, 
              cybersecurity awareness, and career building.
            </p>
            
            <div className="pt-4 pb-2">
              <h4 className="text-xl font-semibold text-purple-300 mb-2">Our Mission</h4>
              <p className="text-gray-300 italic border-l-4 border-purple-500 pl-4">
                "To empower students with the knowledge and tools to protect the digital world."
              </p>
            </div>
            
            <div className="flex items-center space-x-8 mt-8">
              <div className="flex flex-col items-center">
                <Users className="h-8 w-8 text-purple-400 mb-2" />
                <span className="text-sm text-gray-400">Community Support</span>
              </div>
              <div className="flex flex-col items-center">
                <Award className="h-8 w-8 text-purple-400 mb-2" />
                <span className="text-sm text-gray-400">Certified Training</span>
              </div>
            </div>
          </div>
          
          <div className="space-y-6">
            <div className="bg-gray-900/60 rounded-lg p-6 border border-purple-500/30 shadow-lg">
              <h4 className="text-xl font-semibold text-purple-300 mb-4">Founder</h4>
              <div className="flex items-center">
                <div className="w-16 h-16 rounded-full bg-purple-800 flex items-center justify-center text-2xl font-bold text-white mr-4">
                  AT
                </div>
                <div>
                  <h5 className="text-lg font-medium text-white">Anbarasu T</h5>
                  <p className="text-gray-300">Cybersecurity Enthusiast and Trainer</p>
                </div>
              </div>
            </div>
            
            <div className="bg-gray-900/60 rounded-lg p-6 border border-purple-500/30 shadow-lg">
              <h4 className="text-xl font-semibold text-purple-300 mb-4">What Sets Us Apart</h4>
              <ul className="space-y-2 text-gray-300">
                <li className="flex items-start">
                  <span className="text-purple-500 mr-2">▹</span>
                  <span>Practical, hands-on training</span>
                </li>
                <li className="flex items-start">
                  <span className="text-purple-500 mr-2">▹</span>
                  <span>Real-world project experience</span>
                </li>
                <li className="flex items-start">
                  <span className="text-purple-500 mr-2">▹</span>
                  <span>Affordable, accessible education</span>
                </li>
                <li className="flex items-start">
                  <span className="text-purple-500 mr-2">▹</span>
                  <span>Community-driven learning environment</span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default About;