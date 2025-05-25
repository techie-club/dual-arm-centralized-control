import React, { useEffect, useRef } from 'react';
import { ChevronDown } from 'lucide-react';
import { TypeAnimation } from './TypeAnimation';

const Hero: React.FC = () => {
  const terminalRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (terminalRef.current) {
      const terminal = terminalRef.current;
      
      const lines = [
        'Welcome to Techie-Club',
        'Initiating system...',
        'Loading cybersecurity modules...',
        'Establishing secure connection...',
        'Connection established.',
        'Access granted: Welcome, Future Hacker.'
      ];
      
      let index = 0;
      let lineIndex = 0;
      let currentLine = '';
      let lineElement: HTMLDivElement | null = null;
      
      const typeNextLine = () => {
        if (lineIndex >= lines.length) return;
        
        lineElement = document.createElement('div');
        lineElement.className = 'mb-1 flex';
        
        const prompt = document.createElement('span');
        prompt.className = 'text-green-500 mr-2';
        prompt.textContent = '>';
        
        const content = document.createElement('span');
        content.className = 'text-gray-300';
        
        lineElement.appendChild(prompt);
        lineElement.appendChild(content);
        terminal.appendChild(lineElement);
        
        currentLine = '';
        index = 0;
        typeCharacter();
      };
      
      const typeCharacter = () => {
        if (index < lines[lineIndex].length) {
          currentLine += lines[lineIndex][index];
          if (lineElement) {
            const content = lineElement.querySelector('span:last-child');
            if (content) content.textContent = currentLine;
          }
          index++;
          setTimeout(typeCharacter, 30 + Math.random() * 40);
        } else {
          lineIndex++;
          setTimeout(typeNextLine, 500);
        }
      };
      
      typeNextLine();
    }
  }, []);

  return (
    <div className="relative h-screen flex items-center justify-center overflow-hidden">
      {/* Background with animated grid */}
      <div className="absolute inset-0 z-0">
        <div className="absolute inset-0 bg-[radial-gradient(circle,rgba(0,255,0,0.05)_1px,transparent_1px)] bg-[length:24px_24px]"></div>
      </div>
      
      <div className="container mx-auto px-4 sm:px-6 lg:px-8 z-10">
        <div className="flex flex-col md:flex-row items-center justify-between">
          <div className="w-full md:w-1/2 mb-12 md:mb-0">
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-mono font-bold mb-4 animate-fadeIn text-glow-green">
              <TypeAnimation text="Welcome to Techie-Club" delay={100} />
            </h1>
            <h2 className="text-xl md:text-2xl font-light mb-8 max-w-2xl text-gray-300">
              <TypeAnimation 
                text="Your Gateway to Ethical Hacking & Cybersecurity Mastery" 
                delay={2500}
                speed={70}
              />
            </h2>
            <div className="flex flex-col sm:flex-row gap-4 mt-8">
              <a 
                href="https://docs.google.com/forms/d/e/1FAIpQLSctyMPTACMW109G3AU1FcOcg4vRYW1cEi-gCRHbg8zhO1zSSQ/viewform?usp=dialog" 
                target="_blank" 
                rel="noopener noreferrer" 
                className="btn-neon-green text-center"
              >
                Join Now
              </a>
              <a 
                href="#about" 
                className="btn-neon-purple text-center"
              >
                Learn More
              </a>
            </div>
          </div>
          
          <div className="w-full md:w-1/2 md:pl-12">
            <div className="glass-card-green p-4 rounded-lg overflow-hidden max-w-lg mx-auto">
              <div className="bg-gray-950 rounded-md p-2 font-mono text-sm">
                <div className="flex items-center border-b border-gray-800 pb-2 mb-3">
                  <div className="flex space-x-2">
                    <div className="w-3 h-3 rounded-full bg-red-500"></div>
                    <div className="w-3 h-3 rounded-full bg-yellow-500"></div>
                    <div className="w-3 h-3 rounded-full bg-green-500"></div>
                  </div>
                  <div className="mx-auto text-gray-400 text-xs">techie-club ~ terminal</div>
                </div>
                <div ref={terminalRef} className="h-48 overflow-y-auto"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <div className="absolute bottom-8 left-0 right-0 flex justify-center animate-bounce">
        <a href="#about" className="text-green-400 hover:text-green-300">
          <ChevronDown size={32} />
        </a>
      </div>
    </div>
  );
};

export default Hero;