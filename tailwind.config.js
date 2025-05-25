/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
        mono: ['Inconsolata', 'monospace'],
      },
      colors: {
        green: {
          400: '#4ade80',
          500: '#00ff00',
        },
        blue: {
          400: '#60a5fa',
          500: '#00a2ff',
        },
        purple: {
          400: '#c084fc',
          500: '#9d00ff',
        },
      },
      animation: {
        'fadeIn': 'fadeIn 1s ease-in-out',
        'slideInFromLeft': 'slideInFromLeft 1s ease-in-out',
        'slideInFromRight': 'slideInFromRight 1s ease-in-out',
        'slideInFromBottom': 'slideInFromBottom 1s ease-in-out',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideInFromLeft: {
          '0%': { transform: 'translateX(-100%)', opacity: '0' },
          '100%': { transform: 'translateX(0)', opacity: '1' },
        },
        slideInFromRight: {
          '0%': { transform: 'translateX(100%)', opacity: '0' },
          '100%': { transform: 'translateX(0)', opacity: '1' },
        },
        slideInFromBottom: {
          '0%': { transform: 'translateY(50px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
      },
      backgroundImage: {
        'cyber-grid': "radial-gradient(rgba(0, 255, 0, 0.1) 1px, transparent 1px)",
      },
    },
  },
  plugins: [],
};