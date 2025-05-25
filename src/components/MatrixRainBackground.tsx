import React, { useEffect, useRef } from 'react';

const MatrixRainBackground: React.FC = () => {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    // Set canvas dimensions
    const resizeCanvas = () => {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    };

    // Initialize
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);

    // Matrix characters - using a mix of characters for the cybersecurity theme
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%^&*(){}[]<>~`|\\;:\'"+=-_';
    
    // Converting the string into an array of single characters
    const charArray = chars.split('');
    
    const fontSize = 14;
    const columns = canvas.width / fontSize; // number of columns
    
    // Creating an array of drops - one per column
    const drops: number[] = [];
    
    // Initialize all drops to start at a random y position
    for (let i = 0; i < columns; i++) {
      drops[i] = Math.random() * -canvas.height;
    }
    
    // Colors for the matrix effect
    const colors = [
      'rgba(0, 255, 0, 1)',   // Bright green
      'rgba(0, 210, 0, 0.8)', // Medium green
      'rgba(0, 180, 0, 0.6)', // Lighter green
      'rgba(157, 0, 255, 1)',  // Purple
      'rgba(0, 162, 255, 1)'   // Blue
    ];
    
    // Main drawing function
    function draw() {
      // Black background with alpha for trails
      ctx.fillStyle = 'rgba(0, 0, 0, 0.04)';
      ctx.fillRect(0, 0, canvas.width, canvas.height);
      
      // Set font properties
      ctx.font = `${fontSize}px monospace`;
      
      // Drawing the characters
      for (let i = 0; i < drops.length; i++) {
        // Random character to print
        const char = charArray[Math.floor(Math.random() * charArray.length)];
        
        // Random color from our colors array
        const colorIndex = Math.floor(Math.random() * colors.length);
        ctx.fillStyle = colors[colorIndex];
        
        // x = i * fontSize, y = drops[i] * fontSize
        ctx.fillText(char, i * fontSize, drops[i] * 1);
        
        // Sending the drop back to the top randomly after it has crossed the screen
        // Adding randomness to the reset to make the drops scattered
        if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) {
          drops[i] = 0;
        }
        
        // Incrementing Y coordinate
        drops[i]++;
      }
    }
    
    // Animation loop
    const interval = setInterval(draw, 35);
    
    // Cleanup
    return () => {
      clearInterval(interval);
      window.removeEventListener('resize', resizeCanvas);
    };
  }, []);

  return (
    <canvas 
      ref={canvasRef} 
      className="fixed top-0 left-0 w-full h-full z-0 opacity-30"
      style={{ pointerEvents: 'none' }}
    />
  );
};

export default MatrixRainBackground;