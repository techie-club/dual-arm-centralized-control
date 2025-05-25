import React, { useState } from 'react';
import { Check } from 'lucide-react';

interface CourseProps {
  course: {
    id: number;
    title: string;
    icon: React.ReactNode;
    description: string;
    priceOriginal: string;
    priceCurrent: string;
    duration: string;
    features: string[];
    level: string;
    color: string;
  };
}

const CourseCard: React.FC<CourseProps> = ({ course }) => {
  const [isHovered, setIsHovered] = useState(false);
  
  const getColorClasses = (color: string) => {
    switch (color) {
      case 'green':
        return {
          card: 'glass-card-green',
          badge: 'bg-green-900/60 text-green-400 border-green-500/30',
          icon: 'text-green-500',
          button: 'btn-neon-green',
          priceBg: 'bg-green-500/10',
          check: 'text-green-500'
        };
      case 'blue':
        return {
          card: 'glass-card-blue',
          badge: 'bg-blue-900/60 text-blue-400 border-blue-500/30',
          icon: 'text-blue-500',
          button: 'btn-neon-blue',
          priceBg: 'bg-blue-500/10',
          check: 'text-blue-500'
        };
      case 'purple':
      default:
        return {
          card: 'glass-card-purple',
          badge: 'bg-purple-900/60 text-purple-400 border-purple-500/30',
          icon: 'text-purple-500',
          button: 'btn-neon-purple',
          priceBg: 'bg-purple-500/10',
          check: 'text-purple-500'
        };
    }
  };
  
  const colors = getColorClasses(course.color);

  return (
    <div 
      className={`${colors.card} overflow-hidden transition-all duration-500 ${
        isHovered ? 'transform scale-[1.02]' : ''
      }`}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      <div className="p-6">
        <div className="flex items-start justify-between mb-4">
          <div className="float p-3 rounded-lg bg-gray-800/50 border border-gray-700">
            {course.icon}
          </div>
          <span className={`py-1 px-3 rounded-full text-xs font-semibold border ${colors.badge}`}>
            {course.level}
          </span>
        </div>
        
        <h3 className="text-xl font-bold mb-3 mt-6">{course.title}</h3>
        <p className="text-gray-400 mb-6 text-sm">{course.description}</p>
        
        <div className={`rounded-lg ${colors.priceBg} p-4 mb-6 flex items-center justify-between`}>
          <div>
            <span className="text-gray-400 text-sm line-through block">
              {course.priceOriginal}
            </span>
            <span className="text-white text-2xl font-bold">
              {course.priceCurrent}
            </span>
          </div>
          <div className="text-right">
            <span className="text-gray-400 text-sm block">Duration</span>
            <span className="text-white">{course.duration}</span>
          </div>
        </div>
        
        <div className="mb-6">
          <h4 className="text-gray-300 font-medium mb-3">What You'll Learn:</h4>
          <ul className="space-y-2">
            {course.features.map((feature, index) => (
              <li key={index} className="flex items-start">
                <Check className={`h-5 w-5 mr-2 ${colors.check}`} />
                <span className="text-gray-300 text-sm">{feature}</span>
              </li>
            ))}
          </ul>
        </div>
        
        <a 
          href="https://docs.google.com/forms/d/e/1FAIpQLSctyMPTACMW109G3AU1FcOcg4vRYW1cEi-gCRHbg8zhO1zSSQ/viewform?usp=dialog" 
          target="_blank" 
          rel="noopener noreferrer" 
          className={`block w-full text-center ${colors.button}`}
        >
          Enroll Now
        </a>
      </div>
    </div>
  );
};

export default CourseCard;