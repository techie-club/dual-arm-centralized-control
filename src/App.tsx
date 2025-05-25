import React from 'react';
import Navbar from './components/Navbar';
import Hero from './components/Hero';
import About from './components/About';
import Courses from './components/Courses';
import Internship from './components/Internship';
import Membership from './components/Membership';
import Portfolio from './components/Portfolio';
import Contact from './components/Contact';
import Footer from './components/Footer';
import MatrixRainBackground from './components/MatrixRainBackground';

function App() {
  return (
    <div className="relative min-h-screen bg-gray-900 text-gray-100 overflow-hidden">
      <MatrixRainBackground />
      <div className="relative z-10">
        <Navbar />
        <main>
          <section id="home">
            <Hero />
          </section>
          <section id="about" className="py-20">
            <About />
          </section>
          <section id="courses" className="py-20 bg-gray-900/60 backdrop-blur-sm">
            <Courses />
          </section>
          <section id="internship" className="py-20">
            <Internship />
          </section>
          <section id="membership" className="py-20 bg-gray-900/60 backdrop-blur-sm">
            <Membership />
          </section>
          <section id="portfolio" className="py-20">
            <Portfolio />
          </section>
          <section id="contact" className="py-20 bg-gray-900/60 backdrop-blur-sm">
            <Contact />
          </section>
        </main>
        <Footer />
      </div>
    </div>
  );
}

export default App;