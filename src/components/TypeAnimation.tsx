import React, { useState, useEffect } from 'react';

interface TypeAnimationProps {
  text: string;
  delay?: number;
  speed?: number;
  className?: string;
}

export const TypeAnimation: React.FC<TypeAnimationProps> = ({ 
  text, 
  delay = 0,
  speed = 50,
  className = ''
}) => {
  const [displayedText, setDisplayedText] = useState('');
  const [isTyping, setIsTyping] = useState(false);
  const [showCursor, setShowCursor] = useState(true);

  useEffect(() => {
    let timer: ReturnType<typeof setTimeout>;
    
    // Initial delay
    timer = setTimeout(() => {
      setIsTyping(true);
      let index = 0;
      
      const typeChar = () => {
        if (index < text.length) {
          setDisplayedText(text.substring(0, index + 1));
          index++;
          timer = setTimeout(typeChar, speed + Math.random() * 30);
        } else {
          setIsTyping(false);
          // Keep cursor blinking after typing is done
          setShowCursor(true);
        }
      };
      
      typeChar();
    }, delay);
    
    return () => clearTimeout(timer);
  }, [text, delay, speed]);

  // Cursor blinking effect
  useEffect(() => {
    if (!isTyping) {
      const blinkInterval = setInterval(() => {
        setShowCursor(prev => !prev);
      }, 500);
      
      return () => clearInterval(blinkInterval);
    }
  }, [isTyping]);

  return (
    <span className={className}>
      {displayedText}
      {showCursor && <span className="text-green-500">|</span>}
    </span>
  );
};