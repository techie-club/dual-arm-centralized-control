import React, { useRef, useEffect } from 'react';
import { Clock, Award, Users, FileCheck } from 'lucide-react';

const Internship: React.FC = () => {
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
  
  const internshipOptions = [
    {
      title: "15-Day Internship",
      startingPrice: "₹500",
      duration: "15 days",
      badge: "Limited Time Offer",
      description: "Intensive short-term practical training for quick skill acquisition",
      isPopular: false,
      color: "purple"
    },
    {
      title: "3-Month Internship",
      startingPrice: "₹2500",
      duration: "3 months",
      badge: "Most Popular",
      description: "Comprehensive training with in-depth project work and mentorship",
      isPopular: true,
      color: "blue"
    }
  ];
  
  const benefits = [
    {
      icon: <FileCheck className="h-10 w-10 text-green-500" />,
      title: "Hands-on Practicals",
      description: "Learn by doing with real-world challenges and scenarios"
    },
    {
      icon: <Award className="h-10 w-10 text-green-500" />,
      title: "Certificates",
      description: "Industry-recognized certifications upon completion"
    },
    {
      icon: <Users className="h-10 w-10 text-green-500" />,
      title: "Live Sessions",
      description: "Interactive sessions with industry professionals"
    },
    {
      icon: <Clock className="h-10 w-10 text-green-500" />,
      title: "Lifetime Support",
      description: "Access to doubt support group forever"
    }
  ];

  return (
    <div ref={sectionRef} className="container mx-auto px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto text-center mb-16">
        <h2 className="text-3xl md:text-4xl font-bold mb-4 text-glow-blue animate-on-scroll opacity-0 translate-y-8 transition-all duration-700">
          Internship Program
        </h2>
        <div className="w-24 h-1 bg-blue-500 mx-auto mb-8 animate-on-scroll opacity-0 translate-y-8 transition-all duration-700 delay-300"></div>
        <p className="text-gray-300 mb-8 animate-on-scroll opacity-0 translate-y-8 transition-all duration-700 delay-500">
          Gain real-world experience and practical skills with our cybersecurity internship programs
        </p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-16">
        {internshipOptions.map((option, index) => {
          const isBlue = option.color === 'blue';
          const cardClass = isBlue ? 'glass-card-blue' : 'glass-card-purple';
          const buttonClass = isBlue ? 'btn-neon-blue' : 'btn-neon-purple';
          const priceBg = isBlue ? 'bg-blue-500/10' : 'bg-purple-500/10';
          const badgeColor = isBlue ? 'bg-blue-900 text-blue-300' : 'bg-purple-900 text-purple-300';
          
          return (
            <div 
              key={index} 
              className={`${cardClass} relative p-6 animate-on-scroll opacity-0 translate-y-8 transition-all duration-700`}
              style={{ transitionDelay: `${700 + index * 200}ms` }}
            >
              {option.isPopular && (
                <div className="absolute -top-4 -right-4 bg-green-500 text-white text-xs font-bold py-2 px-4 rounded-full">
                  MOST POPULAR
                </div>
              )}
              
              <h3 className="text-2xl font-bold mb-2">{option.title}</h3>
              <p className="text-gray-400 mb-6">{option.description}</p>
              
              <div className={`rounded-lg ${priceBg} p-4 mb-6`}>
                <div className="flex items-center justify-between">
                  <div>
                    <span className="text-gray-400 text-sm block">Starting from</span>
                    <span className="text-white text-2xl font-bold">
                      {option.startingPrice}
                    </span>
                  </div>
                  <div className={`py-1 px-3 rounded-full text-xs font-bold ${badgeColor}`}>
                    {option.badge}
                  </div>
                </div>
                <div className="mt-3 text-sm text-gray-400">
                  <span className="block">Duration: {option.duration}</span>
                </div>
              </div>
              
              <a 
                href="https://forms.gle/MbbUszbygFy9aHdz5" 
                target="_blank" 
                rel="noopener noreferrer" 
                className={`block w-full text-center ${buttonClass}`}
              >
                Apply Now
              </a>
            </div>
          );
        })}
      </div>
      
      <div className="glass-card-green p-8 mb-12 animate-on-scroll opacity-0 translate-y-8 transition-all duration-700" style={{ transitionDelay: '1100ms' }}>
        <h3 className="text-2xl font-bold mb-8 text-center">What's Included</h3>
        
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          {benefits.map((benefit, index) => (
            <div key={index} className="text-center p-4">
              <div className="mb-4 inline-block p-4 bg-gray-800/50 rounded-full border border-green-500/30">
                {benefit.icon}
              </div>
              <h4 className="text-lg font-semibold text-green-300 mb-2">{benefit.title}</h4>
              <p className="text-gray-400 text-sm">{benefit.description}</p>
            </div>
          ))}
        </div>
      </div>
      
      <div className="glass-card p-8 text-center animate-on-scroll opacity-0 translate-y-8 transition-all duration-700" style={{ transitionDelay: '1300ms' }}>
        <h3 className="text-xl font-semibold mb-4">Ready to start your cybersecurity journey?</h3>
        <p className="text-gray-400 mb-6">
          Our internship slots fill up quickly. Secure your spot today!
        </p>
        <a 
          href="https://forms.gle/MbbUszbygFy9aHdz5" 
          target="_blank" 
          rel="noopener noreferrer" 
          className="btn-neon-green"
        >
          Register Now
        </a>
      </div>
    </div>
  );
};

export default Internship;