import React, { useState, useEffect } from 'react';
import { Menu, X, ShieldAlert } from 'lucide-react';

const Navbar: React.FC = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY > 50) {
        setScrolled(true);
      } else {
        setScrolled(false);
      }
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const toggleMenu = () => setIsOpen(!isOpen);
  const closeMenu = () => setIsOpen(false);

  return (
    <nav 
      className={`fixed top-0 left-0 w-full z-50 transition-all duration-300 ${
        scrolled 
          ? 'bg-gray-900/95 backdrop-blur-md shadow-lg' 
          : 'bg-transparent'
      }`}
    >
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          <div className="flex items-center">
            <a href="#home" className="flex items-center space-x-2">
              <ShieldAlert className="h-8 w-8 text-green-500" />
              <span className="text-xl font-mono font-bold tracking-wider text-glow-green">
                Techie-Club
              </span>
            </a>
          </div>
          
          {/* Desktop Navigation */}
          <div className="hidden md:block">
            <div className="flex items-center space-x-8">
              <NavLink href="#home" onClick={closeMenu}>Home</NavLink>
              <NavLink href="#about" onClick={closeMenu}>About</NavLink>
              <NavLink href="#courses" onClick={closeMenu}>Courses</NavLink>
              <NavLink href="#internship" onClick={closeMenu}>Internship</NavLink>
              <NavLink href="#membership" onClick={closeMenu}>Membership</NavLink>
              <NavLink href="#portfolio" onClick={closeMenu}>Portfolio</NavLink>
              <NavLink href="#contact" onClick={closeMenu}>Contact</NavLink>
              <a 
                href="https://forms.google.com" 
                target="_blank" 
                rel="noopener noreferrer" 
                className="btn-neon-green"
              >
                Join Now
              </a>
            </div>
          </div>
          
          {/* Mobile Menu Button */}
          <div className="md:hidden">
            <button 
              onClick={toggleMenu} 
              className="text-gray-300 hover:text-white focus:outline-none"
            >
              {isOpen ? (
                <X className="h-6 w-6" />
              ) : (
                <Menu className="h-6 w-6" />
              )}
            </button>
          </div>
        </div>
      </div>
      
      {/* Mobile Navigation */}
      {isOpen && (
        <div className="md:hidden bg-gray-900/95 backdrop-blur-md border-t border-gray-800">
          <div className="px-2 pt-2 pb-3 space-y-1 sm:px-3">
            <NavLink href="#home" mobile onClick={closeMenu}>Home</NavLink>
            <NavLink href="#about" mobile onClick={closeMenu}>About</NavLink>
            <NavLink href="#courses" mobile onClick={closeMenu}>Courses</NavLink>
            <NavLink href="#internship" mobile onClick={closeMenu}>Internship</NavLink>
            <NavLink href="#membership" mobile onClick={closeMenu}>Membership</NavLink>
            <NavLink href="#portfolio" mobile onClick={closeMenu}>Portfolio</NavLink>
            <NavLink href="#contact" mobile onClick={closeMenu}>Contact</NavLink>
            <div className="pt-4">
              <a 
                href="https://forms.google.com" 
                target="_blank" 
                rel="noopener noreferrer" 
                className="block w-full text-center btn-neon-green"
                onClick={closeMenu}
              >
                Join Now
              </a>
            </div>
          </div>
        </div>
      )}
    </nav>
  );
};

interface NavLinkProps {
  href: string;
  children: React.ReactNode;
  mobile?: boolean;
  onClick?: () => void;
}

const NavLink: React.FC<NavLinkProps> = ({ href, children, mobile, onClick }) => {
  return (
    <a
      href={href}
      onClick={onClick}
      className={`
        ${mobile 
          ? 'block py-2 px-3 rounded-md hover:bg-gray-800 transition-colors duration-200' 
          : 'inline-block'
        }
        text-gray-300 hover:text-green-400 font-medium tracking-wide transition-colors duration-200
      `}
    >
      {children}
    </a>
  );
};

export default Navbar;