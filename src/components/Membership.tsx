import React from 'react';
import { Gift, Star, Lock, Users } from 'lucide-react';

const Membership: React.FC = () => {
  const membershipPlans = [
    {
      title: "Monthly Membership",
      startingPrice: "₹500",
      duration: "per month",
      badge: "Basic Plan",
      features: [
        "50% off on all courses (excluding internships)",
        "Weekly giveaways (discount vouchers)",
        "Access to private hacker community",
        "Special event invitations"
      ],
      color: "green"
    },
    {
      title: "3-Month Membership",
      startingPrice: "₹1000",
      duration: "for 3 months",
      badge: "Best Value",
      features: [
        "50% off on all courses (excluding internships)",
        "Weekly giveaways (Guvi course vouchers ₹500-₹1500)",
        "Access to private hacker community",
        "Priority support from mentors",
        "Exclusive workshops access"
      ],
      color: "purple",
      specialNote: "For first 50 students only!"
    }
  ];
  
  const benefits = [
    {
      icon: <Gift className="h-10 w-10 text-green-500" />,
      title: "Weekly Giveaways",
      description: "Win discount vouchers and premium course access"
    },
    {
      icon: <Star className="h-10 w-10 text-purple-500" />,
      title: "Course Discounts",
      description: "50% off on all courses in our catalog"
    },
    {
      icon: <Lock className="h-10 w-10 text-blue-500" />,
      title: "Exclusive Content",
      description: "Access special resources and tutorials"
    },
    {
      icon: <Users className="h-10 w-10 text-green-500" />,
      title: "Community Access",
      description: "Join our private hacker community"
    }
  ];

  return (
    <div className="container mx-auto px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto text-center mb-16">
        <h2 className="text-3xl md:text-4xl font-bold mb-4 text-glow-purple">
          Membership Club
        </h2>
        <div className="w-24 h-1 bg-purple-500 mx-auto mb-8"></div>
        <p className="text-gray-300 mb-8">
          Join our exclusive membership program and unlock premium benefits
        </p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-16">
        {membershipPlans.map((plan, index) => {
          const isGreen = plan.color === 'green';
          const cardClass = isGreen ? 'glass-card-green' : 'glass-card-purple';
          const buttonClass = isGreen ? 'btn-neon-green' : 'btn-neon-purple';
          const priceBg = isGreen ? 'bg-green-500/10' : 'bg-purple-500/10';
          const badgeColor = isGreen ? 'bg-green-900 text-green-300' : 'bg-purple-900 text-purple-300';
          const checkColor = isGreen ? 'text-green-500' : 'text-purple-500';
          
          return (
            <div 
              key={index} 
              className={`${cardClass} relative p-6 transform transition-all duration-300 hover:scale-[1.02]`}
            >
              {plan.specialNote && (
                <div className="absolute -top-4 -right-4 bg-pink-500 text-white text-xs font-bold py-2 px-4 rounded-full animate-pulse">
                  Limited Offer!
                </div>
              )}
              
              <h3 className="text-2xl font-bold mb-2">{plan.title}</h3>
              
              <div className={`rounded-lg ${priceBg} p-4 mb-6`}>
                <div className="flex items-center justify-between">
                  <div>
                    <span className="text-gray-400 text-sm block">Starting from</span>
                    <span className="text-white text-2xl font-bold">
                      {plan.startingPrice}
                    </span>
                    <span className="text-gray-400 text-sm ml-1">
                      {plan.duration}
                    </span>
                  </div>
                  <div className={`py-1 px-3 rounded-full text-xs font-bold ${badgeColor}`}>
                    {plan.badge}
                  </div>
                </div>
                {plan.specialNote && (
                  <div className="mt-2 text-sm font-medium text-pink-400">
                    {plan.specialNote}
                  </div>
                )}
              </div>
              
              <div className="mb-6">
                <h4 className="text-gray-300 font-medium mb-3">Membership Perks:</h4>
                <ul className="space-y-2">
                  {plan.features.map((feature, idx) => (
                    <li key={idx} className="flex items-start">
                      <span className={`inline-block mr-2 ${checkColor}`}>✓</span>
                      <span className="text-gray-300 text-sm">{feature}</span>
                    </li>
                  ))}
                </ul>
              </div>
              
              <a 
                href="https://forms.gle/MbbUszbygFy9aHdz5" 
                target="_blank" 
                rel="noopener noreferrer" 
                className={`block w-full text-center ${buttonClass}`}
              >
                Join Now
              </a>
            </div>
          );
        })}
      </div>
      
      <div className="glass-card p-8 rounded-lg mb-16">
        <h3 className="text-2xl font-bold mb-8 text-center">Membership Benefits</h3>
        
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          {benefits.map((benefit, index) => (
            <div key={index} className="text-center p-4 transform transition-all duration-300 hover:scale-105">
              <div className="mb-4 inline-block p-4 bg-gray-800/50 rounded-full border border-gray-700 float">
                {benefit.icon}
              </div>
              <h4 className="text-lg font-semibold text-white mb-2">{benefit.title}</h4>
              <p className="text-gray-400 text-sm">{benefit.description}</p>
            </div>
          ))}
        </div>
      </div>
      
      <div className="bg-gradient-to-r from-purple-900/30 via-blue-900/30 to-green-900/30 p-8 rounded-lg text-center border border-gray-800">
        <h3 className="text-xl font-semibold mb-4">Join Our Hacker Community Today!</h3>
        <p className="text-gray-300 mb-6 max-w-2xl mx-auto">
          Be part of an exclusive network of cybersecurity enthusiasts, share knowledge, and accelerate your learning journey.
        </p>
        <a 
          href="https://forms.gle/MbbUszbygFy9aHdz5" 
          target="_blank" 
          rel="noopener noreferrer" 
          className="btn-neon-purple"
        >
          Become a Member
        </a>
      </div>
    </div>
  );
};

export default Membership;