import React, { useState } from 'react';
import { Phone, Mail, Send, MessageSquare, Instagram, Facebook } from 'lucide-react';

const Contact: React.FC = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    message: ''
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Normally would send data to server
    console.log('Form submitted:', formData);
    alert('Message sent! We\'ll get back to you soon.');
    setFormData({ name: '', email: '', message: '' });
  };

  return (
    <div className="container mx-auto px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto text-center mb-16">
        <h2 className="text-3xl md:text-4xl font-bold mb-4 text-glow-blue">
          Contact Us
        </h2>
        <div className="w-24 h-1 bg-blue-500 mx-auto mb-8"></div>
        <p className="text-gray-300 mb-8">
          Have questions? Reach out to us through any of these channels
        </p>
      </div>
      
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
        <div>
          <form onSubmit={handleSubmit} className="glass-card-blue p-8">
            <h3 className="text-2xl font-bold mb-6 text-center">Send a Message</h3>
            
            <div className="mb-6">
              <label htmlFor="name" className="block text-gray-300 mb-2">Your Name</label>
              <input
                type="text"
                id="name"
                name="name"
                value={formData.name}
                onChange={handleChange}
                required
                className="neon-input-blue w-full"
                placeholder="Enter your name"
              />
            </div>
            
            <div className="mb-6">
              <label htmlFor="email" className="block text-gray-300 mb-2">Your Email</label>
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                required
                className="neon-input-blue w-full"
                placeholder="Enter your email"
              />
            </div>
            
            <div className="mb-6">
              <label htmlFor="message" className="block text-gray-300 mb-2">Message</label>
              <textarea
                id="message"
                name="message"
                value={formData.message}
                onChange={handleChange}
                required
                rows={5}
                className="neon-input-blue w-full"
                placeholder="Your message here..."
              ></textarea>
            </div>
            
            <button type="submit" className="btn-neon-blue w-full flex items-center justify-center">
              <Send className="h-4 w-4 mr-2" />
              Send Message
            </button>
          </form>
        </div>
        
        <div className="space-y-8">
          <div className="glass-card p-8">
            <h3 className="text-2xl font-bold mb-6">Get in Touch</h3>
            
            <div className="space-y-6">
              <div className="flex items-start">
                <div className="bg-blue-900/30 p-3 rounded-full mr-4 text-blue-400">
                  <Phone className="h-6 w-6" />
                </div>
                <div>
                  <h4 className="text-lg font-medium mb-1">Phone</h4>
                  <p className="text-gray-300">+91 8428792819</p>
                </div>
              </div>
              
              <div className="flex items-start">
                <div className="bg-purple-900/30 p-3 rounded-full mr-4 text-purple-400">
                  <Mail className="h-6 w-6" />
                </div>
                <div>
                  <h4 className="text-lg font-medium mb-1">Email</h4>
                  <p className="text-gray-300">techiecluboffl@gmail.com</p>
                </div>
              </div>
              
              <div className="flex items-start">
                <div className="bg-green-900/30 p-3 rounded-full mr-4 text-green-400">
                  <MessageSquare className="h-6 w-6" />
                </div>
                <div>
                  <h4 className="text-lg font-medium mb-1">WhatsApp</h4>
                  <p className="text-gray-300">
                    <a 
                      href="https://wa.me/918428792819" 
                      target="_blank" 
                      rel="noopener noreferrer"
                      className="text-green-400 hover:text-green-300 transition-colors"
                    >
                      Message us on WhatsApp
                    </a>
                  </p>
                </div>
              </div>
            </div>
          </div>
          
          <div className="glass-card p-8">
            <h3 className="text-xl font-bold mb-6">Connect With Us</h3>
            
            <div className="flex flex-col space-y-4">
              <a 
                href="https://instagram.com/techie._.club" 
                target="_blank" 
                rel="noopener noreferrer"
                className="flex items-center p-3 bg-gray-800/50 rounded-lg hover:bg-pink-900/20 transition-colors"
              >
                <Instagram className="h-6 w-6 text-pink-400 mr-3" />
                <span>@techie._.club</span>
              </a>
              
              <a 
                href="https://facebook.com/techie._.club" 
                target="_blank" 
                rel="noopener noreferrer"
                className="flex items-center p-3 bg-gray-800/50 rounded-lg hover:bg-blue-900/20 transition-colors"
              >
                <Facebook className="h-6 w-6 text-blue-400 mr-3" />
                <span>@techie._.club</span>
              </a>
            </div>
          </div>
          
          <div className="p-6 border border-blue-500/30 rounded-lg text-center bg-blue-500/5">
            <h4 className="text-lg font-medium mb-2">Operating Hours</h4>
            <p className="text-gray-300">
              Monday - Saturday: 9:00 AM - 6:00 PM<br />
              Sunday: Online Support Only
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Contact;