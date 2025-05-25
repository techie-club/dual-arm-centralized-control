import React from 'react';
import { ShieldAlert, Instagram, Facebook, Mail, ArrowUp } from 'lucide-react';

const Footer: React.FC = () => {
  const scrollToTop = () => {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  };

  return (
    <footer className="relative pt-20 pb-6 overflow-hidden">
      {/* Animated background elements */}
      <div className="absolute inset-0 z-0">
        <div className="absolute bottom-0 left-0 right-0 h-40 bg-gradient-to-t from-black to-transparent"></div>
        
        {/* Matrix-like scrolling text - This is purely decorative */}
        <div className="select-none pointer-events-none absolute inset-0 overflow-hidden opacity-10">
          {Array.from({ length: 10 }).map((_, i) => (
            <div 
              key={i}
              className="absolute text-green-500 font-mono text-xs whitespace-nowrap"
              style={{
                left: `${Math.random() * 100}%`,
                top: 0,
                animationDuration: `${15 + Math.random() * 45}s`,
                animationDelay: `${Math.random() * 5}s`,
                animation: 'matrix-fall linear infinite',
              }}
            >
              {Array.from({ length: 30 }).map((_, j) => (
                <div key={j} style={{ opacity: Math.random() * 0.9 + 0.1 }}>
                  {String.fromCharCode(33 + Math.floor(Math.random() * 94))}
                </div>
              ))}
            </div>
          ))}
        </div>
      </div>
      
      <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-12 mb-12">
          <div>
            <div className="flex items-center mb-6">
              <ShieldAlert className="h-8 w-8 text-green-500 mr-2" />
              <span className="text-2xl font-mono font-bold tracking-wider text-glow-green">
                Techie-Club
              </span>
            </div>
            <p className="text-gray-400 mb-6">
              Your gateway to ethical hacking and cybersecurity mastery. 
              Join our community and empower yourself with the knowledge 
              and tools to protect the digital world.
            </p>
            <div className="flex space-x-4">
              <SocialLink href="https://instagram.com/techie._.club" icon={<Instagram />} label="Instagram" />
              <SocialLink href="https://facebook.com/techie._.club" icon={<Facebook />} label="Facebook" />
              <SocialLink href="mailto:techiecluboffl@gmail.com" icon={<Mail />} label="Email" />
            </div>
          </div>
          
          <div>
            <h3 className="text-lg font-semibold mb-6">Quick Links</h3>
            <ul className="space-y-3">
              <FooterLink href="#home">Home</FooterLink>
              <FooterLink href="#about">About Us</FooterLink>
              <FooterLink href="#courses">Courses</FooterLink>
              <FooterLink href="#internship">Internship Program</FooterLink>
              <FooterLink href="#membership">Membership Club</FooterLink>
              <FooterLink href="#portfolio">Portfolio</FooterLink>
              <FooterLink href="#contact">Contact Us</FooterLink>
            </ul>
          </div>
          
          <div>
            <h3 className="text-lg font-semibold mb-6">Contact Information</h3>
            <ul className="space-y-3 text-gray-400">
              <li className="flex items-start">
                <span className="text-green-500 mr-2">📞</span>
                <span>+91 8428792819</span>
              </li>
              <li className="flex items-start">
                <span className="text-green-500 mr-2">📧</span>
                <span>techiecluboffl@gmail.com</span>
              </li>
              <li className="flex items-start">
                <span className="text-green-500 mr-2">📱</span>
                <a 
                  href="https://wa.me/918428792819" 
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="text-green-400 hover:underline"
                >
                  WhatsApp
                </a>
              </li>
            </ul>
          </div>
        </div>
        
        <div className="border-t border-gray-800 pt-6 flex flex-col md:flex-row justify-between items-center">
          <p className="text-gray-500 text-sm mb-4 md:mb-0">
            Copyright © {new Date().getFullYear()} Techie-Club. All rights reserved.
          </p>
          <button 
            onClick={scrollToTop}
            className="bg-gray-800 hover:bg-gray-700 text-gray-300 p-2 rounded-full transition-colors"
            aria-label="Scroll to top"
          >
            <ArrowUp size={16} />
          </button>
        </div>
      </div>
      
      <style jsx>{`
        @keyframes matrix-fall {
          from { transform: translateY(-100vh); }
          to { transform: translateY(100vh); }
        }
      `}</style>
    </footer>
  );
};

interface FooterLinkProps {
  href: string;
  children: React.ReactNode;
}

const FooterLink: React.FC<FooterLinkProps> = ({ href, children }) => {
  return (
    <li>
      <a 
        href={href} 
        className="text-gray-400 hover:text-green-400 transition-colors duration-200"
      >
        {children}
      </a>
    </li>
  );
};

interface SocialLinkProps {
  href: string;
  icon: React.ReactNode;
  label: string;
}

const SocialLink: React.FC<SocialLinkProps> = ({ href, icon, label }) => {
  return (
    <a 
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className="bg-gray-800 hover:bg-gray-700 p-2 rounded-full transition-colors"
      aria-label={label}
    >
      {icon}
    </a>
  );
};

export default Footer;