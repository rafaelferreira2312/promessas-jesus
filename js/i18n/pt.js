const pt = {
  // Navegação
  nav: {
    home: "Início",
    promises: "Promessas",
    timeline: "Linha do Tempo",
    chat: "Chat",
    quiz: "Quiz",
    blog: "Blog",
    resources: "Recursos",
    about: "Sobre"
  },
  
  // Seção Hero
  hero: {
    title: "Jesus é o Pão da Vida",
    subtitle: "Encontre paz, esperança e orientação nas promessas eternas de Jesus Cristo",
    cta_primary: "Explorar Promessas",
    cta_secondary: "Iniciar Chat"
  },
  
  // Seções principais
  sections: {
    promises_title: "Promessas Divinas",
    promises_subtitle: "Versículos que transformam vidas",
    timeline_title: "Jornada Bíblica",
    timeline_subtitle: "Da Criação ao Apocalipse",
    resources_title: "Recursos Cristãos",
    chat_title: "Chat Espiritual",
    chat_subtitle: "Encontre versículos para seus momentos"
  },
  
  // Chat
  chat: {
    placeholder: "Digite sua pergunta ou situação...",
    send: "Enviar",
    thinking: "Buscando orientação...",
    no_response: "Desculpe, não encontrei uma resposta específica. Que tal explorar nossas promessas?"
  },
  
  // Newsletter
  newsletter: {
    title: "Receba Versículos Diários",
    subtitle: "Cadastre-se e receba uma promessa de Jesus todos os dias",
    name_placeholder: "Seu nome",
    email_placeholder: "Seu email",
    whatsapp_placeholder: "WhatsApp (opcional)",
    subscribe: "Inscrever-se",
    success: "Inscrição realizada com sucesso!",
    error: "Erro ao processar inscrição. Tente novamente."
  },
  
  // Footer
  footer: {
    tagline: "Compartilhando o amor de Cristo através de Suas promessas",
    links: "Links Úteis",
    contact: "Contato",
    social: "Redes Sociais"
  }
};

// Exportar para uso global
if (typeof module !== 'undefined' && module.exports) {
  module.exports = pt;
} else {
  window.translations = window.translations || {};
  window.translations.pt = pt;
}
