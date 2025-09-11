const en = {
  // Navigation
  nav: {
    home: "Home",
    promises: "Promises",
    timeline: "Timeline",
    chat: "Chat",
    quiz: "Quiz",
    blog: "Blog",
    resources: "Resources",
    about: "About"
  },
  
  // Hero Section
  hero: {
    title: "Jesus is the Bread of Life",
    subtitle: "Find peace, hope and guidance in the eternal promises of Jesus Christ",
    cta_primary: "Explore Promises",
    cta_secondary: "Start Chat"
  },
  
  // Main sections
  sections: {
    promises_title: "Divine Promises",
    promises_subtitle: "Verses that transform lives",
    timeline_title: "Biblical Journey",
    timeline_subtitle: "From Creation to Revelation",
    resources_title: "Christian Resources",
    chat_title: "Spiritual Chat",
    chat_subtitle: "Find verses for your moments"
  },
  
  // Chat
  chat: {
    placeholder: "Type your question or situation...",
    send: "Send",
    thinking: "Seeking guidance...",
    no_response: "Sorry, I couldn't find a specific answer. How about exploring our promises?"
  },
  
  // Newsletter
  newsletter: {
    title: "Receive Daily Verses",
    subtitle: "Subscribe and receive a promise from Jesus every day",
    name_placeholder: "Your name",
    email_placeholder: "Your email",
    whatsapp_placeholder: "WhatsApp (optional)",
    subscribe: "Subscribe",
    success: "Successfully subscribed!",
    error: "Error processing subscription. Please try again."
  },
  
  // Footer
  footer: {
    tagline: "Sharing Christ's love through His promises",
    links: "Useful Links",
    contact: "Contact",
    social: "Social Media"
  }
};

// Export for global use
if (typeof module !== 'undefined' && module.exports) {
  module.exports = en;
} else {
  window.translations = window.translations || {};
  window.translations.en = en;
}
